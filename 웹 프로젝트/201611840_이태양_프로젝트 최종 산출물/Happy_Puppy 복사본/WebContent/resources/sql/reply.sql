create table if not exists reply(
replyID int(2),
userID varchar(20),
bbsID int(2),
replyDate date,
replyContent varchar(200)


)default charset=utf8;