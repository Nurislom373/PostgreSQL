create schema auth;
create schema system;
create schema project;
create schema task;
create schema buildIns;
create schema validators;
create schema enums;
create schema dto;
create schema mappers;
create schema utils;

create extension citext;

create table system.language
(
    id         serial primary key,
    code       varchar(2) unique  not null,
    name       varchar(50) unique not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table auth.auth_role
(
    id         serial primary key,
    code       varchar(255) unique not null,
    name       varchar(255) unique not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create type status AS ENUM ('Active', 'No_active');

create table auth.auth_user
(
    id              serial primary key,
    code            uuid      default gen_random_uuid(),
    first_name      varchar(100)        not null,
    last_name       varchar(100)        not null,
    email           varchar(255) unique not null,
    username        varchar(120) unique not null,
    password        text                not null,
    language        varchar(2) references system.language (code),
    role            varchar references auth.auth_role (code),
    status          status              not null,
    profile_pic     text,
    last_login_at   timestamp,
    login_try_count integer   default 0,
    is_deleted      boolean   default false,
    created_by      integer   default -1,
    created_at      timestamp default now(),
    updated_by      integer,
    updated_at      timestamp
);

create table system.blocked_for
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    name       varchar unique not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table auth.auth_block
(
    id               serial primary key,
    code             uuid      default gen_random_uuid(),
    user_code        uuid references auth.auth_user (code)     not null,
    duration         timestamp                                 not null,
    blocked_for_code uuid references system.blocked_for (code) not null,
    is_deleted       boolean   default false,
    created_by       integer   default -1,
    created_at       timestamp default now(),
    updated_by       integer,
    updated_at       timestamp
);

create domain is_valid_email as citext
    check (
        VALUE ~ '^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$'
        );