create procedure utils.is_active(t_user_code uuid) as
$$
declare
    e_user    auth.auth_user;
    lang_code varchar;
begin
    lang_code = utils.from_uuid_get_language_code(t_user_code);

    if t_user_code is null then
        raise exception '% - t_user_code', system.translate('INVALID_PARAMETER', lang_code);
    end if;

    select * into e_user from auth.auth_user where not is_deleted and code = t_user_code;

    if FOUND is null then
        raise exception '%', system.translate('NOT_FOUND', lang_code);
    end if;

    if e_user.status <> 'Active' then
        raise exception '%', system.translate('USER_NOT_ACTIVE', lang_code);
    end if;
end;
$$ language plpgsql;

create procedure utils.has_role_admin(t_user_code uuid) as
$$
declare
    e_user    auth.auth_user;
    lang_code varchar;
begin
    lang_code = utils.from_uuid_get_language_code(t_user_code);

    if t_user_code is null then
        raise exception '% - t_user_code', system.translate('INVALID_PARAMETER', lang_code);
    end if;

    select * into e_user from auth.auth_user where not is_deleted and code = t_user_code;

    if FOUND is null then
        raise exception '%', system.translate('NOT_FOUND', lang_code);
    end if;

    if e_user.role <> 'ADMIN' then
        raise exception '%', system.translate('USER_ROLE_IS_NOT_ADMIN', lang_code);
    end if;
end;
$$ language plpgsql;

create function utils.from_uuid_get_language_code(t_user_code uuid) returns varchar as
$$
declare
    e_user auth.auth_user;
begin
    if t_user_code is null then
        raise exception '%', system.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into e_user from auth.auth_user where not is_deleted and code = t_user_code;

    if FOUND is null then
        raise exception '%', system.translate('NOT_FOUND', 'UZ');
    end if;

    return e_user.language;
end;
$$ language plpgsql;

create procedure system.log_type_create(t_code varchar, t_name varchar, t_user_code uuid,
                                        INOUT t_result text DEFAULT ''::text) as
$$
declare
    new_id    integer;
    lang_code varchar;
begin
    call utils.is_active(t_user_code);
    lang_code = utils.from_uuid_get_language_code(t_user_code);

    if t_code is null then
        raise exception '% - t_code', system.translate('INVALID_PARAMETER', lang_code);
    end if;

    if t_name is null then
        raise exception '% - t_name', system.translate('INVALID_PARAMETER', lang_code);
    end if;

    insert into system.log_type (code, name) values (t_code, t_name) returning id into new_id;
    t_result = 'id = ' || new_id;
end;
$$ language plpgsql;

create procedure system.log_type_delete(t_id integer, t_user_code uuid, INOUT t_result text DEFAULT ''::text) as
$$
declare
    e_log_type auth.auth_user;
    lang_code  varchar;
begin
    call utils.is_active(t_user_code);
    lang_code = utils.from_uuid_get_language_code(t_user_code);

    if t_id is null then
        raise exception '%', system.translate('INVALID_PARAMETER', lang_code);
    end if;

    select * into e_log_type from system.log_type where not is_deleted and id = t_id;

    if FOUND is null then
        raise exception '%', system.translate('NOT_FOUND', lang_code);
    end if;

    update system.log_type set is_deleted = true, updated_at = now(), updated_by = e_log_type.id where id = t_id;
    t_result = 'delete id with ' || t_id;
end;
$$ language plpgsql;

create or replace function system.log_type_list(t_user_code uuid) returns text as
$$
declare
    json_log_type  jsonb;
    json_log_types jsonb = '[]';
    t_log_type     system.log_type%rowtype;
    lang_code      varchar;
begin
    call utils.is_active(t_user_code);
    lang_code = utils.from_uuid_get_language_code(t_user_code);
    call utils.has_role_admin(t_user_code);

    for t_log_type in (select * from system.log_type where not is_deleted)
        loop
            json_log_type = jsonb_build_object('id', t_log_type.id);
            json_log_type = json_log_type || jsonb_build_object('code', t_log_type.code);
            json_log_type = json_log_type || jsonb_build_object('name', t_log_type.name);
            json_log_types = json_log_types || json_log_type;
        end loop;

    return json_log_types::text;
end;
$$ language plpgsql;

select system.log_type_list('85db893f-344b-4773-858b-59c21b615d5d');

create procedure system.log_insert(log_body text, type varchar) as
$$
begin
    insert into system.log(message, log_type) values (log_body, type);
