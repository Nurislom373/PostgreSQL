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

-- auth schema tables

create domain is_valid_email as citext
    check (
        VALUE ~ '^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$'
        );

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

create table auth.card_type
(
    id         serial primary key,
    code       varchar unique not null,
    name       varchar        not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table auth.auth_card
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    user_code  uuid references auth.auth_user (code),
    type       varchar references auth.card_type (code),
    holderName varchar not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table auth.auth_token
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    user_code  uuid references auth.auth_user (code),
    token      varchar   not null,
    duration   timestamp not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table auth.auth_session
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    user_code  uuid references auth.auth_user (code),
    token_code uuid references auth.auth_token (code),
    username   varchar not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

-- project schema tables

create type org_status AS ENUM ('Active', 'No_Active', 'Block');

create table project.organization
(
    id          serial primary key,
    code        uuid      default gen_random_uuid(),
    name        varchar unique not null,
    status      org_status     not null,
    description text,
    email       varchar unique not null,
    logo_path   text,
    is_deleted  boolean   default false,
    created_by  integer   default -1,
    created_at  timestamp default now(),
    updated_by  integer,
    updated_at  timestamp
);

CREATE TYPE project_status AS ENUM ('Active', 'No_Active', 'Block', 'Archive');

create table project.project
(
    id             serial primary key,
    code           uuid           default gen_random_uuid(),
    org_code       uuid references project.organization (code),
    name           varchar(255)                       not null,
    description    text,
    status         project_status DEFAULT 'No_Active' NOT NULL,
    background_pic TEXT,
    is_deleted     boolean        default false,
    created_by     integer        default -1,
    created_at     timestamp      default now(),
    updated_by     integer,
    updated_at     timestamp

);

CREATE TABLE project.project_column
(
    id           serial primary key,
    code         uuid           default gen_random_uuid(),
    project_code uuid references project.project (code),
    name         varchar unique                     not null,
    status       project_status DEFAULT 'No_Active' NOT NULL,
    is_deleted   boolean        default false,
    created_by   integer        default -1,
    created_at   timestamp      default now(),
    updated_by   integer,
    updated_at   timestamp
);

CREATE TABLE project.project_member
(
    id           serial primary key,
    code         uuid      default gen_random_uuid(),
    user_code    uuid references auth.auth_user (code),
    project_code uuid references project.project (code),
    role         varchar references auth.auth_role (code),
    is_deleted   boolean   default false,
    created_by   integer   default -1,
    created_at   timestamp default now(),
    updated_by   integer,
    updated_at   timestamp
);

-- task schema tables

create table system.priority
(
    id         serial primary key,
    code       varchar unique not null,
    name       varchar unique not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp

);

create table task.task
(
    id           serial primary key,
    code         uuid      default gen_random_uuid(),
    project_code uuid references project.project (code),
    column_code  uuid references project.project_column (code),
    name         varchar not null,
    level        varchar references system.priority (code),
    description  text,
    archive      boolean   default false,
    completed    boolean   default false,
    is_deleted   boolean   default false,
    created_by   integer   default -1,
    created_at   timestamp default now(),
    updated_by   integer,
    updated_at   timestamp
);

create table task.task_comment
(
    id                 serial primary key,
    code               uuid      default gen_random_uuid(),
    user_code          uuid references auth.auth_user (code),
    task_code          uuid references task.task (code),
    reply_comment_code uuid references task.task_comment (code),
    comment            text not null,
    is_deleted         boolean   default false,
    created_by         integer   default -1,
    created_at         timestamp default now(),
    updated_by         integer,
    updated_at         timestamp
);

create table task.task_member
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    user_code  uuid references auth.auth_user (code),
    task_code  uuid references task.task (code),
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table system.color
(
    id         serial primary key,
    code       varchar unique not null,
    name       varchar unique not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table task.task_label
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    task_code  uuid references task.task (code),
    name       varchar not null,
    color      varchar references system.color (code),
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table task.task_checklist
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    task_code  uuid references task.task (code),
    name       varchar not null,
    completed  boolean   default false,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table task.checklist_item
(
    id             serial primary key,
    code           uuid      default gen_random_uuid(),
    checklist_code uuid references task.checklist_item (code),
    name           varchar unique not null,
    completed      boolean   default false,
    is_deleted     boolean   default false,
    created_by     integer   default -1,
    created_at     timestamp default now(),
    updated_by     integer,
    updated_at     timestamp

);

create table task.task_cover
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    task_code  uuid references task.task (code),
    color      varchar references system.color (code),
    size_full  boolean   default false,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

create table task.task_due_date
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    task_code  uuid references task.task (code),
    start_date timestamp default now(),
    due_date   timestamp,
    before     varchar not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);

-- system schema tables

create table system.comment
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    user_code  uuid references auth.auth_user (code),
    message    text not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp

);

create table system.log_type
(
    id         serial primary key,
    code       varchar unique not null,
    name       varchar unique not null,
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp

);

create table system.log
(
    id         serial primary key,
    code       uuid      default gen_random_uuid(),
    message    varchar not null,
    user_code  uuid references auth.auth_user (code),
    log_type   varchar references system.log_type (code),
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);


create table system.message
(
    id         serial primary key,
    message    varchar        not null,
    code       varchar unique not null,
    language   varchar references system.language (code),
    is_deleted boolean   default false,
    created_by integer   default -1,
    created_at timestamp default now(),
    updated_by integer,
    updated_at timestamp
);
