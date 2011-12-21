create table sessions (
  session_id int not null,
  user_id int null,
  created_at datetime,
  primary key(session_id)
) Engine InnoDB;

update schema_info set version = 2;