end;
$$ language plpgsql;

create function system.translate(message_code text, language_code character) returns text as
$$
declare
    t_language system.language%rowtype;
    t_message  system.message%rowtype;
begin
    if message_code is null then
        raise exception '% - message_code', system.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if language_code is null then
        raise exception '% - language_code', system.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_language from system.language where not is_deleted and code = language_code;

    if t_language is null then
        raise exception '%', system.translate('LANGUAGE_NOT_FOUND', 'UZ');
    end if;

    select *
    into t_message
    from system.message as ms
    where not ms.is_deleted
      and ms.message = message_code
      and ms.code = language_code;

    if t_message is null then
        raise exception '%', system.translate('MESSAGE_CODE_NOT_FOUND', 'UZ');
    else
        return t_message.message;
    end if;

end;
$$ language plpgsql;

call system.log_type_create('WARNING', 'Warning', '85db893f-344b-4773-858b-59c21b615d5d');

insert into auth.auth_role (code, name)
values ('ADMIN', 'Admin');

insert into system.language (code, name)
values ('EN', 'English');

insert into auth.auth_user (first_name, last_name, email, username, password, language, role, status)
values ('Nurislom', 'Xasanov', 'khasanof373@gmail.com', 'khasanof', '123', 'EN', 'ADMIN', 'Active');

create procedure utils.check_data(data text) as
$$
begin
    if data is null or '{}'::text = data or '' = data then
        raise exception '%', system.translate('INVALID_PARAMETER', 'UZ');
    end if;
end;
$$ language plpgsql;

create type dto.auth_create_dto as
(
    first_name  varchar,
    last_name   varchar,
    email       varchar,
    username    varchar,
    password    varchar,
    language    varchar,
    role        varchar,
    status      varchar,
    profile_pic varchar
);

create function mappers.to_create_auth_dto(dataJson json) returns dto.auth_create_dto as
$$
declare
    dto dto.auth_create_dto;
begin
    dto.first_name = dataJson ->> 'first_name';
    dto.last_name = dataJson ->> 'last_name';
    dto.email = dataJson ->> 'email';
    dto.username = dataJson ->> 'username';
    dto.password = dataJson ->> 'password';
    dto.language = dataJson ->> 'language';
    dto.role = dataJson ->> 'role';
    dto.status = dataJson ->> 'status';
    dto.profile_pic = dataJson ->> 'profile_pic';
    return dto;
end;
$$ language plpgsql;

create procedure validators.check_auth_create_dto(INOUT dto dto.auth_create_dto) as
$$
declare
    t_language system.language;
    t_role     auth.auth_role;
begin
    if dto.first_name is null then
        raise exception '% first_name', system.translate('IS_REQUIRED_TO_REGISTER', 'UZ');
    end if;

    if dto.last_name is null then
        raise exception '% last_name', system.translate('IS_REQUIRED_TO_REGISTER', 'UZ');
    end if;

    if dto.username is null then
        raise exception '% username', system.translate('IS_REQUIRED_TO_REGISTER', 'UZ');
    end if;

    if dto.email is null then
        raise exception '% first_name', system.translate('IS_REQUIRED_TO_REGISTER', 'UZ');
    else
        if not exists(select dto.email::is_valid_email) then
            raise exception '% email', system.translate('EMAIL_IS_INVALID', 'UZ');
        end if;
    end if;

    if dto.username is null then
        raise exception '% first_name', system.translate('IS_REQUIRED_TO_REGISTER', 'UZ');
    else
        if length(dto.username) <= 4 then
            raise exception 'username min size 4 -> %', dto.username;
        end if;
    end if;

    if dto.language is null then
        dto.language = 'EN';
    else
        select * into t_language from system.language where not is_deleted and code = dto.language;
        if not FOUND then
            raise exception '%', system.translate('LANGUAGE_NOT_FOUND', 'UZ');
        end if;
    end if;

    if dto.role is null then
        dto.role = 'USER';
    else
        select * into t_role from auth.auth_role where not is_deleted and code = dto.role;
        if not FOUND then
            raise exception '%', system.translate('ROLE_NOT_FOUND', 'UZ');
        end if;
    end if;

    if dto.status is null then
        dto.status = 'Active';
    end if;

end;
$$ language plpgsql;

create extension pgcrypto schema buildins;

create function utils.password_encoder(password varchar) returns varchar as
$$
begin
    return buildins.crypt(password, buildIns.gen_salt('bf', 4));
end;
$$ language plpgsql;

