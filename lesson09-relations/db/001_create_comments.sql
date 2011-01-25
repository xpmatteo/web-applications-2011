
create table comments (
  comment_id  int not null auto_increment,
  quote_id    int references quotes(quote_id),
  body        text not null,
  author      varchar(255) not null,
  created_at  datetime not null,
  author_url  varchar(255),
  primary key(comment_id)
) engine InnoDB;

update schema_info set version = 1;
  