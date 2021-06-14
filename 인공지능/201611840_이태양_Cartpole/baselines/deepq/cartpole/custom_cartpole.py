import gym
import time
import sys
import itertools
import numpy as np
import tensorflow as tf
import tensorflow.contrib.layers as layers
import baselines.common.tf_util as U
from baselines import logger
from baselines import deepq
from baselines.deepq.replay_buffer import ReplayBuffer
from baselines.deepq.utils import ObservationInput
from baselines.common.schedules import LinearSchedule



start = time.time()
def model(inpt, num_actions, scope, reuse=False):
    """이 모델은 observation을 입력값으로 넣고 모든 행동에 대해 값을 리턴한다."""
    with tf.variable_scope(scope, reuse=reuse):
        out = inpt

        ### num_outputs 값 을 수정하여 fully connected 되어지는 hidden layers의 층을 각각 다르게 입력하여 준다(layer가 과도하게 커지면 기존의 입력이 약해질 수 있다 또한 너무 작으면 학습이 제대로 수행되지 않을 수 있다.)
        out = layers.fully_connected(out, num_outputs=64, activation_fn=tf.nn.tanh)
        ################

        out = layers.fully_connected(out, num_outputs=num_actions, activation_fn=None)
        return out


if __name__ == '__main__':
    with U.make_session(num_cpu=1):
        # Cartpole을 학습 시키기 위한 환경을 생성 한다.
        env = gym.make("CartPole-v0")
        # Cartpole을 학습 시킬때 필요한 기능 등을 setting 한다.
        act, train, update_target, debug = deepq.build_train(
            make_obs_ph=lambda name: ObservationInput(env.observation_space, name=name),
            q_func=model,
            num_actions=env.action_space.n,
            optimizer=tf.train.AdamOptimizer(learning_rate=5e-4),
        )
        # 학습을 돌렸을경우 저장할 버퍼를 만들어준다
        replay_buffer = ReplayBuffer(50000)
        # 처음부터 랜덤으로 모델이 예측한 값에 따라 98%가 선택되어서 탐색 스케줄을 생성한다
        exploration = LinearSchedule(schedule_timesteps=10000, initial_p=1.0, final_p=0.02)

        # parameters들을 초기화 시키고 저장하여 target network에 입력한다.
        U.initialize()
        update_target()
        reward_list = []  ###입력에 따른 reward 파일을 list자료구조를 통하여 저장한다.
        episode_rewards = [0.0]
        obs = env.reset()
        for t in itertools.count():
            # action을 수행한 후에 그리고 update된 값을 새롭게 저장한다.
            action = act(obs[None], update_eps=exploration.value(t))[0]
            new_obs, rew, done, _ = env.step(action)
            # replay buffer에 transition한 결과를 저장한다.
            replay_buffer.add(obs, action, rew, new_obs, float(done))
            reward_list.append(rew)  ###list에 reward값을 저장한다.
            obs = new_obs

            episode_rewards[-1] += rew
            if done:
                obs = env.reset()
                episode_rewards.append(0)

                ###Reward 파일을 저장하여 reward 그래프를 생성할때 필요한 txt파일을 생성한다.
                with open("../../FILENAME1.txt", "a") as f:
                    f.write(str(sum(reward_list)) + "\n")
                reward_list = []  ###init reward list

            is_solved = t > 100 and np.mean(episode_rewards[-101:-1]) >= 200
            is_finished = len(episode_rewards) > 2000 and is_solved

            if is_solved:
                if len(episode_rewards) > 1998:
                    # 결과를 보여준다.
                    env.render()
                if is_finished:
                    print("time :", time.time() - start)
                    sys.exit(0)

            else:
                # Minimize the error in Bellman's equation on a batch sampled from replay buffer.
                if t > 1000:
                    ###Replay Buffer Sample 수 수정(16, 32, 64)
                    obses_t, actions, rewards, obses_tp1, dones = replay_buffer.sample(32)
                    ################
                    train(obses_t, actions, rewards, obses_tp1, dones, np.ones_like(rewards))

                # Update target을 하는 이유는 Target network를 통하여 parameter를 고정을 통하여 그에 따른 영향을 받지 않게 설정하여 보다 안정적으로 계산하기 위해서이다.
                # Target Update의 주기를 설정 한다 (250, 500, 1000)
                if t % 1000 == 0:
                    #################
                    update_target()

            if done and len(episode_rewards) % 10 == 0:
                logger.record_tabular("steps", t)
                logger.record_tabular("episodes", len(episode_rewards))
                logger.record_tabular("mean episode reward", round(np.mean(episode_rewards[-101:-1]), 1))
                logger.record_tabular("% time spent exploring", int(100 * exploration.value(t)))
                logger.dump_tabular()