create or replace function auth.auth_register(data text) returns text as
$$
declare
    dataJson    json;
    auth        dto.auth_create_dto;
    return_code uuid;
begin
    call utils.check_data(data);
    dataJson = (data::json);
    auth = mappers.to_create_auth_dto(dataJson);
    call validators.check_auth_create_dto(auth);

    insert into auth.auth_user (first_name, last_name, email, username, password, language, role, status, profile_pic)
    values (auth.first_name, auth.last_name, auth.email, auth.username, utils.password_encoder(auth.password),
            auth.language, auth.role, auth.status::status, auth.profile_pic)
    returning code into return_code;

    call system.log_insert('create function auth.auth_register(data text) returns text as', 'INFO');

    return return_code::text;
end;
$$ language plpgsql;

create function utils.match_password(password character varying, encode_password character varying) returns boolean
    parallel safe
as
$$
begin
    return encode_password = buildins.crypt(password, encode_password);
end;
$$ language plpgsql;

create extension "uuid-ossp" schema buildins;

create or replace function auth.auth_login(p_username_or_email character varying, p_password character varying) returns text as
$$
declare
    t_user            auth.auth_user;
    t_auth_block      auth.auth_block;
    v_login_try_count integer default 0;
    t_token           auth.auth_token;
    v_response        jsonb;
begin
    if p_username_or_email is null then
        call system.log_insert(
                    'function auth.auth_login with username or email ' + system.translate('PARAMETER_IS_NULL', 'UZ'),
                    'ERROR');
        raise exception 'username %', system.translate('PARAMETER_IS_NULL', 'UZ');
    end if;

    if p_password is null then
        call system.log_insert('function auth.auth_login with password ' + system.translate('PARAMETER_IS_NULL', 'UZ'),
                               'ERROR');
        raise exception 'password %', system.translate('PARAMETER_IS_NULL', 'UZ');
    end if;

    select *
    into t_user
    from auth.auth_user
    where not is_deleted
      and (username = p_username_or_email or email = p_username_or_email);

    if not FOUND then
        call system.log_insert('function auth.auth_login with user not found', 'ERROR');
        raise exception '%', system.translate('USER_NOT_FOUND', 'UZ');
    end if;

    select *
    into t_auth_block
    from auth.auth_block
    where not is_deleted
      and user_code = t_user.code
      and duration > current_timestamp
    order by duration desc
    limit 1;

    if FOUND then
        call system.log_insert('function auth.auth_login with user is blocked', 'ERROR');
        raise exception '%', system.translate('USER_IS_BLOCKED', 'UZ');
    end if;

    if not utils.match_password(p_password, t_user.password) then
        update auth.auth_user
        set login_try_count = login_try_count + 1
        where not is_deleted
          and code = t_user.code
        returning login_try_count into v_login_try_count;
        if v_login_try_count = 3 then
            insert into auth.auth_block (user_code, duration, blocked_for_code)
            values (t_user.code, current_timestamp + interval '15 min', '44641dbc-0d6a-4481-a653-789bbdf3bc2c');
        end if;
        call system.log_insert('function auth.auth_login with match password fail', 'ERROR');
        raise exception '%', system.translate('BAD_CREDENTIALS', 'UZ');
    end if;

    if t_user.status <> 'Active' then
        call system.log_insert('function auth.auth_login with user status not active', 'ERROR');
        raise exception '%', system.translate('USER_NOT_ACTIVE', 'UZ');
    end if;

    insert into auth.auth_token (user_code) values (t_user.code) returning * into t_token;

    insert into auth.auth_session (user_code, token_code, username)
    values (t_user.code, t_token.token, t_user.username);

    update auth.auth_user
    set login_try_count = 0,
        last_login_at   = current_timestamp
    where not is_deleted
      and code = t_user.code;

    v_response = jsonb_build_object('code', t_user.code);
    v_response = v_response || jsonb_build_object('token', t_token.token);
    v_response = v_response || jsonb_build_object('username', t_user.username);
    v_response = v_response || jsonb_build_object('email', t_user.email);

    call system.log_insert(
            'create or replace function auth.auth_login(p_username_or_email character varying, p_password character varying) returns text as',
            'INFO');
    return v_response::text;
end;
$$ language plpgsql;

select auth.auth_register('{
  "first_name" : "Tom",
  "last_name" : "Tomvich",
  "email" : "tom345@gmail.com",
  "username" : "tomvich456",
  "password" : "123",
  "language" : "EN",
  "role" : "USER"
}');
