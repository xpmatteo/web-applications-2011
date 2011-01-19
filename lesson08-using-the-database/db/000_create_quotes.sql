
create table quotes (
  quote_id int auto_increment,
  author varchar(255),
  body text,
  primary key(quote_id)
) engine InnoDB;

