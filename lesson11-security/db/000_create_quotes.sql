
create table quotes (
  quote_id int auto_increment,
  author varchar(255),
  body text,
  primary key(quote_id)
) engine InnoDB;

create table schema_info (
  version int not null
);

insert into schema_info (version) values (0);
