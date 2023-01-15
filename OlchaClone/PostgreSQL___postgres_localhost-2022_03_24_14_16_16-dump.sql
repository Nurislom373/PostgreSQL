--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5
-- Dumped by pg_dump version 13.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO postgres;

--
-- Name: buildins; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA buildins;


ALTER SCHEMA buildins OWNER TO postgres;

--
-- Name: checks; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA checks;


ALTER SCHEMA checks OWNER TO postgres;

--
-- Name: dto; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dto;


ALTER SCHEMA dto OWNER TO postgres;

--
-- Name: enums; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA enums;


ALTER SCHEMA enums OWNER TO postgres;

--
-- Name: mappers; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mappers;


ALTER SCHEMA mappers OWNER TO postgres;

--
-- Name: project; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA project;


ALTER SCHEMA project OWNER TO postgres;

--
-- Name: settings; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA settings;


ALTER SCHEMA settings OWNER TO postgres;

--
-- Name: system; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA system;


ALTER SCHEMA system OWNER TO postgres;

--
-- Name: utils; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA utils;


ALTER SCHEMA utils OWNER TO postgres;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA buildins;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: auth_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.auth_create_dto AS (
	username character varying,
	password character varying,
	email character varying,
	phone character(13),
	profile_pic text,
	chat_id integer,
	language character varying,
	location point,
	role character varying(30),
	permission json
);


ALTER TYPE dto.auth_create_dto OWNER TO postgres;

--
-- Name: auth_list_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.auth_list_dto AS (
	username character varying,
	email character varying,
	phone character(13),
	profile_pic text,
	chat_id integer,
	location point,
	role character varying(30)[],
	permission text[]
);


ALTER TYPE dto.auth_list_dto OWNER TO postgres;

--
-- Name: auth_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.auth_update_dto AS (
	id integer,
	username character varying,
	email character varying,
	phone character(13),
	profile_pic text,
	chat_id integer,
	language character varying,
	location point
);


ALTER TYPE dto.auth_update_dto OWNER TO postgres;

--
-- Name: card_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.card_create_dto AS (
	user_id integer,
	card_type character varying(100),
	number character(16),
	holder_name character varying,
	expire_date character(4),
	balance character varying(30)
);


ALTER TYPE dto.card_create_dto OWNER TO postgres;

--
-- Name: card_list_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.card_list_dto AS (
	card_type character varying(100),
	number character(16),
	holder_name character varying,
	expire_date character(4),
	balance character varying(30)
);


ALTER TYPE dto.card_list_dto OWNER TO postgres;

--
-- Name: card_type_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.card_type_update_dto AS (
	old_code character varying(100),
	new_code character varying(100),
	name character varying(100)
);


ALTER TYPE dto.card_type_update_dto OWNER TO postgres;

--
-- Name: card_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.card_update_dto AS (
	id integer,
	card_type character varying(100),
	holder_name character varying,
	expire_date character(4),
	balance character varying(30)
);


ALTER TYPE dto.card_update_dto OWNER TO postgres;

--
-- Name: language_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.language_update_dto AS (
	old_code character varying(30),
	new_code character varying(30),
	name character varying(30)
);


ALTER TYPE dto.language_update_dto OWNER TO postgres;

--
-- Name: permission_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.permission_update_dto AS (
	old_code character varying(150),
	new_code character varying(150),
	name character varying(150)
);


ALTER TYPE dto.permission_update_dto OWNER TO postgres;

--
-- Name: product_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_create_dto AS (
	category_id integer,
	title character varying,
	code character varying,
	count integer,
	color character varying,
	width numeric,
	height numeric,
	country character varying,
	date_of_manufacture character varying,
	description text,
	price character varying,
	extra text
);


ALTER TYPE dto.product_create_dto OWNER TO postgres;

--
-- Name: product_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_update_dto AS (
	id integer,
	title character varying,
	count integer,
	color character varying,
	width numeric,
	height numeric,
	country character varying,
	date_of_manufacture character varying,
	description text,
	price character varying,
	discount_percent smallint,
	extra text
);


ALTER TYPE dto.product_update_dto OWNER TO postgres;

--
-- Name: reset_password; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.reset_password AS (
	id integer,
	old_password text,
	new_password text,
	confirm_password text
);


ALTER TYPE dto.reset_password OWNER TO postgres;

--
-- Name: role_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.role_update_dto AS (
	old_code character varying(30),
	new_code character varying(30),
	name character varying(30)
);


ALTER TYPE dto.role_update_dto OWNER TO postgres;

--
-- Name: sponsor_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.sponsor_create_dto AS (
	name character varying,
	phone character varying,
	email character varying,
	logo character varying,
	location character varying
);


ALTER TYPE dto.sponsor_create_dto OWNER TO postgres;

--
-- Name: sponsor_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.sponsor_update_dto AS (
	id bigint,
	name character varying,
	phone character varying,
	email character varying,
	logo character varying,
	location character varying
);


ALTER TYPE dto.sponsor_update_dto OWNER TO postgres;

--
-- Name: status_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.status_update_dto AS (
	old_code character varying(30),
	new_code character varying(30),
	name character varying(30)
);


ALTER TYPE dto.status_update_dto OWNER TO postgres;

--
-- Name: auth_delete(integer, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_delete(p_delete_user_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user       auth.auth_user%rowtype;
    t_auth_user_role  auth.auth_user_role%rowtype;
    t_auth_permission auth.auth_permission%rowtype;
begin
    call auth.is_active(p_delete_user_id);
    call auth.is_active(p_user_id);

    if p_delete_user_id <> p_user_id then
        select * into t_auth_permission from auth.auth_permission where not is_deleted and code = 'DELETE_USER';
        select * into t_auth_user_role from auth.auth_user_role where not is_deleted and user_id = p_user_id;

        if not exists(select *
                      from auth.auth_role_permission
                      where not is_deleted
                        and permission_id = t_auth_permission.id
                        and auth_user_role_id = t_auth_user_role.id) then
            raise exception '%', settings.translate('PERMISSION_DENIED', 'UZ');
        end if;
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and id = p_delete_user_id;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_user
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_auth_user.id;

    update auth.auth_balance
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and card_id = (select id from auth.auth_card where not auth_card.is_deleted and user_id = t_auth_user.id);

    update auth.auth_card
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and user_id = t_auth_user.id;

    update auth.auth_token set is_deleted = true where not is_deleted and user_id = t_auth_user.id;

    update auth.auth_session
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and user_code = t_auth_user.code;

    update auth.auth_block
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and user_id = t_auth_user.id;

    update auth.auth_role_permission
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and auth_user_role_id =
          (select id from auth.auth_user_role where not auth_user_role.is_deleted and user_id = t_auth_user.id);

    update auth.auth_user_role
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and user_id = t_auth_user.id;

    call settings.log_insert('auth.auth_delete(p_delete_user_id integer, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.auth_delete(p_delete_user_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: auth_get(uuid); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_get(p_user_code uuid) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_roles               jsonb = '[]';
    v_role                jsonb;
    v_permissions         jsonb = '[]';
    v_permission          jsonb;
    v_cards               jsonb = '[]';
    v_card                jsonb;
    v_auth_user           jsonb;
    t_auth_user           auth.auth_user%rowtype;
    t_auth_card           auth.auth_card%rowtype;
    t_auth_permission_for auth.auth_permission%rowtype;
    t_auth_user_role_for  auth.auth_user_role%rowtype;
begin
    select * into t_auth_user from auth.auth_user where not is_deleted and code = p_user_code;
    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    call auth.is_active(t_auth_user.id);

    v_auth_user = jsonb_build_object('code', t_auth_user.code);
    v_auth_user = v_auth_user || jsonb_build_object('username', t_auth_user.username);
    v_auth_user = v_auth_user || jsonb_build_object('email', t_auth_user.email);
    v_auth_user = v_auth_user || jsonb_build_object('phone', t_auth_user.phone);
    v_auth_user = v_auth_user || jsonb_build_object('profile_pic', t_auth_user.profile_pic);
    v_auth_user = v_auth_user || jsonb_build_object('chat_id', t_auth_user.chat_id);
    v_auth_user = v_auth_user || jsonb_build_object('last_login_at', t_auth_user.last_login_at);
    v_auth_user = v_auth_user || jsonb_build_object('language', t_auth_user.language);
    v_auth_user = v_auth_user || jsonb_build_object('status', t_auth_user.status);
    v_auth_user = v_auth_user || jsonb_build_object('location', t_auth_user.location);
    v_auth_user = v_auth_user || jsonb_build_object('created_at', t_auth_user.created_at);

    for t_auth_card in (select * from auth.auth_card where not is_deleted and user_id = t_auth_user.id)
        loop
            v_card = jsonb_build_object('id', t_auth_card.id);
            v_card = v_card || jsonb_build_object('card_type', t_auth_card.card_type);
            v_card = v_card || jsonb_build_object('holder_name', t_auth_card.holder_name);
            v_card = v_card || jsonb_build_object('expire_date', t_auth_card.expire_date);
            v_card = v_card || jsonb_build_object('number', t_auth_card.number);
            v_card = v_card || jsonb_build_object('created_at', t_auth_card.created_at);
            v_cards = v_cards || v_card;
        end loop;

    for t_auth_user_role_for in (select *
                                 from auth.auth_user_role
                                 where not is_deleted
                                   and user_id = t_auth_user.id)
        loop
            v_role = jsonb_build_object('code', t_auth_user_role_for.role_id);
            v_role = v_role || jsonb_build_object('created_at', t_auth_user_role_for.created_at);
            v_roles = v_roles || v_role;
        end loop;

    for t_auth_permission_for in (select auth_permission.*
                                  from auth.auth_permission
                                           inner join auth.auth_role_permission i_auth_permission
                                                      on auth_permission.id = i_auth_permission.permission_id
                                           inner join auth.auth_user_role i_auth_role
                                                      on i_auth_permission.auth_user_role_id = i_auth_role.id
                                  where not auth_permission.is_deleted
                                    and not i_auth_permission.is_deleted
                                    and not i_auth_role.is_deleted
                                    and i_auth_role.user_id = t_auth_user.id)
        loop
            v_permission = jsonb_build_object('name', t_auth_permission_for.name);
            v_permission = v_permission || jsonb_build_object('code', t_auth_permission_for.code);
            v_permission = v_permission || jsonb_build_object('created_at', t_auth_permission_for.created_at);
            v_permissions = v_permissions || v_permission;
        end loop;

    v_auth_user = v_auth_user || jsonb_build_object('cards', v_cards);
    v_auth_user = v_auth_user || jsonb_build_object('roles', v_roles);
    v_auth_user = v_auth_user || jsonb_build_object('permissions', v_permissions);

    call settings.log_insert('auth.auth_get(p_user_id integer) returns text');
    return v_auth_user::text;
end;
$$;


ALTER FUNCTION auth.auth_get(p_user_code uuid) OWNER TO postgres;

--
-- Name: auth_list(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_response            jsonb = '[]';
    v_roles               jsonb = '[]';
    v_role                jsonb;
    v_permissions         jsonb = '[]';
    v_permission          jsonb;
    v_cards               jsonb = '[]';
    v_card                jsonb;
    v_auth_user           jsonb;
    t_auth_user           auth.auth_user%rowtype;
    t_auth_card           auth.auth_card%rowtype;
    t_auth_user_for       auth.auth_user%rowtype;
    t_auth_permission_for auth.auth_permission%rowtype;
    t_auth_user_role_for  auth.auth_user_role%rowtype;
begin
    call auth.is_active(p_user_id);

    select * into t_auth_user from auth.auth_user where not is_deleted and id = p_user_id;
    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    if not auth.has_role(p_user_id, 'ADMIN,MANAGER') then
        raise exception '%', settings.translate('PERMISSION_DENIED', t_auth_user.language);
    end if;

    for t_auth_user_for in (select * from auth.auth_user where not is_deleted)
        loop
            v_auth_user = jsonb_build_object('code', t_auth_user_for.code);
            v_auth_user = v_auth_user || jsonb_build_object('username', t_auth_user_for.username);
            v_auth_user = v_auth_user || jsonb_build_object('email', t_auth_user_for.email);
            v_auth_user = v_auth_user || jsonb_build_object('phone', t_auth_user_for.phone);
            v_auth_user = v_auth_user || jsonb_build_object('profile_pic', t_auth_user_for.profile_pic);
            v_auth_user = v_auth_user || jsonb_build_object('chat_id', t_auth_user_for.chat_id);
            v_auth_user = v_auth_user || jsonb_build_object('last_login_at', t_auth_user_for.last_login_at);
            v_auth_user = v_auth_user || jsonb_build_object('language', t_auth_user_for.language);
            v_auth_user = v_auth_user || jsonb_build_object('status', t_auth_user_for.status);
            v_auth_user = v_auth_user || jsonb_build_object('location', t_auth_user_for.location);
            v_auth_user = v_auth_user || jsonb_build_object('created_at', t_auth_user_for.created_at);

            for t_auth_card in (select * from auth.auth_card where not is_deleted and user_id = t_auth_user_for.id)
                loop
                    v_card = jsonb_build_object('id', t_auth_card.id);
                    v_card = v_card || jsonb_build_object('card_type', t_auth_card.card_type);
                    v_card = v_card || jsonb_build_object('holder_name', t_auth_card.holder_name);
                    v_card = v_card || jsonb_build_object('expire_date', t_auth_card.expire_date);
                    v_card = v_card || jsonb_build_object('number', t_auth_card.number);
                    v_card = v_card || jsonb_build_object('created_at', t_auth_card.created_at);
                    v_cards = v_cards || v_card;
                end loop;

            for t_auth_user_role_for in (select *
                                         from auth.auth_user_role
                                         where not is_deleted
                                           and user_id = t_auth_user_for.id)
                loop
                    v_role = jsonb_build_object('code', t_auth_user_role_for.role_id);
                    v_role = v_role || jsonb_build_object('created_at', t_auth_user_role_for.created_at);
                    v_roles = v_roles || v_role;
                end loop;

            for t_auth_permission_for in (select auth_permission.*
                                          from auth.auth_permission
                                                   inner join auth.auth_role_permission i_auth_permission
                                                              on auth_permission.id = i_auth_permission.permission_id
                                                   inner join auth.auth_user_role i_auth_role
                                                              on i_auth_permission.auth_user_role_id = i_auth_role.id
                                          where not auth_permission.is_deleted
                                            and not i_auth_permission.is_deleted
                                            and not i_auth_role.is_deleted
                                            and i_auth_role.user_id = t_auth_user_for.id)
                loop
                    v_permission = jsonb_build_object('name', t_auth_permission_for.name);
                    v_permission = v_permission || jsonb_build_object('code', t_auth_permission_for.code);
                    v_permission = v_permission || jsonb_build_object('created_at', t_auth_permission_for.created_at);
                    v_permissions = v_permissions || v_permission;
                end loop;

            v_auth_user = v_auth_user || jsonb_build_object('cards', v_cards);
            v_auth_user = v_auth_user || jsonb_build_object('roles', v_roles);
            v_auth_user = v_auth_user || jsonb_build_object('permissions', v_permissions);
            v_response = v_response || v_auth_user;
            v_cards = '[]';
            v_roles = '[]';
            v_permissions = '[]';
        end loop;

    call settings.log_insert('auth.auth_list(p_user_id integer) returns text');
    return v_response::text;
end;
$$;


ALTER FUNCTION auth.auth_list(p_user_id integer) OWNER TO postgres;

--
-- Name: auth_login(character varying, character varying, text); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user   auth.auth_user%rowtype;
    t_auth_block  auth.auth_block%rowtype;
    v_login_count integer default 0;
    v_response    jsonb;
    t_auth_token  auth.auth_token%rowtype;
begin
    if p_username_or_email is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if p_password is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select *
    into t_auth_user
    from auth.auth_user
    where not is_deleted
      and (username = p_username_or_email or email = p_username_or_email);

    if not FOUND then
        raise exception '%', settings.translate('BAD_CREDENTIALS', 'UZ');
    end if;

    select *
    into t_auth_block
    from auth.auth_block
    where not is_deleted
      and user_id = t_auth_user.id
      and duration > current_timestamp
    order by duration desc
    limit 1;

    if FOUND then
        raise exception '% = %', settings.translate('USER_IS_BLOCKED', 'UZ'), t_auth_block.blocked_for;
    end if;

    if not utils.matches(p_password, t_auth_user.password) then
        update auth.auth_user
        set login_try_count = login_try_count + 1
        where not is_deleted
          and id = t_auth_user.id
        returning login_try_count into v_login_count;
        if v_login_count = 3 then
            insert into auth.auth_block (user_id, duration, blocked_for, created_by)
            values (t_auth_user.id, current_timestamp + interval '1 min', 'LOGIN_TRY_COUNT', t_auth_user.id);
        end if;
        commit;
        raise exception '%', settings.translate('BAD_CREDENTIALS', 'UZ');
    end if;

    if t_auth_user.status <> 'ACTIVE' then
        raise exception '%', settings.translate('USER_NOT_ACTIVE', 'UZ');
    end if;

    insert into auth.auth_token (user_id) values (t_auth_user.id) returning * into t_auth_token;

    insert into auth.auth_session (token_id, user_code, username, created_by)
    values (t_auth_token.id, t_auth_user.code, t_auth_user.username, t_auth_user.id);

    v_response = jsonb_build_object('code', t_auth_user.code);
    v_response = v_response || jsonb_build_object('token', t_auth_token.token);
    v_response = v_response || jsonb_build_object('username', t_auth_user.username);
    v_response = v_response || jsonb_build_object('email', t_auth_user.email);
    v_response = v_response || jsonb_build_object('phone', t_auth_user.phone);
    v_response = v_response || jsonb_build_object('language', t_auth_user.language);
    v_response = v_response || jsonb_build_object('profile_pic', t_auth_user.profile_pic);

    update auth.auth_user
    set last_login_at   = current_timestamp,
        login_try_count = 0
    where not is_deleted
      and id = t_auth_user.id;

    call settings.log_insert('auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''''::text)');
    p_result = (v_response::text);
end;
$$;


ALTER PROCEDURE auth.auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text) OWNER TO postgres;

--
-- Name: auth_logout(uuid); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_logout(p_user_code uuid)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user    auth.auth_user%rowtype;
    t_auth_session auth.auth_session%rowtype;
begin
    if p_user_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and code = p_user_code;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FUND', 'UZ');
    end if;

    if t_auth_user.status <> 'ACTIVE' then
        raise exception '%', settings.translate('USER_NOT_ACTIVE', 'UZ');
    end if;

    select * into t_auth_session from auth.auth_session where not is_deleted and user_code = t_auth_user.code;

    if not FOUND then
        raise exception '%', settings.translate('YOU_ARE_NOT_LOGIN', t_auth_user.language);
    end if;

    update auth.auth_session
    set is_deleted = true,
        updated_by = t_auth_user.id,
        updated_at = now()
    where not is_deleted
      and id = t_auth_session.id;

    update auth.auth_token set is_deleted = true where not is_deleted and id = t_auth_session.token_id;
    call settings.log_insert('auth_logout(p_user_code uuid)');
end;
$$;


ALTER PROCEDURE auth.auth_logout(p_user_code uuid) OWNER TO postgres;

--
-- Name: auth_register(text, character varying); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson    json;
    new_user_id integer;
    v_role_id   integer;
    v_counter   integer default 0;
    dto         dto.auth_create_dto;
begin
    call utils.check_data(data);
    dataJson = (data::json);
    dto = mappers.to_auth_create_dto(dataJson);
    call checks.check_auth_create_dto(dto);

    insert into auth.auth_user (username, password, email, phone, chat_id, language, status, created_by,
                                profile_pic, location)
    values (dto.username, utils.encoding_password(dto.password), dto.email, dto.phone, dto.chat_id, dto.language,
            'NO_ACTIVE', -1, dto.profile_pic, dto.location)
    returning id into new_user_id;
    commit;

    insert into auth.auth_user_role (user_id, role_id, created_by)
    values (new_user_id, dto.role, new_user_id)
    returning id into v_role_id;
    commit;

    for v_counter in v_counter..(json_array_length(dto.permission) - 1)
        loop
            insert into auth.auth_role_permission (auth_user_role_id, permission_id, created_by)
            values (v_role_id, (select id
                                from auth.auth_permission
                                where not is_deleted
                                  and code = json_array_element_text(dto.permission, v_counter)),
                    new_user_id);
        end loop;

    call settings.log_insert(
            'auth_register(data text, INOUT p_result character varying DEFAULT ''''::character varying)');
    p_result = 'id = ' || new_user_id;
end;
$$;


ALTER PROCEDURE auth.auth_register(data text, INOUT p_result character varying) OWNER TO postgres;

--
-- Name: auth_update(text, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson          json;
    dto               dto.auth_update_dto;
    t_auth_user_role  auth.auth_user_role%rowtype;
    t_auth_permission auth.auth_permission%rowtype;
begin
    call utils.check_data(data);
    dataJson := data;
    call auth.is_active(p_user_id);
    dto = mappers.to_auth_update_dto(dataJson);
    call checks.check_auth_update_dto(dto);

    if dto.id <> p_user_id then
        select * into t_auth_permission from auth.auth_permission where not is_deleted and code = 'UPDATE_USER';
        select * into t_auth_user_role from auth.auth_user_role where not is_deleted and user_id = p_user_id;

        if not exists(select *
                      from auth.auth_role_permission
                      where not is_deleted
                        and permission_id = t_auth_permission.id
                        and auth_user_role_id = t_auth_user_role.id) then
            raise exception '%', settings.translate('PERMISSION_DENIED', 'UZ');
        end if;
    end if;

    update auth.auth_user
    set username    = dto.username,
        email       = dto.email,
        phone       = dto.phone,
        language    = dto.language,
        profile_pic = dto.profile_pic,
        chat_id     = dto.chat_id,
        location    = dto.location,
        updated_at  = now(),
        updated_by  = p_user_id
    where not is_deleted
      and id = dto.id;

    call settings.log_insert('auth_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.auth_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: card_create(text, integer, text); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.card_create(data text, p_user_id integer, INOUT p_result text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    dto      dto.card_create_dto;
    dataJson json;
    new_id   integer;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_card_create_dto(dataJson);
    call checks.check_card_create_dto(dto);
    call auth.has_permission('ADD_CARD', p_user_id);

    insert into auth.auth_card (user_id, card_type, number, holder_name, expire_date, created_by)
    values (dto.user_id, dto.card_type, dto.number, dto.holder_name, dto.expire_date, p_user_id)
    returning id into new_id;
    commit;

    insert into auth.auth_balance (card_id, amount, created_by) values (new_id, dto.balance, p_user_id);
    call settings.log_insert('card_create(data text, p_user_id integer, inout p_result text)');
    p_result = 'id = ' || new_id;
end;
$$;


ALTER PROCEDURE auth.card_create(data text, p_user_id integer, INOUT p_result text) OWNER TO postgres;

--
-- Name: card_delete(integer, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.card_delete(card_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_card auth.auth_card%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_CARD', p_user_id);
    select * into t_card from auth.auth_card where not is_deleted and id = card_id and user_id = p_user_id;

    if not FOUND then
        raise exception '%', settings.translate('CARD_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_card
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_card.id;

    update auth.auth_balance
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where card_id = t_card.id;

    call settings.log_insert('auth.card_delete(card_id integer, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.card_delete(card_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: card_list(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.card_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_card      jsonb;
    v_cards     jsonb = '[]';
    t_card      auth.auth_card%rowtype;
    t_auth_user auth.auth_user%rowtype;
begin
    call auth.is_active(p_user_id);

    select * into t_auth_user from auth.auth_user where not is_deleted and id = p_user_id;
    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    if not auth.has_role(p_user_id, 'ADMIN,MANAGER') then
        raise exception '%', settings.translate('PERMISSION_DENIED', t_auth_user.language);
    end if;

    for t_card in (select * from auth.auth_card where not is_deleted)
        loop
            v_card = jsonb_build_object('user_id', t_card.user_id);
            v_card = v_card || jsonb_build_object('card_type', t_card.card_type);
            v_card = v_card || jsonb_build_object('number', t_card.number);
            v_card = v_card || jsonb_build_object('holder_name', t_card.holder_name);
            v_card = v_card || jsonb_build_object('expire_date', t_card.expire_date);
            v_card = v_card || jsonb_build_object('created_at', t_card.created_at);
            v_cards = v_cards || v_card;
        end loop;

    call settings.log_insert('auth.card_list(p_user_id integer) returns text');
    return v_cards::text;
end;
$$;


ALTER FUNCTION auth.card_list(p_user_id integer) OWNER TO postgres;

--
-- Name: card_my_list(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.card_my_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_card  jsonb;
    v_cards jsonb = '[]';
    t_card  auth.auth_card%rowtype;
begin
    call auth.is_active(p_user_id);

    for t_card in (select * from auth.auth_card where not is_deleted and user_id = p_user_id)
        loop
            v_card = jsonb_build_object('card_type', t_card.card_type);
            v_card = v_card || jsonb_build_object('number', t_card.number);
            v_card = v_card || jsonb_build_object('holder_name', t_card.holder_name);
            v_card = v_card || jsonb_build_object('expire_date', t_card.expire_date);
            v_card = v_card || jsonb_build_object('balance', (select amount from auth.auth_balance where not is_deleted
                                                                                                     and card_id = t_card.id));
            v_card = v_card || jsonb_build_object('created_at', t_card.created_at);
            v_cards = v_cards || v_card;
        end loop;

    call settings.log_insert('auth.card_my_list(p_user_id integer) returns text');
    return v_cards::text;
end;
$$;


ALTER FUNCTION auth.card_my_list(p_user_id integer) OWNER TO postgres;

--
-- Name: card_type_create(character varying, character varying, integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.card_type_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id      integer;
    t_card_type auth.auth_card_type%rowtype;
begin
    if p_name is null or p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_CARD_TYPE', p_user_id);

    select * into t_card_type from auth.auth_card_type where not is_deleted and code = p_code;
    if FOUND then
        raise exception '%', settings.translate('CARD_TYPE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into auth.auth_card_type (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into new_id;

    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION auth.card_type_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: card_type_delete(character varying, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.card_type_delete(p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_card_type auth.auth_card_type%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_CARD_TYPE', p_user_id);

    select * into t_card_type from auth.auth_card_type where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('CARD_TYPE_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_card_type
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_card_type.code;

    call settings.log_insert('card_type_delete(p_code character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.card_type_delete(p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: card_type_list(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.card_type_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_type      jsonb;
    v_types     jsonb = '[]';
    t_card_type auth.auth_card_type%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_CARD_TYPE', p_user_id);

    for t_card_type in (select * from auth.auth_card_type where not is_deleted)
        loop
            v_type = jsonb_build_object('name', t_card_type.name);
            v_type = v_type || jsonb_build_object('code', t_card_type.code);
            v_type = v_type || jsonb_build_object('created_at', t_card_type.created_at);
            v_types = v_types || v_type;
        end loop;

    call settings.log_insert('auth.card_type_list(p_user_id integer) returns text');
    return v_types::text;
end;
$$;


ALTER FUNCTION auth.card_type_list(p_user_id integer) OWNER TO postgres;

--
-- Name: card_type_update(text, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.card_type_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto         dto.card_type_update_dto;
    dataJson    json;
    t_card_type auth.auth_card_type%rowtype;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_card_type_update_dto(dataJson);
    call checks.check_card_type_update_dto(dto);
    call auth.has_permission('UPDATE_CARD_TYPE', p_user_id);

    select * into t_card_type from auth.auth_card_type where not is_deleted and code = dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('CARD_TYPE_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_card_type
    set name       = dto.name,
        code       = dto.new_code,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_card_type.code;

    call settings.log_insert('card_type_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.card_type_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: card_update(text, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.card_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto      dto.card_update_dto;
    dataJson json;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_card_update_dto(dataJson);
    call checks.check_card_update_dto(dto);
    call auth.has_permission('UPDATE_CARD', p_user_id);

    update auth.auth_card
    set card_type   = dto.card_type,
        holder_name = dto.holder_name,
        expire_date = dto.expire_date,
        updated_at  = now(),
        updated_by  = p_user_id
    where not is_deleted
      and id = dto.id;

    update auth.auth_balance
    set amount     = dto.balance,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and card_id = dto.id;

    call settings.log_insert('auth.card_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.card_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: change_language(uuid, character); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.change_language(p_user_code uuid, p_to_language character)
    LANGUAGE plpgsql
    AS $$
declare
    t_language  auth.auth_language%rowtype;
    t_auth_user auth.auth_user%rowtype;
begin
    if p_user_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if p_to_language is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and code = p_user_code;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    call auth.is_active(t_auth_user.id);

    select * into t_language from auth.auth_language where not is_deleted and code = p_to_language;

    if not FOUND then
        raise exception '%', settings.translate('LANGUAGE_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_user
    set language   = p_to_language,
        updated_at = now(),
        updated_by = t_auth_user.id
    where not is_deleted
      and id = t_auth_user.id;
    call settings.log_insert('auth.change_language(p_user_code uuid, p_to_language char(2))');
end;
$$;


ALTER PROCEDURE auth.change_language(p_user_code uuid, p_to_language character) OWNER TO postgres;

--
-- Name: has_permission(character varying, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.has_permission(p_permission_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user       auth.auth_user%rowtype;
    t_auth_permission auth.auth_permission%rowtype;
begin
    select * into t_auth_user from auth.auth_user where not is_deleted and id = p_user_id;
    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    select * into t_auth_permission from auth.auth_permission where not is_deleted and code = p_permission_code;
    if not exists(select *
                  from auth.auth_role_permission
                  where not is_deleted
                    and permission_id = t_auth_permission.id
                    and auth_user_role_id = any (select auth_user_role.id
                                                 from auth.auth_user_role
                                                 where not is_deleted
                                                   and user_id = p_user_id)) then
        raise exception '%', settings.translate('PERMISSION_DENIED', t_auth_user.language);
    end if;
end;
$$;


ALTER PROCEDURE auth.has_permission(p_permission_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: has_role(integer, character varying); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.has_role(p_user_id integer, role character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
    v_roles          text[];
    t_auth_user_role auth.auth_user_role%rowtype;
begin
    call auth.is_active(p_user_id);

    if role is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    v_roles = string_to_array(role, ',');

    select *
    into t_auth_user_role
    from auth.auth_user_role
    where not is_deleted
      and user_id = p_user_id
      and role_id = any (select code from auth.auth_role where not is_deleted and code = any (v_roles));

    if t_auth_user_role is null then
        return false;
    else
        return true;
    end if;
end;
$$;


ALTER FUNCTION auth.has_role(p_user_id integer, role character varying) OWNER TO postgres;

--
-- Name: is_active(integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.is_active(p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user%rowtype;
begin
    if p_user_id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and id = p_user_id;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    if t_auth_user.status <> 'ACTIVE' then
        raise exception '%', settings.translate('USER_NOT_ACTIVE', 'UZ');
    end if;
end;
$$;


ALTER PROCEDURE auth.is_active(p_user_id integer) OWNER TO postgres;

--
-- Name: language_create(character varying, character varying, integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.language_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id     integer;
    t_language auth.auth_language%rowtype;
begin
    if p_name is null or p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_LANGUAGE', p_user_id);

    select * into t_language from auth.auth_language where not is_deleted and code = p_code;
    if FOUND then
        raise exception '%', settings.translate('LANGUAGE_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into auth.auth_language (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into new_id;

    call settings.log_insert('language_create(p_name character varying, p_code character varying, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION auth.language_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: language_delete(character varying, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.language_delete(p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_language auth.auth_language%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_LANGUAGE', p_user_id);

    select * into t_language from auth.auth_language where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('LANGUAGE_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_language
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_language.code;

    call settings.log_insert('auth.language_delete((p_code character varying, p_user_id integer) returns text');
end;
$$;


ALTER PROCEDURE auth.language_delete(p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: language_list(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.language_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_lang     jsonb;
    v_lang_l   jsonb = '[]';
    t_language auth.auth_language%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_LANGUAGE', p_user_id);

    for t_language in (select * from auth.auth_language where not is_deleted)
        loop
            v_lang = jsonb_build_object('name', t_language.name);
            v_lang = v_lang || jsonb_build_object('code', t_language.code);
            v_lang = v_lang || jsonb_build_object('created_at', t_language.created_at);
            v_lang_l = v_lang_l || v_lang;
        end loop;

    call settings.log_insert('auth.language_list(p_user_id integer) returns text');
    return v_lang_l::text;
end;
$$;


ALTER FUNCTION auth.language_list(p_user_id integer) OWNER TO postgres;

--
-- Name: language_update(text, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.language_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto        dto.language_update_dto;
    dataJson   json;
    t_language auth.auth_language%rowtype;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_language_update_dto(dataJson);
    call checks.check_language_update_dto(dto);
    call auth.has_permission('UPDATE_LANGUAGE', p_user_id);

    select * into t_language from auth.auth_language where not is_deleted and code = dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('LANGUAGE_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_language
    set name       = dto.name,
        code       = dto.new_code,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_language.code;

    call settings.log_insert('auth.language_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.language_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: permission_create(character varying, character varying, integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.permission_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id       integer;
    t_permission auth.auth_permission%rowtype;
begin
    if p_name is null or p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_PERMISSION', p_user_id);

    select * into t_permission from auth.auth_permission where not is_deleted and code = p_code;
    if FOUND then
        raise exception '%', settings.translate('PERMISSION_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into auth.auth_permission (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into new_id;

    call settings.log_insert('auth.permission_create(p_name character varying, p_code character varying, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION auth.permission_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: permission_delete(character varying, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.permission_delete(p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_permission auth.auth_permission%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PERMISSION', p_user_id);

    select * into t_permission from auth.auth_permission where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('PERMISSION_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_permission
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_permission.code;

    call settings.log_insert('auth.permission_delete(p_code character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.permission_delete(p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: permission_list(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.permission_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_permission   jsonb;
    v_permission_l jsonb = '[]';
    t_permission   auth.auth_permission%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_PERMISSION', p_user_id);

    for t_permission in (select * from auth.auth_permission where not is_deleted)
        loop
            v_permission = jsonb_build_object('name', t_permission.name);
            v_permission = v_permission || jsonb_build_object('code', t_permission.code);
            v_permission = v_permission || jsonb_build_object('created_at', t_permission.created_at);
            v_permission_l = v_permission_l || v_permission;
        end loop;

    call settings.log_insert('auth.permission_list(p_user_id integer) returns text');
    return v_permission_l::text;
end;
$$;


ALTER FUNCTION auth.permission_list(p_user_id integer) OWNER TO postgres;

--
-- Name: permission_update(text, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.permission_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto          dto.permission_update_dto;
    dataJson     json;
    t_permission auth.auth_permission%rowtype;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_permission_update_dto(dataJson);
    call checks.check_permission_update_dto(dto);
    call auth.has_permission('UPDATE_PERMISSION', p_user_id);

    select * into t_permission from auth.auth_permission where not is_deleted and code = dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('PERMISSION_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_permission
    set name       = dto.name,
        code       = dto.new_code,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_permission.code;

    call settings.log_insert('auth.permission_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.permission_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: reset_password(text, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.reset_password(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson          json;
    dto               dto.reset_password;
    t_auth_user_role  auth.auth_user_role%rowtype;
    t_auth_permission auth.auth_permission%rowtype;
begin
    call auth.is_active(p_user_id);
    call utils.check_data(data);
    dataJson := data::json;
    dto = mappers.to_reset_password_dto(dataJson);
    call checks.check_reset_password_dto(dto);

    if dto.id <> p_user_id then
        select * into t_auth_permission from auth.auth_permission where not is_deleted and code = 'RESET_PASSWORD_USER';
        select * into t_auth_user_role from auth.auth_user_role where not is_deleted and user_id = p_user_id;

        if not exists(select *
                      from auth.auth_role_permission
                      where not is_deleted
                        and permission_id = t_auth_permission.id
                        and auth_user_role_id = t_auth_user_role.id) then
            raise exception '%', settings.translate('PERMISSION_DENIED', 'UZ');
        end if;
    end if;

    update auth.auth_user
    set password   = utils.encoding_password(dto.new_password),
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = dto.id;

    call settings.log_insert('auth.reset_password(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.reset_password(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: role_create(character varying, character varying, integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.role_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id integer;
    t_role auth.auth_role%rowtype;
begin
    if p_name is null or p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_ROLE', p_user_id);

    select * into t_role from auth.auth_role where not is_deleted and code = p_code;
    if FOUND then
        raise exception '%', settings.translate('ROLE_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into auth.auth_role (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into new_id;

    call settings.log_insert('auth.role_create(p_name character varying, p_code character varying, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION auth.role_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: role_delete(character varying, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.role_delete(p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_role auth.auth_role%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_ROLE', p_user_id);

    select * into t_role from auth.auth_role where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('ROLE_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_role
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_role.code;

    call settings.log_insert('auth.role_delete(p_code character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.role_delete(p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: role_list(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.role_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_role   jsonb;
    v_role_l jsonb = '[]';
    t_role   auth.auth_role%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_ROLE', p_user_id);

    for t_role in (select * from auth.auth_role where not is_deleted)
        loop
            v_role = jsonb_build_object('name', t_role.name);
            v_role = v_role || jsonb_build_object('code', t_role.code);
            v_role = v_role || jsonb_build_object('created_at', t_role.created_at);
            v_role_l = v_role_l || v_role;
        end loop;

    call settings.log_insert('auth.role_list(p_user_id integer) returns text');
    return v_role_l::text;
end;
$$;


ALTER FUNCTION auth.role_list(p_user_id integer) OWNER TO postgres;

--
-- Name: role_update(text, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.role_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto      dto.role_update_dto;
    dataJson json;
    t_role   auth.auth_role%rowtype;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_role_update_dto(dataJson);
    call checks.check_role_update_dto(dto);
    call auth.has_permission('UPDATE_ROLE', p_user_id);

    select * into t_role from auth.auth_role where not is_deleted and code = dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('ROLE_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_role
    set name       = dto.name,
        code       = dto.new_code,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_role.code;

    call settings.log_insert('auth.role_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.role_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: status_create(character varying, character varying, integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.status_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id   integer;
    t_status auth.auth_status%rowtype;
begin
    if p_name is null or p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_STATUS', p_user_id);

    select * into t_status from auth.auth_status where not is_deleted and code = p_code;
    if FOUND then
        raise exception '%', settings.translate('STATUS_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into auth.auth_status (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into new_id;

    call settings.log_insert('auth.status_create(p_name character varying, p_code character varying, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION auth.status_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: status_delete(character varying, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.status_delete(p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_status auth.auth_status%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_STATUS', p_user_id);

    select * into t_status from auth.auth_status where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('STATUS_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_status
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_status.code;

    call settings.log_insert('auth.status_delete(p_code character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.status_delete(p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: status_list(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.status_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_status   jsonb;
    v_status_l jsonb = '[]';
    t_status   auth.auth_status%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_STATUS', p_user_id);

    for t_status in (select * from auth.auth_status where not is_deleted)
        loop
            v_status = jsonb_build_object('name', t_status.name);
            v_status = v_status || jsonb_build_object('code', t_status.code);
            v_status = v_status || jsonb_build_object('created_at', t_status.created_at);
            v_status_l = v_status_l || v_status;
        end loop;

    call settings.log_insert('auth.status_list(p_user_id integer) returns text');
    return v_status_l::text;
end;
$$;


ALTER FUNCTION auth.status_list(p_user_id integer) OWNER TO postgres;

--
-- Name: status_update(text, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.status_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto      dto.status_update_dto;
    dataJson json;
    t_status auth.auth_status%rowtype;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_status_update_dto(dataJson);
    call checks.check_status_update_dto(dto);
    call auth.has_permission('UPDATE_STATUS', p_user_id);

    select * into t_status from auth.auth_status where not is_deleted and code = dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('STATUS_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_status
    set name       = dto.name,
        code       = dto.new_code,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_status.code;

    call settings.log_insert('auth.status_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.status_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: user_code_by_id(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.user_code_by_id(p_user_id integer) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user%rowtype;
begin
    if p_user_id is null or p_user_id = '' then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and id = p_user_id;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    call settings.log_insert('auth.user_code_by_id(p_user_id integer) returns uuid');
    return t_auth_user.code;
end;
$$;


ALTER FUNCTION auth.user_code_by_id(p_user_id integer) OWNER TO postgres;

--
-- Name: user_id_by_code(uuid); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.user_id_by_code(p_user_code uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user%rowtype;
begin
    if p_user_code is null or p_user_code = '' then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and code = p_user_code;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    call settings.log_insert('auth.user_id_by_code(p_user_code uuid) returns integer');
    return t_auth_user.id;
end;
$$;


ALTER FUNCTION auth.user_id_by_code(p_user_code uuid) OWNER TO postgres;

--
-- Name: user_role_create(integer, character varying, integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.user_role_create(p_create_user_id integer, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id            integer;
    t_role            auth.auth_role%rowtype;
    t_user_role       auth.auth_user_role%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_create_user_id);
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_USER_ROLE', p_user_id);

    select * into t_role from auth.auth_role where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('ROLE_NOT_FOUND', 'UZ');
    end if;

    select *
    into t_user_role
    from auth.auth_user_role
    where not is_deleted
      and role_id = t_role.code
      and user_id = p_create_user_id;
    if FOUND then
        raise exception '%', settings.translate('ROLE_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into auth.auth_user_role (user_id, role_id, created_by)
    values (p_create_user_id, t_role.code, p_user_id)
    returning id into new_id;

    call settings.log_insert('auth.user_role_create(p_create_user_id integer, p_code character varying, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION auth.user_role_create(p_create_user_id integer, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: user_role_delete(integer, character varying, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_user_role auth.auth_user_role%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_delete_user_id);
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_USER_ROLE', p_user_id);

    select *
    into t_user_role
    from auth.auth_user_role
    where not is_deleted
      and role_id = p_code
      and user_id = p_delete_user_id;
    if not FOUND then
        raise exception '%', settings.translate('ROLE_NOT_FOUND', 'UZ');
    end if;

    update auth.auth_user_role
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_user_role.id;

    call settings.log_insert('auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: user_role_list(integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.user_role_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_user_role       jsonb;
    v_user_role_l     jsonb = '[]';
    t_user_role       auth.auth_user_role%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_USER_ROLE', p_user_id);

    for t_user_role in (select * from auth.auth_user_role where not is_deleted)
        loop
            v_user_role = jsonb_build_object('name', t_user_role.user_id);
            v_user_role = v_user_role || jsonb_build_object('code', t_user_role.role_id);
            v_user_role = v_user_role || jsonb_build_object('created_at', t_user_role.created_at);
            v_user_role_l = v_user_role_l || v_user_role;
        end loop;

    call settings.log_insert('auth.user_role_list(p_user_id integer) returns text');
    return v_user_role_l::text;
end;
$$;


ALTER FUNCTION auth.user_role_list(p_user_id integer) OWNER TO postgres;

--
-- Name: check_auth_create_dto(dto.auth_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_auth_create_dto(INOUT create_dto dto.auth_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_language   auth.auth_language%rowtype;
    t_auth_user  auth.auth_user%rowtype;
    v_counter    integer default 0;
begin
    if create_dto.username is null then
        raise exception '% username', settings.translate('IS_REQUIRED_TO_REGISTER', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and username = create_dto.username;

    if FOUND then
        raise exception '%', settings.translate('USERNAME_IS_AVAILABLE', 'UZ');
    end if;

    if create_dto.email is null then
        raise exception '% email', settings.translate('IS_REQUIRED_TO_REGISTER', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and email = create_dto.email;

    if FOUND then
        raise exception '%', settings.translate('EMAIL_IS_AVAILABLE', 'UZ');
    end if;

    if create_dto.phone is null then
        raise exception '% phone', settings.translate('IS_REQUIRED_TO_REGISTER', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and phone = create_dto.phone;

    if FOUND then
        raise exception '%', settings.translate('PHONE_IS_AVAILABLE', 'UZ');
    end if;

    if create_dto.password is null then
        raise exception '% password', settings.translate('IS_REQUIRED_TO_REGISTER', 'UZ');
    end if;

    if create_dto.language is null then
        create_dto.language = 'UZ';
    else
        select * into t_language from auth.auth_language where not is_deleted and code = create_dto.language;
        if not FOUND then
            raise exception '%', settings.translate('LANGUAGE_NOT_FOUND', 'UZ');
        end if;
    end if;

    if create_dto.role is null then
        create_dto.role = 'USER';
    else
        if not exists(select code from auth.auth_role where not is_deleted and code = create_dto.role) then
            raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
        end if;
    end if;

    if create_dto.permission is null then
        create_dto.permission = '[
          "LIST_CATEGORY",
          "LIST_PRODUCT",
          "GET_CATEGORY",
          "GET_PRODUCT",
          "LIST_DISCOUNT",
          "GET_DISCOUNT",
          "CHANGE_LANGUAGE",
          "ADD_CARD",
          "DELETE_CARD",
          "UPDATE_CARD",
          "LIST_CARD",
          "GET_CARD"
        ]'::json;
    else
        for v_counter in v_counter..(json_array_length(create_dto.permission) - 1)
            loop
                if not exists(select code from auth.auth_permission where not is_deleted
                                and code = json_array_element_text(create_dto.permission, v_counter)) then
                    raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
                end if;
            end loop;
    end if;
end;
$$;


ALTER PROCEDURE checks.check_auth_create_dto(INOUT create_dto dto.auth_create_dto) OWNER TO postgres;

--
-- Name: check_auth_update_dto(dto.auth_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_auth_update_dto(INOUT update_dto dto.auth_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_language  auth.auth_language%rowtype;
    t_auth_user auth.auth_user%rowtype;
    t_auth_user_main auth.auth_user%rowtype;
begin
    if update_dto.id is null then
        raise exception '% id', settings.translate('IS_REQUIRED_TO_UPDATE', 'UZ');
    end if;

    select * into t_auth_user_main from auth.auth_user where not is_deleted and id = update_dto.id;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    if update_dto.username is null then
        update_dto.username = t_auth_user_main.username;
    else
        select * into t_auth_user from auth.auth_user where not is_deleted and username = update_dto.username;
        if FOUND then
            raise exception '%', settings.translate('USERNAME_IS_AVAILABLE', 'UZ');
        end if;
    end if;

    if update_dto.email is null then
        update_dto.email = t_auth_user_main.email;
    else
        select * into t_auth_user from auth.auth_user where not is_deleted and email = update_dto.email;
        if FOUND then
            raise exception '%', settings.translate('EMAIL_IS_AVAILABLE', 'UZ');
        end if;
    end if;

    if update_dto.phone is null then
        update_dto.phone = t_auth_user_main.phone;
    else
        select * into t_auth_user from auth.auth_user where not is_deleted and phone = update_dto.phone;
        if FOUND then
            raise exception '%', settings.translate('PHONE_IS_AVAILABLE', 'UZ');
        end if;
    end if;

    if update_dto.profile_pic is null then
        update_dto.profile_pic = t_auth_user_main.profile_pic;
    end if;

    if update_dto.chat_id is null then
        update_dto.chat_id = t_auth_user_main.chat_id;
    end if;

    if update_dto.language is null then
        update_dto.language = t_auth_user_main.language;
    else
        select * into t_language from auth.auth_language where not is_deleted and code = update_dto.language;
        if not FOUND then
            raise exception '%', settings.translate('LANGUAGE_NOT_FOUND', 'UZ');
        end if;
    end if;

    if update_dto.location is null then
        update_dto.location = t_auth_user_main.location;
    end if;
end;
$$;


ALTER PROCEDURE checks.check_auth_update_dto(INOUT update_dto dto.auth_update_dto) OWNER TO postgres;

--
-- Name: check_card_create_dto(dto.card_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_card_create_dto(INOUT create_dto dto.card_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user%rowtype;
    t_card_type auth.auth_card_type%rowtype;
    t_card      auth.auth_card%rowtype;
begin
    if create_dto.user_id is null then
        raise exception '% user_id', settings.translate('IS_REQUIRED_TO_CREATE_CARD', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and id = create_dto.user_id;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    if create_dto.balance is null then
        raise exception '% balance', settings.translate('IS_REQUIRED_TO_CREATE_CARD', 'UZ');
    end if;
    
    if create_dto.card_type is null then
        raise exception '% card type', settings.translate('IS_REQUIRED_TO_CREATE_CARD', 'UZ');
    end if;

    select * into t_card_type from auth.auth_card_type where not is_deleted and code = create_dto.card_type;

    if not FOUND then
        raise exception '%', settings.translate('CARD_TYPE_NOT_FOUND', 'UZ');
    end if;

    if create_dto.number is null then
        raise exception '% number', settings.translate('IS_REQUIRED_TO_CREATE_CARD', 'UZ');
    end if;

    select *
    into t_card
    from auth.auth_card
    where not is_deleted and user_id = t_auth_user.id and number = create_dto.number;

    if FOUND then
        raise exception '%', settings.translate('CARD_NUMBER_IS_ALREADY_TAKEN', 'UZ');
    end if;

    if create_dto.expire_date is null then
        raise exception '% expire date', settings.translate('IS_REQUIRED_TO_CREATE_CARD', 'UZ');
    end if;

    if create_dto.holder_name is null then
        raise exception '% holder_name', settings.translate('IS_REQUIRED_TO_CREATE_CARD', 'UZ');
    end if;
end;
$$;


ALTER PROCEDURE checks.check_card_create_dto(INOUT create_dto dto.card_create_dto) OWNER TO postgres;

--
-- Name: check_card_type_update_dto(dto.card_type_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_card_type_update_dto(INOUT update_dto dto.card_type_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_card_type auth.auth_card_type%rowtype;
begin
    if update_dto.old_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_card_type from auth.auth_card_type where not is_deleted and code = update_dto.old_code;

    if not FOUND then
        raise exception '%', settings.translate('CARD_TYPE_NOT_FOUND', 'UZ');
    end if;

    if update_dto.new_code is null then
        update_dto.new_code = t_card_type.code;
    else
        if exists(select * from auth.auth_card_type where not is_deleted and code = update_dto.new_code) then
            raise exception '%', settings.translate('CARD_TYPE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;

    if update_dto.name is null then
        update_dto.name = t_card_type.name;
    end if;

    call settings.log_insert('checks.check_card_type_update_dto(inout update_dto dto.card_type_update_dto)');
end;
$$;


ALTER PROCEDURE checks.check_card_type_update_dto(INOUT update_dto dto.card_type_update_dto) OWNER TO postgres;

--
-- Name: check_card_update_dto(dto.card_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_card_update_dto(INOUT update_dto dto.card_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_card_type auth.auth_card_type%rowtype;
    t_card      auth.auth_card%rowtype;
    t_balance   auth.auth_balance%rowtype;
begin
    if update_dto.id is null then
        raise exception '% id', settings.translate('IS_REQUIRED_TO_UPDATE_CARD', 'UZ');
    end if;

    select * into t_card from auth.auth_card where not is_deleted and id = update_dto.id;

    if not FOUND then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_balance from auth.auth_balance where not is_deleted and card_id = t_card.id;

    if not FOUND then
        raise exception '%', settings.translate('CARD_NOT_FOUND', 'UZ');
    end if;

    if update_dto.balance is null then
        update_dto.balance = t_balance.amount;
    end if;

    if update_dto.card_type is null then
        update_dto.card_type = t_card.card_type;
    else
        select * into t_card_type from auth.auth_card_type where not is_deleted and code = update_dto.card_type;
        if not FOUND then
            raise exception '%', settings.translate('CARD_TYPE_NOT_FOUND', 'UZ');
        end if;
    end if;

    if update_dto.expire_date is null then
        update_dto.expire_date = t_card.expire_date;
    end if;

    if update_dto.holder_name is null then
        update_dto.holder_name = t_card.holder_name;
    end if;
end;
$$;


ALTER PROCEDURE checks.check_card_update_dto(INOUT update_dto dto.card_update_dto) OWNER TO postgres;

--
-- Name: check_comment_created_by(bigint, integer); Type: FUNCTION; Schema: checks; Owner: postgres
--

CREATE FUNCTION checks.check_comment_created_by(p_comment_id bigint, p_user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
    t_comment project.product_comment;
begin
    if p_comment_id is null then
        raise exception 'comment not found';
    end if;

    select * into t_comment from project.product_comment where id = p_comment_id;

    if not FOUND then
        raise exception 'comment not found';
    end if;

    if t_comment.created_by != p_user_id then
        return false;
    else
        return true;
    end if;
end;
$$;


ALTER FUNCTION checks.check_comment_created_by(p_comment_id bigint, p_user_id integer) OWNER TO postgres;

--
-- Name: check_language_update_dto(dto.language_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_language_update_dto(INOUT update_dto dto.language_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_language auth.auth_language%rowtype;
begin
    if update_dto.old_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_language from auth.auth_language where not is_deleted and code = update_dto.old_code;

    if not FOUND then
        raise exception '%', settings.translate('LANGUAGE_NOT_FOUND', 'UZ');
    end if;

    if update_dto.new_code is null then
        update_dto.new_code = t_language.code;
    else
        if exists(select * from auth.auth_language where not is_deleted and code = update_dto.new_code) then
            raise exception '%', settings.translate('LANGUAGE_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;

    if update_dto.name is null then
        update_dto.name = t_language.name;
    end if;

    call settings.log_insert('checks.check_language_update_dto(INOUT update_dto dto.language_update_dto)');
end;
$$;


ALTER PROCEDURE checks.check_language_update_dto(INOUT update_dto dto.language_update_dto) OWNER TO postgres;

--
-- Name: check_permission_update_dto(dto.permission_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_permission_update_dto(INOUT update_dto dto.permission_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_permission auth.auth_permission%rowtype;
begin
    if update_dto.old_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_permission from auth.auth_permission where not is_deleted and code = update_dto.old_code;

    if not FOUND then
        raise exception '%', settings.translate('PERMISSION_NOT_FOUND', 'UZ');
    end if;

    if update_dto.new_code is null then
        update_dto.new_code = t_permission.code;
    else
        if exists(select * from auth.auth_permission where not is_deleted and code = update_dto.new_code) then
            raise exception '%', settings.translate('PERMISSION_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;

    if update_dto.name is null then
        update_dto.name = t_permission.name;
    end if;

    call settings.log_insert('checks.check_permission_update_dto(INOUT update_dto dto.permission_update_dto)');
end;
$$;


ALTER PROCEDURE checks.check_permission_update_dto(INOUT update_dto dto.permission_update_dto) OWNER TO postgres;

--
-- Name: check_product_create_dto(dto.product_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_create_dto(INOUT dto dto.product_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_product  project.product;
    t_category project.category;
begin
    if dto.category_id is null then
        raise exception '% category id', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    select * into t_category from project.category where not is_deleted and id = dto.category_id;

    if NOT FOUND then
        raise exception 'category %', settings.translate('NOT_FOUND', 'UZ');
    end if;

    if dto.code is null then
        raise exception '% code', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    select * into t_product from project.product where not is_deleted and code = dto.code;

    if FOUND then
        raise exception '% ', settings.translate('THERE_IS_SUCH_A_CODED_PRODUCT', 'UZ');
    end if;

    if dto.price is null then
        raise exception '% price', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if dto.title is null then
        raise exception '% title', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if dto.count is null then
        raise exception '% count', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if dto.color is null then
        raise exception '% color', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if dto.width is null then
        raise exception '% width', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if dto.height is null then
        raise exception '% height', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if dto.country is null then
        raise exception '% country', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if dto.date_of_manufacture is null then
        raise exception '% date_of_manufacture', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if dto.description is null then
        raise exception '% description', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;
end;
$$;


ALTER PROCEDURE checks.check_product_create_dto(INOUT dto dto.product_create_dto) OWNER TO postgres;

--
-- Name: check_product_update_dto(dto.product_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_update_dto(INOUT p_update dto.product_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_product_price project.product_price;
    t_product       project.product;
begin
    if p_update.id is null then
        raise exception 'id %', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    select * into t_product from project.product where not is_deleted and id = p_update.id;

    if not FOUND then
        raise exception '% ', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;

    if p_update.title is null then
        p_update.title = t_product.title;
    end if;

    if p_update.count is null then
        p_update.count = t_product.count;
    end if;

    if p_update.color is null then
        p_update.color = t_product.color;
    end if;

    if p_update.width is null then
        p_update.width = t_product.width;
    end if;

    if p_update.height is null then
        p_update.height = t_product.height;
    end if;

    if p_update.count is null then
        p_update.count = t_product.count;
    end if;
    
    if p_update.country is null then
        p_update.country = t_product.country;
    end if;

    if p_update.date_of_manufacture is null then
        p_update.date_of_manufacture = t_product.date_of_manufacture;
    end if;

    if p_update.description is null then
        p_update.description = t_product.description;
    end if;

    select * into t_product_price from project.product_price where not is_deleted and product_id = p_update.id;

    if p_update.price is null then
        p_update.price = t_product_price.price;
    end if;

    if p_update.discount_percent is null then
        p_update.discount_percent = t_product_price.discount_percent;
    end if;

    if p_update.extra is null then
        p_update.extra = t_product.extra;
    end if;
end;
$$;


ALTER PROCEDURE checks.check_product_update_dto(INOUT p_update dto.product_update_dto) OWNER TO postgres;

--
-- Name: check_reset_password_dto(dto.reset_password); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_reset_password_dto(INOUT password_dto dto.reset_password)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user%rowtype;
begin
    if password_dto.id is null then
        raise exception '% id', settings.translate('IS_REQUIRED_TO_RESET_PASSWORD', 'UZ');
    end if;

    if password_dto.old_password is null then
        raise exception '% old password', settings.translate('IS_REQUIRED_TO_RESET_PASSWORD', 'UZ');
    end if;

    if password_dto.new_password is null then
        raise exception '% new password', settings.translate('IS_REQUIRED_TO_RESET_PASSWORD', 'UZ');
    end if;

    if password_dto.confirm_password is null then
        raise exception '% confirm password', settings.translate('IS_REQUIRED_TO_RESET_PASSWORD', 'UZ');
    end if;

    call auth.is_active(password_dto.id);

    select * into t_auth_user from auth.auth_user where not is_deleted and id = password_dto.id;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    if password_dto.new_password <> password_dto.confirm_password then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if not utils.matches(password_dto.old_password, t_auth_user.password) then
        raise exception '%', settings.translate('BAD_CREDENTIALS', 'UZ');
    end if;
end;
$$;


ALTER PROCEDURE checks.check_reset_password_dto(INOUT password_dto dto.reset_password) OWNER TO postgres;

--
-- Name: check_role_update_dto(dto.role_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_role_update_dto(INOUT update_dto dto.role_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_role auth.auth_role%rowtype;
begin
    if update_dto.old_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_role from auth.auth_role where not is_deleted and code = update_dto.old_code;

    if not FOUND then
        raise exception '%', settings.translate('ROLE_NOT_FOUND', 'UZ');
    end if;

    if update_dto.new_code is null then
        update_dto.new_code = t_role.code;
    else
        if exists(select * from auth.auth_role where not is_deleted and code = update_dto.new_code) then
            raise exception '%', settings.translate('ROLE_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;

    if update_dto.name is null then
        update_dto.name = t_role.name;
    end if;

    call settings.log_insert('checks.check_role_update_dto(INOUT update_dto dto.role_update_dto)');
end;
$$;


ALTER PROCEDURE checks.check_role_update_dto(INOUT update_dto dto.role_update_dto) OWNER TO postgres;

--
-- Name: check_sponsor_create_dto(dto.sponsor_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_sponsor_create_dto(p_dto dto.sponsor_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_sponsor system.sponsors;
begin
    if p_dto.name is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    select * into t_sponsor from system.sponsors where name = p_dto.name;

    if FOUND then
        raise exception '%', settings.translate('SPONSOR_FOUND', 'UZ');
    end if;

    if p_dto.email is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if p_dto.logo is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if p_dto.phone is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    if p_dto.location is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;
end;
$$;


ALTER PROCEDURE checks.check_sponsor_create_dto(p_dto dto.sponsor_create_dto) OWNER TO postgres;

--
-- Name: check_sponsor_update_dto(dto.sponsor_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_sponsor_update_dto(p_dto dto.sponsor_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_sponsor system.sponsors;
begin
    if p_dto.id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    select * into t_sponsor from system.sponsors where id = p_dto.id;

    if not FOUND then
        raise exception '%', settings.translate('SPONSOR_NOT_FOUND', 'UZ');
    end if;

    if p_dto.name is null then
        p_dto.name = t_sponsor.name;
    end if;

    if p_dto.email is null then
        p_dto.email = t_sponsor.email;
    end if;

    if p_dto.phone is null then
        p_dto.phone = t_sponsor.phone;
    end if;

    if p_dto.logo is null then
        p_dto.logo = t_sponsor.logo;
    end if;

    if p_dto.location is null then
        p_dto.location = t_sponsor.location;
    end if;
end;
$$;


ALTER PROCEDURE checks.check_sponsor_update_dto(p_dto dto.sponsor_update_dto) OWNER TO postgres;

--
-- Name: check_status_update_dto(dto.status_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_status_update_dto(INOUT update_dto dto.status_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_status auth.auth_status%rowtype;
begin
    if update_dto.old_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_status from auth.auth_status where not is_deleted and code = update_dto.old_code;

    if not FOUND then
        raise exception '%', settings.translate('STATUS_NOT_FOUND', 'UZ');
    end if;

    if update_dto.new_code is null then
        update_dto.new_code = t_status.code;
    else
        if exists(select * from auth.auth_status where not is_deleted and code = update_dto.new_code) then
            raise exception '%', settings.translate('STATUS_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;

    if update_dto.name is null then
        update_dto.name = t_status.name;
    end if;

    call settings.log_insert('checks.check_status_update_dto(INOUT update_dto dto.status_update_dto)');
end;
$$;


ALTER PROCEDURE checks.check_status_update_dto(INOUT update_dto dto.status_update_dto) OWNER TO postgres;

--
-- Name: product_comment_create_check(json); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.product_comment_create_check(datajson json)
    LANGUAGE plpgsql
    AS $$
declare
    t_product project.product;
begin
    if dataJson ->> 'product_id' is null then
        raise exception 'product_id %', settings.translate('PARAM_IS_NULL', 'UZ');
    end if;

    select * into t_product from project.product where not is_deleted and id = (dataJson ->> 'product_id')::integer;

    if not FOUND then
        raise exception 'product %', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;
end;
$$;


ALTER PROCEDURE checks.product_comment_create_check(datajson json) OWNER TO postgres;

--
-- Name: to_auth_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_auth_create_dto(datajson json) RETURNS dto.auth_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.auth_create_dto;
begin
    dto.username = dataJson ->> 'username';
    dto.password = dataJson ->> 'password';
    dto.email = dataJson ->> 'email';
    dto.phone = dataJson ->> 'phone';
    dto.language = dataJson ->> 'language';
    dto.profile_pic = dataJson ->> 'profile_pic';
    dto.chat_id = (dataJson ->> 'chat_id')::integer;
    dto.location = (dataJson ->> 'location')::point;
    dto.role = dataJson ->> 'role';
    dto.permission = datajson -> 'permission';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_auth_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_auth_list_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_auth_list_dto(datajson json) RETURNS dto.auth_list_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.auth_list_dto;
begin
    dto.username = dataJson ->> 'username';
    dto.email = dataJson ->> 'email';
    dto.phone = dataJson ->> 'phone';
    dto.profile_pic = dataJson ->> 'profile_pic';
    dto.chat_id = (dataJson ->> 'chat_id')::integer;
    dto.location = (dataJson ->> 'location')::point;
    dto.role = dataJson ->> 'role';
    dto.permission = dataJson ->> 'permission';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_auth_list_dto(datajson json) OWNER TO postgres;

--
-- Name: to_auth_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_auth_update_dto(datajson json) RETURNS dto.auth_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.auth_update_dto;
begin
    dto.id = (dataJson ->> 'id')::integer;
    dto.username = dataJson ->> 'username';
    dto.email = dataJson ->> 'email';
    dto.phone = dataJson ->> 'phone';
    dto.language = dataJson ->> 'language';
    dto.profile_pic = dataJson ->> 'profile_pic';
    dto.chat_id = (dataJson ->> 'chat_id')::integer;
    dto.location = (dataJson ->> 'location')::point;
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_auth_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_card_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_card_create_dto(datajson json) RETURNS dto.card_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.card_create_dto;
begin
    dto.user_id = (dataJson ->> 'user_id')::integer;
    dto.card_type = dataJson ->> 'card_type';
    dto.number = dataJson ->> 'number';
    dto.balance = dataJson ->> 'balance';
    dto.holder_name = dataJson ->> 'holder_name';
    dto.expire_date = dataJson ->> 'expire_date';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_card_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_card_list_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_card_list_dto(datajson json) RETURNS dto.card_list_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.card_list_dto;
begin
    dto.card_type = dataJson ->> 'card_type';
    dto.number = dataJson ->> 'number';
    dto.balance = dataJson ->> 'balance';
    dto.holder_name = dataJson ->> 'holder_name';
    dto.expire_date = dataJson ->> 'expire_date';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_card_list_dto(datajson json) OWNER TO postgres;

--
-- Name: to_card_type_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_card_type_update_dto(datajson json) RETURNS dto.card_type_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.card_type_update_dto;
begin
    dto.old_code = dataJson ->> 'old_code';
    dto.new_code = dataJson ->> 'new_code';
    dto.name = dataJson ->> 'name';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_card_type_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_card_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_card_update_dto(datajson json) RETURNS dto.card_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.card_update_dto;
begin
    dto.id = (dataJson ->> 'id')::integer;
    dto.card_type = dataJson ->> 'card_type';
    dto.balance = dataJson ->> 'balance';
    dto.holder_name = dataJson ->> 'holder_name';
    dto.expire_date = dataJson ->> 'expire_date';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_card_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_language_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_language_update_dto(datajson json) RETURNS dto.language_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.language_update_dto;
begin
    dto.old_code = dataJson ->> 'old_code';
    dto.new_code = dataJson ->> 'new_code';
    dto.name = dataJson ->> 'name';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_language_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_permission_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_permission_update_dto(datajson json) RETURNS dto.permission_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.permission_update_dto;
begin
    dto.old_code = dataJson ->> 'old_code';
    dto.new_code = dataJson ->> 'new_code';
    dto.name = dataJson ->> 'name';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_permission_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_product_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_create_dto(datajson json) RETURNS dto.product_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_create_dto;
begin
    dto.category_id = (dataJson ->> 'category_id')::integer;
    dto.title = dataJson ->> 'title';
    dto.code = dataJson ->> 'code';
    dto.count = (dataJson ->> 'count')::integer;
    dto.color = dataJson ->> 'color';
    dto.width = (dataJson ->> 'width')::numeric;
    dto.height = (dataJson ->> 'height')::numeric;
    dto.country = dataJson ->> 'country';
    dto.price = dataJson ->> 'price';
    dto.date_of_manufacture = dataJson ->> 'date_of_manufacture';
    dto.description = dataJson ->> 'description';
    dto.extra = dataJson ->> 'extra';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_product_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_product_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_update_dto(data json) RETURNS dto.product_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_update_dto;
begin
    dto.id = (data ->> 'id')::integer;
    dto.title = data ->> 'title';
    dto.count = (data ->> 'count')::integer;
    dto.color = data ->> 'color';
    dto.width = (data ->> 'width')::numeric;
    dto.height = (data ->> 'height')::numeric;
    dto.country = data ->> 'country';
    dto.date_of_manufacture = data ->> 'date_of_manufacture';
    dto.description = data ->> 'description';
    dto.price = data ->> 'price';
    dto.discount_percent = data ->> 'discount_percent';
    dto.extra = data ->> 'extra';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_product_update_dto(data json) OWNER TO postgres;

--
-- Name: to_reset_password_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_reset_password_dto(datajson json) RETURNS dto.reset_password
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.reset_password;
begin
    dto.id = (dataJson ->> 'id')::integer;
    dto.old_password = dataJson ->> 'old_password';
    dto.new_password = dataJson ->> 'new_password';
    dto.confirm_password = dataJson ->> 'confirm_password';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_reset_password_dto(datajson json) OWNER TO postgres;

--
-- Name: to_role_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_role_update_dto(datajson json) RETURNS dto.role_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.role_update_dto;
begin
    dto.old_code = dataJson ->> 'old_code';
    dto.new_code = dataJson ->> 'new_code';
    dto.name = dataJson ->> 'name';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_role_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_sponsor_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_sponsor_create_dto(data json) RETURNS dto.sponsor_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.sponsor_create_dto;
begin
    dto.name = data ->> 'name';
    dto.phone = data ->> 'phone';
    dto.email = data ->> 'email';
    dto.logo = data ->> 'logo';
    dto.location = data ->> 'location';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_sponsor_create_dto(data json) OWNER TO postgres;

--
-- Name: to_status_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_status_update_dto(datajson json) RETURNS dto.status_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.status_update_dto;
begin
    dto.old_code = dataJson ->> 'old_code';
    dto.new_code = dataJson ->> 'new_code';
    dto.name = dataJson ->> 'name';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_status_update_dto(datajson json) OWNER TO postgres;

--
-- Name: product_comment_create(character varying, integer, text); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_comment_create(data character varying, p_user_id integer, INOUT result_text text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson      json;
    return_pro_id bigint;
BEGIN
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    call checks.product_comment_create_check(dataJson);

    insert into project.product_comment (product_id, user_id, message, created_by)
    values ((dataJson ->> 'product_id')::integer, p_user_id, dataJson ->> 'message', p_user_id)
    returning id into return_pro_id;

    call settings.log_insert('project.product_comment_create(data character varying, p_user_id integer, INOUT result_text text default ''''::text)');
    result_text = 'id = ' || return_pro_id;
end;
$$;


ALTER PROCEDURE project.product_comment_create(data character varying, p_user_id integer, INOUT result_text text) OWNER TO postgres;

--
-- Name: product_comment_delete(bigint, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_comment_delete(p_comment_id bigint, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_product_comment project.product_comment;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT', p_user_id);
    select * into t_product_comment from project.product_comment where not is_deleted and id = p_comment_id;

    if not FOUND then
        raise exception 'comment not found';
    end if;

    update project.product_comment set is_deleted = true where id = p_comment_id;

    call settings.log_insert('project.product_comment_delete(p_comment_id bigint, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.product_comment_delete(p_comment_id bigint, p_user_id integer) OWNER TO postgres;

--
-- Name: product_create(character varying, integer, text); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_create(data character varying, p_user_id integer, INOUT p_result text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    dto           dto.product_create_dto;
    dataJson      json;
    return_pro_id bigint;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_product_create_dto(dataJson);
    call checks.check_product_create_dto(dto);
    call auth.has_permission('CREATE_PRODUCT', p_user_id);

    insert into project.product (category_id, title, code, count, color, width, height, country, date_of_manufacture,
                                 description, extra, created_by)
    values (dto.category_id, dto.title, dto.code, dto.count, dto.color, dto.width, dto.height, dto.country,
            (dto.date_of_manufacture)::timestamptz, dto.description, (dto.extra)::json, p_user_id)
    returning id into return_pro_id;

    if not dataJson ->> 'image' is null then
        insert into project.product_image (product_id, product_pic, created_by)
        values (return_pro_id, dataJson ->> 'image', p_user_id);
    end if;

    insert into project.product_rating (product_id, views, purchased, created_by)
    values (return_pro_id, 0, 0, p_user_id);

    insert into project.product_price (product_id, price, created_by) values (return_pro_id, dto.price, p_user_id);
    call settings.log_insert('project.product_create(data character varying, p_user_id bigint, INOUT p_result text DEFAULT ''''::text)');
    p_result = 'id = ' || return_pro_id;
end;
$$;


ALTER PROCEDURE project.product_create(data character varying, p_user_id integer, INOUT p_result text) OWNER TO postgres;

--
-- Name: product_delete(integer, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_delete(p_product_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_product project.product;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT', p_user_id);
    select * into t_product from project.product where not is_deleted and id = p_product_id;

    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;

    update project.product set is_deleted = true where id = p_product_id;

    update project.product_price set is_deleted = true where product_id = p_product_id;

    call settings.log_insert('project.project_delete(p_product_id integer, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.product_delete(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_image_add(character varying, integer, text); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_image_add(data character varying, p_user_id integer, INOUT p_result text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    t_product       project.product;
    dataJson        json    := data;
    image_json      jsonb;
    image_path      json;
    array_length    integer;
    image_text      text;
    json_text_array text;
    i_for           integer := 0;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    if dataJson ->> 'product_id' is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_product from project.product where id = (dataJson ->> 'product_id')::bigint;

    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    for image_path in select * from json_array_element(dataJson ->> 'image', i_for)
        loop
            insert into project.product_image (product_id, product_pic, created_by)
            values (dataJson ->> 'product_id', (image_path)::text, p_user_id);
            i_for := i_for + 1;
        end loop;

    call settings.log_insert('project.product_image_add(data character varying, p_user_id integer)');
    p_result = 'array_length = ' || array_length;
end;
$$;


ALTER PROCEDURE project.product_image_add(data character varying, p_user_id integer, INOUT p_result text) OWNER TO postgres;

--
-- Name: product_image_delete(integer, integer, text); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_image_delete(product_image_id integer, p_user_id integer, INOUT p_result text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    t_product_image project.product_image;
    p_delete        boolean;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT', p_user_id);
    select * into t_product_image from project.product_image where not is_deleted and id = product_image_id;

    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    update project.product_image set is_deleted = true where id = product_image_id returning is_deleted into p_delete;

    call settings.log_insert('project.product_image_delete(product_image_id integer, p_user_id integer)');
    p_result = 'is_deleted = ' || p_delete;
end;
$$;


ALTER PROCEDURE project.product_image_delete(product_image_id integer, p_user_id integer, INOUT p_result text) OWNER TO postgres;

--
-- Name: product_image_delete_all(integer, integer, text); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_image_delete_all(p_product_id integer, p_user_id integer, INOUT p_result text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    t_product_image project.product_image;
    p_delete        boolean;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT', p_user_id);
    select * into t_product_image from project.product_image where not is_deleted and id = p_product_id;

    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    update project.product_image
    set is_deleted = true
    where product_id = p_product_id
    returning is_deleted into p_delete;

    call settings.log_insert('project.product_image_delete(product_image_id integer, p_user_id integer)');
    p_result = 'all_deleted = ' || p_delete;
end;
$$;


ALTER PROCEDURE project.product_image_delete_all(p_product_id integer, p_user_id integer, INOUT p_result text) OWNER TO postgres;

--
-- Name: product_price_add(character varying, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_price_add(data character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_product_price project.product_price;
    dataJson        json := data;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    call auth.has_permission('CREATE_PRODUCT', p_user_id);

    if dataJson ->> 'price' is null then
        raise exception 'price is null';
    end if;

    if dataJson ->> 'product_id' is null then
        raise exception 'product id is null';
    end if;

    select * into t_product_price from project.product_price where product_id = (dataJson ->> 'product_id')::bigint;

    if not FOUND then
        insert into project.product_price (product_id, price, created_by)
        values ((dataJson ->> 'product_id')::bigint, dataJson ->> 'price', p_user_id);
    else
        update project.product_price
        set price      = dataJson ->> 'price',
            updated_at = now(),
            updated_by = p_user_id
        where product_id = (dataJson ->> 'product_id')::bigint;
    end if;

    call settings.log_insert('project.product_price_add(data character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.product_price_add(data character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: product_price_delete(bigint, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_price_delete(p_price_id bigint, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_price project.product_price;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT', p_user_id);
    if p_price_id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_price from project.product_price where id = p_price_id;

    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    update project.product_price set is_deleted = true where id = p_price_id;

    call settings.log_insert('project.product_price_delete(p_price_id bigint, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.product_price_delete(p_price_id bigint, p_user_id integer) OWNER TO postgres;

--
-- Name: product_update(character varying, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_update(data character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto      dto.product_update_dto;
    dataJson json;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_product_update_dto(dataJson);
    call checks.check_product_update_dto(dto);
    call auth.has_permission('UPDATE_PRODUCT', p_user_id);

    update project.product
    set title               = dto.title,
        count               = dto.count,
        color               = dto.color,
        width               = dto.width,
        height              = dto.height,
        country             = dto.country,
        date_of_manufacture = (dto.date_of_manufacture)::timestamptz,
        description         = dto.description,
        updated_at          = now(),
        updated_by          = p_user_id,
        extra               = (dto.extra)::json
    where not is_deleted
      and id = dto.id;

    update project.product_price
    set price            = dto.price,
        discount_percent = dto.discount_percent,
        updated_at       = now(),
        updated_by       = p_user_id
    where not is_deleted
      and product_id = dto.id;

    call settings.log_insert('project.product_update(data character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.product_update(data character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: log_insert(text); Type: PROCEDURE; Schema: settings; Owner: postgres
--

CREATE PROCEDURE settings.log_insert(p_body text)
    LANGUAGE plpgsql
    AS $$
begin
    insert into settings.log (body, created_by) values (p_body, -1);
end
$$;


ALTER PROCEDURE settings.log_insert(p_body text) OWNER TO postgres;

--
-- Name: translate(text, character); Type: FUNCTION; Schema: settings; Owner: postgres
--

CREATE FUNCTION settings.translate(message_code text, language_code character) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_language auth.auth_language%rowtype;
    t_message  settings.message%rowtype;
begin
    if message_code is null then
        raise exception '% - message_code', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if language_code is null then
        raise exception '% - language_code', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_language from auth.auth_language where not is_deleted and code = language_code;

    if t_language is null then
        raise exception '%', settings.translate('LANGUAGE_NOT_FOUND', 'UZ');
    end if;

    select * into t_message from settings.message where not is_deleted and code = message_code and language = language_code;

    if t_message is null then
        raise exception '%', settings.translate('MESSAGE_CODE_NOT_FOUND', language_code);
    else
        return t_message.message;
    end if;
end;
$$;


ALTER FUNCTION settings.translate(message_code text, language_code character) OWNER TO postgres;

--
-- Name: comment_create(character varying, integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.comment_create(p_message character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    response  text;
    return_id integer;
begin
    call auth.is_active(p_user_id);
    if p_message is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    insert into system.comment (user_id, message, created_by)
    values (p_user_id, p_message, p_user_id)
    returning id into return_id;

    call settings.log_insert('system.comment_create(message varchar, p_user_id integer)');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION system.comment_create(p_message character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: comment_delete(bigint, integer, text); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.comment_delete(comment_id bigint, p_user_id integer, INOUT p_result text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    t_comment     system.comment;
    is_delete_res boolean;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_COMMENT', p_user_id);
    if comment_id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', p_user_id);
    end if;

    select * into t_comment from system.comment where id = comment_id;

    if not FOUND then
        raise exception '%', settings.translate('COMMENT_NOT_FOUND', p_user_id);
    end if;

    update system.comment set is_deleted = true where id = comment_id returning is_deleted into is_delete_res;

    call settings.log_insert('system.comment_create(message varchar, p_user_id integer)');
    p_result = 'id = ' || comment_id || ', is_deleted = ' || is_delete_res;
end;
$$;


ALTER PROCEDURE system.comment_delete(comment_id bigint, p_user_id integer, INOUT p_result text) OWNER TO postgres;

--
-- Name: comment_list(integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.comment_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    js_comment  jsonb;
    js_comments jsonb = '[]';
    p_comment   system.comment%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_COMMENT', p_user_id);


    for p_comment in (select * from system.comment where not is_deleted)
        loop
            js_comment = json_build_object('user_id', p_comment.user_id);
            js_comment = js_comment || jsonb_build_object('message', p_comment.message);
            js_comment = js_comment || jsonb_build_object('created_at', p_comment.created_at);
            js_comments = js_comments || js_comment;
        end loop;

    call settings.log_insert('system.comment_list(p_user_id integer) returns text');
    return js_comments::text;
end;
$$;


ALTER FUNCTION system.comment_list(p_user_id integer) OWNER TO postgres;

--
-- Name: help_create(text, integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.help_create(p_body text, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    return_id bigint;
    response  text;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CREATE_HELP', p_user_id);
    if p_body is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    insert into system.help (body, created_by) values (p_body, p_user_id) returning id into return_id;
    call settings.log_insert('system.help_create(p_body text, p_user_id integer) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION system.help_create(p_body text, p_user_id integer) OWNER TO postgres;

--
-- Name: help_delete(bigint, integer); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.help_delete(p_help_id bigint, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_help system.help;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_HELP', p_user_id);
    if p_help_id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_help from system.help where not is_deleted and id = p_help_id;

    if not FOUND then
        raise exception '%',settings.translate('', utils.user_id_get_by_lang(p_user_id));
    end if;

    update system.help set is_deleted = true where id = p_help_id;

    call settings.log_insert('system.help_delete(p_help_id bigint, p_user_id integer)');
end;
$$;


ALTER PROCEDURE system.help_delete(p_help_id bigint, p_user_id integer) OWNER TO postgres;

--
-- Name: help_lists(integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.help_lists(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    js_help  jsonb;
    js_helps jsonb = '[]';
    p_help   system.help%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_HELP', p_user_id);

    for p_help in (select * from system.help where not is_deleted)
        loop
            js_help = jsonb_build_object('body', p_help.body);
            js_help = js_help || jsonb_build_object('created_at', p_help.created_at);
            js_helps = js_helps || js_help;
        end loop;

    call settings.log_insert('system.list_rule(p_user_id integer) returns text');
    return js_helps::text;
end;
$$;


ALTER FUNCTION system.help_lists(p_user_id integer) OWNER TO postgres;

--
-- Name: help_update(bigint, text, integer); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.help_update(p_help_id bigint, p_body text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_help system.help%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('UPDATE_HELP', p_user_id);
    if p_help_id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_help from system.help where not is_deleted and id = p_help_id;

    if not FOUND then
        raise exception '%',settings.translate('', utils.user_id_get_by_lang(p_user_id));
    end if;

    update system.help set body = p_body, updated_at = now(), updated_by = p_user_id where id = p_help_id;
    call settings.log_insert('system.help_update(p_help_id bigint, p_body text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE system.help_update(p_help_id bigint, p_body text, p_user_id integer) OWNER TO postgres;

--
-- Name: rule_create(character varying, text, integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.rule_create(p_type character varying, p_body text, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_rule    system.rule;
    return_id bigint;
    response  text;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CREATE_RULE_TYPE', p_user_id);
    if p_type is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    if p_body is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_rule from system.rule where type = p_type;

    if FOUND then
        raise exception '%', settings.translate('RULE_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    insert into system.rule (type, body, created_by) values (p_type, p_body, p_user_id) returning id into return_id;

    call settings.log_insert('system.rule_create(p_type varchar, p_body text, p_user_id integer)');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION system.rule_create(p_type character varying, p_body text, p_user_id integer) OWNER TO postgres;

--
-- Name: rule_delete(bigint, integer); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.rule_delete(p_rule_id bigint, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_rule system.rule;
begin
    if p_rule_id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_rule from system.rule where id = p_rule_id;

    if not FOUND then
        raise exception '%', settings.translate('RULE_NOT_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    update system.rule set is_deleted = true where id = p_rule_id;
    call settings.log_insert('system.rule_delete(p_rule_id bigint, p_user_id integer)');
end;
$$;


ALTER PROCEDURE system.rule_delete(p_rule_id bigint, p_user_id integer) OWNER TO postgres;

--
-- Name: rule_list(integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.rule_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    js_rule  jsonb;
    js_rules jsonb = '[]';
    p_rule   system.rule%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_RULE_TYPE', p_user_id);

    for p_rule in (select * from system.rule where not is_deleted)
        loop
            js_rule = jsonb_build_object('type', p_rule.type);
            js_rule = js_rule || jsonb_build_object('body', p_rule.body);
            js_rules = js_rules || js_rule;
        end loop;

    call settings.log_insert('system.list_rule(p_user_id integer) returns text');
    return js_rules::text;
end;
$$;


ALTER FUNCTION system.rule_list(p_user_id integer) OWNER TO postgres;

--
-- Name: rule_type_create(character varying, character varying, integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.rule_type_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_rule_type system.rule_type%rowtype;
    return_id   bigint;
    response    text;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CREATE_RULE_TYPE', p_user_id);
    if p_name is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    if p_code is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_rule_type from system.rule_type where code = p_code;

    if FOUND then
        raise exception '%', settings.translate('RULE_TYPE_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    insert into system.rule_type (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into return_id;


    call settings.log_insert('system.rule_type_create(p_name varchar, p_code varchar, p_user_id integer)');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION system.rule_type_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: rule_type_delete(bigint, integer); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.rule_type_delete(p_rule_type_id bigint, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_rule_type system.rule_type;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_RULE_TYPE', p_user_id);
    if p_rule_type_id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_rule_type from system.rule_type where id = p_rule_type_id;

    if not FOUND then
        raise exception '%', settings.translate('RULE_TYPE_NOT_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    update system.rule_type set is_deleted = true where id = p_rule_type_id;

    call settings.log_insert('system.rule_type_delete(p_rule_type_id bigint, p_user_id integer)');
end;
$$;


ALTER PROCEDURE system.rule_type_delete(p_rule_type_id bigint, p_user_id integer) OWNER TO postgres;

--
-- Name: rule_type_list(integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.rule_type_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    js_rule_type  jsonb;
    js_rule_types jsonb = '[]';
    p_rule_type   system.rule_type%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_RULE_TYPE', p_user_id);

    for p_rule_type in (select * from system.rule_type where not is_deleted)
        loop
            js_rule_type = jsonb_build_object('name', p_rule_type.name);
            js_rule_type = js_rule_type || jsonb_build_object('code', p_rule_type.code);
            js_rule_types = js_rule_types || js_rule_type;
        end loop;

    call settings.log_insert('system.rule_type_list(p_user_id integer) returns text');
    return js_rule_types::text;
end;
$$;


ALTER FUNCTION system.rule_type_list(p_user_id integer) OWNER TO postgres;

--
-- Name: rule_type_update(bigint, character varying, character varying, integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.rule_type_update(p_rule_type_id bigint, p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_rule_type  system.rule_type%rowtype;
    up_rule_type system.rule_type%rowtype;
    response     text;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('UPDATE_RULE_TYPE', p_user_id);
    if p_rule_type_id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_rule_type from system.rule_type where id = p_rule_type_id;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    up_rule_type.id = p_rule_type_id;

    if not p_name is null then
        up_rule_type.name = p_name;
    else
        up_rule_type.name = t_rule_type.name;
    end if;

    if not p_code is null then
        up_rule_type.code = p_code;
    else
        up_rule_type.code = t_rule_type.code;
    end if;

    update system.rule_type
    set name       = up_rule_type.name,
        code       = up_rule_type.code,
        updated_by = p_user_id,
        updated_at = now()
    where id = p_rule_type_id;

    call settings.log_insert('system.rule_type_update(p_rule_type_id bigint, p_name varchar, p_code varchar, p_user_id integer) returns text');
    response = 'id = ' || p_rule_type_id;
    return response;
end;
$$;


ALTER FUNCTION system.rule_type_update(p_rule_type_id bigint, p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: rule_update(bigint, character varying, text, integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.rule_update(p_rule_id bigint, p_type character varying, p_body text, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_rule   system.rule%rowtype;
    up_rule  system.rule%rowtype;
    response text;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('UPDATE_RULE_TYPE', p_user_id);

    if p_rule_id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_rule from system.rule where id = p_rule_id;

    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    up_rule.id = p_rule_id;

    if not p_type is null then
        up_rule.type = p_type;
    else
        up_rule.type = t_rule.type;
    end if;

    if not p_body is null then
        up_rule.body = p_body;
    else
        up_rule.body = t_rule.body;
    end if;

    update system.rule
    set type       = up_rule.type,
        body       = up_rule.body,
        updated_by = p_user_id,
        updated_at = now()
    where id = p_rule_id;

    call settings.log_insert('system.rule_update(p_rule_id bigint, p_type varchar, p_body text, p_user_id integer)');
    response = 'id = ' || p_rule_id;
    return response;
end;
$$;


ALTER FUNCTION system.rule_update(p_rule_id bigint, p_type character varying, p_body text, p_user_id integer) OWNER TO postgres;

--
-- Name: sponsor_create(character varying, integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.sponsor_create(data character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    dataJson  json := data;
    dto       dto.sponsor_create_dto;
    return_id bigint;
    response  text;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    call auth.has_permission('CREATE_SPONSOR', p_user_id);
    dto = mappers.to_sponsor_create_dto(dataJson);
    call checks.check_sponsor_create_dto(dto);

    insert into system.sponsors (name, phone, email, logo, location, created_by)
    values (dto.name, dto.phone, dto.email, dto.logo, dto.location, p_user_id)
    returning id into return_id;

    call settings.log_insert('function system.sponsor_create(data character varying, p_user_id integer) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION system.sponsor_create(data character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: sponsor_delete(bigint, integer, text); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.sponsor_delete(p_sponsor_id bigint, p_user_id integer, INOUT response text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    t_sponsor      system.sponsors;
    res_is_deleted boolean;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_SPONSOR', p_user_id);
    if p_sponsor_id is null then
        raise exception '%', settings.translate('PARAM_IS_NULL', utils.user_id_get_by_lang(p_user_id));
    end if;

    select * into t_sponsor from system.sponsors where id = p_sponsor_id;

    if not FOUND then
        raise exception '%', settings.translate('SPONSOR_NOT_FOUND', utils.user_id_get_by_lang(p_user_id));
    end if;

    update system.sponsors set is_deleted = true where id = p_sponsor_id returning is_deleted into res_is_deleted;
    call settings.log_insert('function system.sponsor_create(data character varying, p_user_id integer) returns text');
    response = 'id = ' || p_sponsor_id || ', is_deleted = ' || res_is_deleted;
end;
$$;


ALTER PROCEDURE system.sponsor_delete(p_sponsor_id bigint, p_user_id integer, INOUT response text) OWNER TO postgres;

--
-- Name: sponsor_list(integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.sponsor_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    js_sponsor  jsonb;
    js_sponsors jsonb = '[]';
    p_sponsor   system.sponsors%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_SPONSOR', p_user_id);

    for p_sponsor in (select * from system.sponsors where not is_deleted)
        loop
            js_sponsor = json_build_object('name', p_sponsor.name);
            js_sponsor = js_sponsor || json_build_object('phone', p_sponsor.phone);
            js_sponsor = js_sponsor || json_build_object('email', p_sponsor.email);
            js_sponsor = js_sponsor || json_build_object('logo', p_sponsor.logo);
            js_sponsor = js_sponsor || json_build_object('location', p_sponsor.location);
            js_sponsors = js_sponsors || js_sponsor;
        end loop;

    call settings.log_insert('system.sponsor_list(p_user_id integer) returns text');
    return js_sponsors::text;
end;
$$;


ALTER FUNCTION system.sponsor_list(p_user_id integer) OWNER TO postgres;

--
-- Name: sponsor_update(character varying, integer); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.sponsor_update(data character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson jsonb := data;
    dto      dto.sponsor_update_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    call auth.has_permission('UPDATE_SPONSOR', p_user_id);
    dto = mappers.to_sponsor_update_dto(dataJson);
    call checks.check_sponsor_update_dto(dto);

    update system.sponsors
    set name       = dto.name,
        phone      = dto.phone,
        email      = dto.email,
        logo       = dto.logo,
        location   = dto.location,
        updated_at = now(),
        updated_by = p_user_id
    where id = dto.id;

    call settings.log_insert('function system.sponsor_update(data character varying, p_user_id integer) returns text');
end;
$$;


ALTER PROCEDURE system.sponsor_update(data character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: check_data(text); Type: PROCEDURE; Schema: utils; Owner: postgres
--

CREATE PROCEDURE utils.check_data(data text)
    LANGUAGE plpgsql
    AS $$
begin
    if data is null or '{}'::text = data or '' = data then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
end;
$$;


ALTER PROCEDURE utils.check_data(data text) OWNER TO postgres;

--
-- Name: encoding_password(character varying); Type: FUNCTION; Schema: utils; Owner: postgres
--

CREATE FUNCTION utils.encoding_password(password character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
begin
    return buildIns.crypt(password, buildIns.gen_salt('bf', 4));
end;
$$;


ALTER FUNCTION utils.encoding_password(password character varying) OWNER TO postgres;

--
-- Name: matches(character varying, character varying); Type: FUNCTION; Schema: utils; Owner: postgres
--

CREATE FUNCTION utils.matches(password character varying, encoded_password character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
begin
    return encoded_password = buildIns.crypt(password, encoded_password);
end;
$$;


ALTER FUNCTION utils.matches(password character varying, encoded_password character varying) OWNER TO postgres;

--
-- Name: user_id_get_by_lang(integer); Type: FUNCTION; Schema: utils; Owner: postgres
--

CREATE FUNCTION utils.user_id_get_by_lang(p_user_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user;
begin
    if p_user_id is null then
        raise exception 'p_user_id param is null';
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and id = p_user_id;

    if not FOUND then
        raise exception 'user not found';
    end if;

    return t_auth_user.language;
end;
$$;


ALTER FUNCTION utils.user_id_get_by_lang(p_user_id integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_balance; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_balance (
    id integer NOT NULL,
    card_id integer NOT NULL,
    amount character varying(30) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_balance OWNER TO postgres;

--
-- Name: auth_balance_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_balance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_balance_id_seq OWNER TO postgres;

--
-- Name: auth_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_balance_id_seq OWNED BY auth.auth_balance.id;


--
-- Name: auth_block; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_block (
    id integer NOT NULL,
    user_id integer NOT NULL,
    duration timestamp without time zone NOT NULL,
    blocked_for character varying NOT NULL,
    blocked_at timestamp without time zone DEFAULT now(),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_block OWNER TO postgres;

--
-- Name: auth_block_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_block_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_block_id_seq OWNER TO postgres;

--
-- Name: auth_block_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_block_id_seq OWNED BY auth.auth_block.id;


--
-- Name: auth_card; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_card (
    id integer NOT NULL,
    user_id integer NOT NULL,
    card_type character varying(100) NOT NULL,
    number character(16) NOT NULL,
    holder_name character varying NOT NULL,
    expire_date character(4) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_card OWNER TO postgres;

--
-- Name: auth_card_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_card_id_seq OWNER TO postgres;

--
-- Name: auth_card_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_card_id_seq OWNED BY auth.auth_card.id;


--
-- Name: auth_card_type; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_card_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(100),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_card_type OWNER TO postgres;

--
-- Name: auth_card_type_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_card_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_card_type_id_seq OWNER TO postgres;

--
-- Name: auth_card_type_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_card_type_id_seq OWNED BY auth.auth_card_type.id;


--
-- Name: auth_language; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_language (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    code character(2),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_language OWNER TO postgres;

--
-- Name: auth_language_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_language_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_language_id_seq OWNER TO postgres;

--
-- Name: auth_language_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_language_id_seq OWNED BY auth.auth_language.id;


--
-- Name: auth_permission; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_permission (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    code character varying(150),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_permission_id_seq OWNED BY auth.auth_permission.id;


--
-- Name: auth_role; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_role (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    code character varying(30),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_role OWNER TO postgres;

--
-- Name: auth_role_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_role_id_seq OWNER TO postgres;

--
-- Name: auth_role_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_role_id_seq OWNED BY auth.auth_role.id;


--
-- Name: auth_role_permission; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_role_permission (
    id integer NOT NULL,
    auth_user_role_id integer NOT NULL,
    permission_id integer NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_role_permission OWNER TO postgres;

--
-- Name: auth_role_permission_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_role_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_role_permission_id_seq OWNER TO postgres;

--
-- Name: auth_role_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_role_permission_id_seq OWNED BY auth.auth_role_permission.id;


--
-- Name: auth_session; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_session (
    id integer NOT NULL,
    token_id integer NOT NULL,
    user_code uuid NOT NULL,
    username character varying(100) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_session OWNER TO postgres;

--
-- Name: auth_session_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_session_id_seq OWNER TO postgres;

--
-- Name: auth_session_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_session_id_seq OWNED BY auth.auth_session.id;


--
-- Name: auth_status; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_status (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    code character varying(30),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_status OWNER TO postgres;

--
-- Name: auth_status_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_status_id_seq OWNER TO postgres;

--
-- Name: auth_status_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_status_id_seq OWNED BY auth.auth_status.id;


--
-- Name: auth_token; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_token (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token text DEFAULT ((((date_part('MILLISECONDS'::text, CURRENT_TIMESTAMP) || ''::text) || (gen_random_uuid())::text) || ''::text) || date_part('MILLISECONDS'::text, CURRENT_TIMESTAMP)),
    duration timestamp without time zone DEFAULT (now() + '00:10:00'::interval),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE auth.auth_token OWNER TO postgres;

--
-- Name: auth_token_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_token_id_seq OWNER TO postgres;

--
-- Name: auth_token_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_token_id_seq OWNED BY auth.auth_token.id;


--
-- Name: auth_user; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_user (
    id integer NOT NULL,
    code uuid DEFAULT buildins.gen_random_uuid(),
    username character varying(100),
    password character varying NOT NULL,
    email character varying(100),
    phone character(13),
    chat_id integer,
    last_login_at timestamp without time zone,
    language character(2) NOT NULL,
    status character varying(30) NOT NULL,
    login_try_count smallint DEFAULT 0,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer,
    profile_pic text,
    location point
);


ALTER TABLE auth.auth_user OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_user_id_seq OWNED BY auth.auth_user.id;


--
-- Name: auth_user_role; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_user_role (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id character varying(30) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE auth.auth_user_role OWNER TO postgres;

--
-- Name: auth_user_role_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.auth_user_role_id_seq OWNER TO postgres;

--
-- Name: auth_user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.auth_user_role_id_seq OWNED BY auth.auth_user_role.id;


--
-- Name: basket; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.basket (
    id integer NOT NULL,
    user_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    product_count smallint NOT NULL,
    total_price character varying(50) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.basket OWNER TO postgres;

--
-- Name: basket_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.basket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.basket_id_seq OWNER TO postgres;

--
-- Name: basket_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.basket_id_seq OWNED BY project.basket.id;


--
-- Name: category; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.category (
    id integer NOT NULL,
    parent_id integer,
    title character varying NOT NULL,
    code character varying,
    category_pic text,
    description text,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.category OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.category_id_seq OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.category_id_seq OWNED BY project.category.id;


--
-- Name: like; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project."like" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project."like" OWNER TO postgres;

--
-- Name: like_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.like_id_seq OWNER TO postgres;

--
-- Name: like_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.like_id_seq OWNED BY project."like".id;


--
-- Name: order; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project."order" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type character varying(150) NOT NULL,
    status character varying(150) NOT NULL,
    product_count smallint NOT NULL,
    total_price character varying(50) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer,
    card_id integer
);


ALTER TABLE project."order" OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.order_id_seq OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.order_id_seq OWNED BY project."order".id;


--
-- Name: order_status; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.order_status (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    code character varying(50),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.order_status OWNER TO postgres;

--
-- Name: order_status_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.order_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.order_status_id_seq OWNER TO postgres;

--
-- Name: order_status_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.order_status_id_seq OWNED BY project.order_status.id;


--
-- Name: order_type; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.order_type (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    code character varying(150),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.order_type OWNER TO postgres;

--
-- Name: order_type_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.order_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.order_type_id_seq OWNER TO postgres;

--
-- Name: order_type_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.order_type_id_seq OWNED BY project.order_type.id;


--
-- Name: product; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.product (
    id integer NOT NULL,
    category_id integer NOT NULL,
    title character varying NOT NULL,
    code character varying,
    count smallint NOT NULL,
    color character varying(100),
    width numeric(10,2),
    height numeric(10,2),
    country character varying,
    date_of_manufacture timestamp without time zone,
    description text,
    extra json,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer,
    is_published boolean DEFAULT false
);


ALTER TABLE project.product OWNER TO postgres;

--
-- Name: product_comment; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.product_comment (
    id integer NOT NULL,
    product_id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.product_comment OWNER TO postgres;

--
-- Name: product_comment_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.product_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.product_comment_id_seq OWNER TO postgres;

--
-- Name: product_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.product_comment_id_seq OWNED BY project.product_comment.id;


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.product_id_seq OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.product_id_seq OWNED BY project.product.id;


--
-- Name: product_image; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.product_image (
    id integer NOT NULL,
    product_id integer NOT NULL,
    product_pic text NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.product_image OWNER TO postgres;

--
-- Name: product_image_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.product_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.product_image_id_seq OWNER TO postgres;

--
-- Name: product_image_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.product_image_id_seq OWNED BY project.product_image.id;


--
-- Name: product_price; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.product_price (
    id integer NOT NULL,
    product_id integer NOT NULL,
    price character varying(30) NOT NULL,
    discount_percent smallint DEFAULT 0,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.product_price OWNER TO postgres;

--
-- Name: product_price_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.product_price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.product_price_id_seq OWNER TO postgres;

--
-- Name: product_price_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.product_price_id_seq OWNED BY project.product_price.id;


--
-- Name: product_rating; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.product_rating (
    id integer NOT NULL,
    product_id integer NOT NULL,
    views smallint NOT NULL,
    purchased smallint NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.product_rating OWNER TO postgres;

--
-- Name: product_rating_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.product_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.product_rating_id_seq OWNER TO postgres;

--
-- Name: product_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.product_rating_id_seq OWNED BY project.product_rating.id;


--
-- Name: transaction; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.transaction (
    id integer NOT NULL,
    user_id integer NOT NULL,
    order_id integer NOT NULL,
    type character varying(100) NOT NULL,
    status character varying(100) NOT NULL,
    quantity character varying(50) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.transaction OWNER TO postgres;

--
-- Name: transaction_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.transaction_id_seq OWNER TO postgres;

--
-- Name: transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.transaction_id_seq OWNED BY project.transaction.id;


--
-- Name: transaction_status; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.transaction_status (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(100),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.transaction_status OWNER TO postgres;

--
-- Name: transaction_status_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.transaction_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.transaction_status_id_seq OWNER TO postgres;

--
-- Name: transaction_status_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.transaction_status_id_seq OWNED BY project.transaction_status.id;


--
-- Name: transaction_type; Type: TABLE; Schema: project; Owner: postgres
--

CREATE TABLE project.transaction_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(100),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE project.transaction_type OWNER TO postgres;

--
-- Name: transaction_type_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE project.transaction_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.transaction_type_id_seq OWNER TO postgres;

--
-- Name: transaction_type_id_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE project.transaction_type_id_seq OWNED BY project.transaction_type.id;


--
-- Name: log; Type: TABLE; Schema: settings; Owner: postgres
--

CREATE TABLE settings.log (
    id integer NOT NULL,
    body text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL
);


ALTER TABLE settings.log OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: settings; Owner: postgres
--

CREATE SEQUENCE settings.log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE settings.log_id_seq OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: settings; Owner: postgres
--

ALTER SEQUENCE settings.log_id_seq OWNED BY settings.log.id;


--
-- Name: message; Type: TABLE; Schema: settings; Owner: postgres
--

CREATE TABLE settings.message (
    id integer NOT NULL,
    message text NOT NULL,
    code text,
    language character(2) NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE settings.message OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: settings; Owner: postgres
--

CREATE SEQUENCE settings.message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE settings.message_id_seq OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: settings; Owner: postgres
--

ALTER SEQUENCE settings.message_id_seq OWNED BY settings.message.id;


--
-- Name: comment; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.comment (
    id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE system.comment OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE system.comment_id_seq OWNER TO postgres;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.comment_id_seq OWNED BY system.comment.id;


--
-- Name: help; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.help (
    id integer NOT NULL,
    body text NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE system.help OWNER TO postgres;

--
-- Name: help_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.help_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE system.help_id_seq OWNER TO postgres;

--
-- Name: help_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.help_id_seq OWNED BY system.help.id;


--
-- Name: rule; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.rule (
    id integer NOT NULL,
    type character varying(250) NOT NULL,
    body text NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE system.rule OWNER TO postgres;

--
-- Name: rule_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE system.rule_id_seq OWNER TO postgres;

--
-- Name: rule_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.rule_id_seq OWNED BY system.rule.id;


--
-- Name: rule_type; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.rule_type (
    id integer NOT NULL,
    name character varying(250) NOT NULL,
    code character varying(250),
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE system.rule_type OWNER TO postgres;

--
-- Name: rule_type_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.rule_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE system.rule_type_id_seq OWNER TO postgres;

--
-- Name: rule_type_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.rule_type_id_seq OWNED BY system.rule_type.id;


--
-- Name: sponsors; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.sponsors (
    id integer NOT NULL,
    name character varying NOT NULL,
    phone character(13),
    email character varying(100),
    logo text NOT NULL,
    location character varying NOT NULL,
    is_deleted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone,
    updated_by integer
);


ALTER TABLE system.sponsors OWNER TO postgres;

--
-- Name: sponsors_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.sponsors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE system.sponsors_id_seq OWNER TO postgres;

--
-- Name: sponsors_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.sponsors_id_seq OWNED BY system.sponsors.id;


--
-- Name: auth_balance id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_balance ALTER COLUMN id SET DEFAULT nextval('auth.auth_balance_id_seq'::regclass);


--
-- Name: auth_block id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_block ALTER COLUMN id SET DEFAULT nextval('auth.auth_block_id_seq'::regclass);


--
-- Name: auth_card id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_card ALTER COLUMN id SET DEFAULT nextval('auth.auth_card_id_seq'::regclass);


--
-- Name: auth_card_type id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_card_type ALTER COLUMN id SET DEFAULT nextval('auth.auth_card_type_id_seq'::regclass);


--
-- Name: auth_language id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_language ALTER COLUMN id SET DEFAULT nextval('auth.auth_language_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_permission ALTER COLUMN id SET DEFAULT nextval('auth.auth_permission_id_seq'::regclass);


--
-- Name: auth_role id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_role ALTER COLUMN id SET DEFAULT nextval('auth.auth_role_id_seq'::regclass);


--
-- Name: auth_role_permission id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_role_permission ALTER COLUMN id SET DEFAULT nextval('auth.auth_role_permission_id_seq'::regclass);


--
-- Name: auth_session id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_session ALTER COLUMN id SET DEFAULT nextval('auth.auth_session_id_seq'::regclass);


--
-- Name: auth_status id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_status ALTER COLUMN id SET DEFAULT nextval('auth.auth_status_id_seq'::regclass);


--
-- Name: auth_token id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_token ALTER COLUMN id SET DEFAULT nextval('auth.auth_token_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user ALTER COLUMN id SET DEFAULT nextval('auth.auth_user_id_seq'::regclass);


--
-- Name: auth_user_role id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user_role ALTER COLUMN id SET DEFAULT nextval('auth.auth_user_role_id_seq'::regclass);


--
-- Name: basket id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.basket ALTER COLUMN id SET DEFAULT nextval('project.basket_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.category ALTER COLUMN id SET DEFAULT nextval('project.category_id_seq'::regclass);


--
-- Name: like id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."like" ALTER COLUMN id SET DEFAULT nextval('project.like_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."order" ALTER COLUMN id SET DEFAULT nextval('project.order_id_seq'::regclass);


--
-- Name: order_status id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.order_status ALTER COLUMN id SET DEFAULT nextval('project.order_status_id_seq'::regclass);


--
-- Name: order_type id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.order_type ALTER COLUMN id SET DEFAULT nextval('project.order_type_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product ALTER COLUMN id SET DEFAULT nextval('project.product_id_seq'::regclass);


--
-- Name: product_comment id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_comment ALTER COLUMN id SET DEFAULT nextval('project.product_comment_id_seq'::regclass);


--
-- Name: product_image id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_image ALTER COLUMN id SET DEFAULT nextval('project.product_image_id_seq'::regclass);


--
-- Name: product_price id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_price ALTER COLUMN id SET DEFAULT nextval('project.product_price_id_seq'::regclass);


--
-- Name: product_rating id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_rating ALTER COLUMN id SET DEFAULT nextval('project.product_rating_id_seq'::regclass);


--
-- Name: transaction id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction ALTER COLUMN id SET DEFAULT nextval('project.transaction_id_seq'::regclass);


--
-- Name: transaction_status id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction_status ALTER COLUMN id SET DEFAULT nextval('project.transaction_status_id_seq'::regclass);


--
-- Name: transaction_type id; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction_type ALTER COLUMN id SET DEFAULT nextval('project.transaction_type_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: settings; Owner: postgres
--

ALTER TABLE ONLY settings.log ALTER COLUMN id SET DEFAULT nextval('settings.log_id_seq'::regclass);


--
-- Name: message id; Type: DEFAULT; Schema: settings; Owner: postgres
--

ALTER TABLE ONLY settings.message ALTER COLUMN id SET DEFAULT nextval('settings.message_id_seq'::regclass);


--
-- Name: comment id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.comment ALTER COLUMN id SET DEFAULT nextval('system.comment_id_seq'::regclass);


--
-- Name: help id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.help ALTER COLUMN id SET DEFAULT nextval('system.help_id_seq'::regclass);


--
-- Name: rule id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.rule ALTER COLUMN id SET DEFAULT nextval('system.rule_id_seq'::regclass);


--
-- Name: rule_type id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.rule_type ALTER COLUMN id SET DEFAULT nextval('system.rule_type_id_seq'::regclass);


--
-- Name: sponsors id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.sponsors ALTER COLUMN id SET DEFAULT nextval('system.sponsors_id_seq'::regclass);


--
-- Data for Name: auth_balance; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_balance (id, card_id, amount, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
4	3	10000000.12	f	2022-01-13 17:42:33.844692	29	2022-01-13 17:44:38.569394	29
5	4	13.12	f	2022-01-13 17:59:00.02798	29	\N	\N
\.


--
-- Data for Name: auth_block; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_block (id, user_id, duration, blocked_for, blocked_at, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: auth_card; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_card (id, user_id, card_type, number, holder_name, expire_date, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
2	28	HUMO	8600123487655784	qudi	1229	f	2022-01-13 16:55:55.214439	29	2022-01-13 17:03:30.010936	29
1	29	VISA	8600123487655784	Akbarov Akbar	0326	t	2022-01-13 02:53:10.073577	-1	2022-01-13 17:04:53.124171	29
3	28	UZCARD	860712348655784 	hello	0326	f	2022-01-13 17:42:33.833351	29	2022-01-13 17:44:38.569394	29
4	28	UNION_PAY	8607126348655784	sariq dev	0326	f	2022-01-13 17:59:00.016837	29	\N	\N
\.


--
-- Data for Name: auth_card_type; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_card_type (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	Uzcard	UZCARD	f	2022-01-12 04:28:07.828619	-1	\N	\N
2	Visa	VISA	f	2022-01-12 04:28:44.096111	-1	\N	\N
3	Humo	HUMO	f	2022-01-12 04:29:23.541407	-1	\N	\N
5	Union pay	UNION_PAY	t	2022-01-13 17:58:23.751721	28	2022-01-13 18:07:20.611883	28
4	update type	UPDATE_TYPE	f	2022-01-12 04:29:51.1444	-1	2022-01-13 18:42:52.970247	28
\.


--
-- Data for Name: auth_language; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_language (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	Uzbek	UZ	f	2022-01-12 04:26:19.585544	-1	\N	\N
2	Russian	RU	f	2022-01-12 04:26:37.271006	-1	\N	\N
3	English	EN	f	2022-01-12 04:26:56.078972	-1	\N	\N
4	Germany	GR	t	2022-01-13 20:45:56.193236	28	2022-01-13 20:47:27.71266	28
5	Qatar	QR	t	2022-01-13 20:48:20.277349	28	2022-01-13 20:50:57.030392	28
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_permission (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	create category	CREATE_CATEGORY	f	2022-01-12 04:30:47.099088	-1	\N	\N
2	update category	UPDATE_CATEGORY	f	2022-01-12 04:33:03.402885	-1	\N	\N
3	delete category	DELETE_CATEGORY	f	2022-01-12 04:33:03.402885	-1	\N	\N
4	list category	LIST_CATEGORY	f	2022-01-12 04:33:03.402885	-1	\N	\N
5	create product	CREATE_PRODUCT	f	2022-01-12 04:33:03.402885	-1	\N	\N
6	update product	UPDATE_PRODUCT	f	2022-01-12 04:33:03.402885	-1	\N	\N
7	delete product	DELETE_PRODUCT	f	2022-01-12 04:33:03.402885	-1	\N	\N
8	list product	LIST_PRODUCT	f	2022-01-12 04:33:03.402885	-1	\N	\N
9	get category	GET_CATEGORY	f	2022-01-12 04:51:41.940894	-1	\N	\N
10	get product 	GET_PRODUCT	f	2022-01-12 04:51:41.940894	-1	\N	\N
14	create discount	CREATE_DISCOUNT	f	2022-01-12 04:51:41.940894	-1	\N	\N
15	update discount	UPDATE_DISCOUNT	f	2022-01-12 04:51:41.940894	-1	\N	\N
16	delete discount	DELETE_DISCOUNT	f	2022-01-12 04:51:41.940894	-1	\N	\N
17	list discount	LIST_DISCOUNT	f	2022-01-12 04:51:41.940894	-1	\N	\N
18	get discount	GET_DISCOUNT	f	2022-01-12 04:51:41.940894	-1	\N	\N
19	change language	CHANGE_LANGUAGE	f	2022-01-12 04:58:51.102382	-1	\N	\N
20	add permission	ADD_PERMISSION	f	2022-01-12 04:58:51.102382	-1	\N	\N
21	delete permission	DELETE_PERMISSION	f	2022-01-12 04:58:51.102382	-1	\N	\N
22	list permission	LIST_PERMISSION	f	2022-01-12 04:58:51.102382	-1	\N	\N
23	add role	ADD_ROLE	f	2022-01-12 04:58:51.102382	-1	\N	\N
24	delete role	DELETE_ROLE	f	2022-01-12 04:58:51.102382	-1	\N	\N
25	list role	LIST_ROLE	f	2022-01-12 04:58:51.102382	-1	\N	\N
26	create admin	CREATE_ADMIN	f	2022-01-12 04:58:51.102382	-1	\N	\N
27	delete admin	DELETE_ADMIN	f	2022-01-12 04:58:51.102382	-1	\N	\N
28	update admin	UPDATE_ADMIN	f	2022-01-12 04:58:51.102382	-1	\N	\N
29	list admin	LIST_ADMIN	f	2022-01-12 04:58:51.102382	-1	\N	\N
30	get admin	GET_ADMIN	f	2022-01-12 04:58:51.102382	-1	\N	\N
31	create manager	CREATE_MANAGER	f	2022-01-12 04:58:51.102382	-1	\N	\N
32	update manager	UPDATE_MANAGER	f	2022-01-12 04:58:51.102382	-1	\N	\N
33	delete manager	DELETE_MANAGER	f	2022-01-12 04:58:51.102382	-1	\N	\N
34	list manager	LIST_MANAGER	f	2022-01-12 04:58:51.102382	-1	\N	\N
35	get manager	GET_MANAGER	f	2022-01-12 04:58:51.102382	-1	\N	\N
36	create employee	CREATE_EMPLOYEE	f	2022-01-12 04:58:51.102382	-1	\N	\N
37	update employee	UPDATE_EMPLOYEE	f	2022-01-12 04:58:51.102382	-1	\N	\N
38	delete employee	DELETE_EMPLOYEE	f	2022-01-12 04:58:51.102382	-1	\N	\N
39	list employee	LIST_EMPLOYEE	f	2022-01-12 04:58:51.102382	-1	\N	\N
40	get employee	GET_EMPLOYEE	f	2022-01-12 04:58:51.102382	-1	\N	\N
41	add card	ADD_CARD	f	2022-01-12 05:03:44.221076	-1	\N	\N
42	delete card 	DELETE_CARD	f	2022-01-12 05:03:44.221076	-1	\N	\N
43	update card	UPDATE_CARD	f	2022-01-12 05:03:44.221076	-1	\N	\N
44	list card	LIST_CARD	f	2022-01-12 05:03:44.221076	-1	\N	\N
45	add language	ADD_LANGUAGE	f	2022-01-12 05:03:44.221076	-1	\N	\N
46	delete language	DELETE_LANGUAGE	f	2022-01-12 05:03:44.221076	-1	\N	\N
47	list language	LIST_LANGUAGE	f	2022-01-12 05:03:44.221076	-1	\N	\N
48	update language	UPDATE_LANGUAGE	f	2022-01-12 05:03:44.221076	-1	\N	\N
49	add status	ADD_STATUS	f	2022-01-12 05:03:44.221076	-1	\N	\N
50	delete status	DELETE_STATUS	f	2022-01-12 05:03:44.221076	-1	\N	\N
51	update status	UPDATE_STATUS	f	2022-01-12 05:03:44.221076	-1	\N	\N
52	list status	LIST_STATUS	f	2022-01-12 05:03:44.221076	-1	\N	\N
53	add user role	ADD_USER_ROLE	f	2022-01-12 05:08:12.646686	-1	\N	\N
54	delete user role	DELETE_USER_ROLE	f	2022-01-12 05:08:12.646686	-1	\N	\N
55	update user role	UPDATE_USER_ROLE	f	2022-01-12 05:08:12.646686	-1	\N	\N
56	list user role	LIST_USER_ROLE	f	2022-01-12 05:08:12.646686	-1	\N	\N
57	get user role	GET_USER_ROLE	f	2022-01-12 05:08:12.646686	-1	\N	\N
58	add role permission	ADD_ROLE_PERMISSION	f	2022-01-12 05:08:12.646686	-1	\N	\N
59	delete role permission	DELETE_ROLE_PERMISSION	f	2022-01-12 05:08:12.646686	-1	\N	\N
60	update role permission	UPDATE_ROLE_PERMISSION	f	2022-01-12 05:08:12.646686	-1	\N	\N
61	list role permission	LIST_ROLE_PERMISSION	f	2022-01-12 05:08:12.646686	-1	\N	\N
62	get role permission	GET_ROLE_PERMISSION	f	2022-01-12 05:08:12.646686	-1	\N	\N
63	get card	GET_CARD	f	2022-01-12 10:26:22.313094	-1	\N	\N
65	delete user	DELETE_USER	f	2022-01-12 18:45:27.445748	-1	\N	\N
66	update user	UPDATE_USER	f	2022-01-12 18:45:27.445748	-1	\N	\N
67	reset password user	RESET_PASSWORD_USER	f	2022-01-12 18:45:27.445748	-1	\N	\N
68	create user	CREATE_USER	f	2022-01-12 18:45:27.445748	-1	\N	\N
69	list user	LIST_USER	f	2022-01-12 18:45:27.445748	-1	\N	\N
70	get user	GET_USER	f	2022-01-12 18:45:27.445748	-1	\N	\N
72	add card type	ADD_CARD_TYPE	f	2022-01-13 17:54:29.01455	-1	\N	\N
73	delete card type	DELETE_CARD_TYPE	f	2022-01-13 18:00:36.194297	-1	\N	\N
74	update card type	UPDATE_CARD_TYPE	f	2022-01-13 18:00:36.194297	-1	\N	\N
75	list card type	LIST_CARD_TYPE	f	2022-01-13 18:00:36.194297	-1	\N	\N
77	update role	UPDATE_ROLE	f	2022-01-13 20:53:21.258923	-1	\N	\N
78	update permission	UPDATE_PERMISSION	f	2022-01-14 03:51:01.27699	-1	\N	\N
79	ali	ALI	f	2022-01-14 12:53:40.276735	28	2022-01-14 12:57:38.973712	28
80	delete comment	DELETE_COMMENT	f	2022-01-19 05:33:12.816834	-1	\N	\N
81	list comment	LIST_COMMENT	f	2022-01-19 05:46:41.869856	-1	\N	\N
82	create sponsor	CREATE_SPONSOR	f	2022-01-19 09:40:26.081138	-1	\N	\N
83	delete sponsor	DELETE_SPONSOR	f	2022-01-19 09:41:17.095223	-1	\N	\N
84	update sponsor	UPDATE_SPONSOR	f	2022-01-19 09:41:17.095223	-1	\N	\N
85	list sponsor	LIST_SPONSOR	f	2022-01-19 09:41:17.095223	-1	\N	\N
86	create rule type	CREATE_RULE_TYPE	f	2022-01-19 15:55:13.985321	-1	\N	\N
87	delete rule type	DELETE_RULE_TYPE	f	2022-01-19 15:55:13.985321	-1	\N	\N
88	update rule type	UPDATE_RULE_TYPE	f	2022-01-19 15:55:13.985321	-1	\N	\N
89	list rule type	LIST_RULE_TYPE	f	2022-01-19 15:55:13.985321	-1	\N	\N
90	create help	CREATE_HELP	f	2022-01-19 20:48:00.820508	-1	\N	\N
91	delete help	DELETE_HELP	f	2022-01-19 20:48:00.820508	-1	\N	\N
92	update help	UPDATE_HELP	f	2022-01-19 20:48:00.820508	-1	\N	\N
93	list help	LIST_HELP	f	2022-01-19 20:48:00.820508	-1	\N	\N
\.


--
-- Data for Name: auth_role; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_role (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	User	USER	f	2022-01-12 04:23:08.202523	-1	\N	\N
2	Admin	ADMIN	f	2022-01-12 04:23:20.929839	-1	\N	\N
3	Manager	MANAGER	f	2022-01-12 04:23:33.753706	-1	\N	\N
4	Employee	EMPLOYEE	f	2022-01-12 04:23:49.983606	-1	\N	\N
5	super	SUPER	t	2022-01-14 03:44:25.38511	28	2022-01-14 03:47:05.329253	28
\.


--
-- Data for Name: auth_role_permission; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_role_permission (id, auth_user_role_id, permission_id, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
114	27	26	f	2022-01-13 02:50:09.596074	28	\N	\N
115	27	27	f	2022-01-13 02:50:09.596074	28	\N	\N
116	28	4	f	2022-01-13 02:50:56.390693	29	\N	\N
117	28	8	f	2022-01-13 02:50:56.390693	29	\N	\N
118	28	9	f	2022-01-13 02:50:56.390693	29	\N	\N
119	28	10	f	2022-01-13 02:50:56.390693	29	\N	\N
120	28	17	f	2022-01-13 02:50:56.390693	29	\N	\N
121	28	18	f	2022-01-13 02:50:56.390693	29	\N	\N
122	28	19	f	2022-01-13 02:50:56.390693	29	\N	\N
123	28	41	f	2022-01-13 02:50:56.390693	29	\N	\N
124	28	42	f	2022-01-13 02:50:56.390693	29	\N	\N
125	28	43	f	2022-01-13 02:50:56.390693	29	\N	\N
126	28	44	f	2022-01-13 02:50:56.390693	29	\N	\N
127	28	63	f	2022-01-13 02:50:56.390693	29	\N	\N
128	27	69	f	2022-01-13 02:54:26.044871	28	\N	\N
129	27	67	f	2022-01-13 07:37:37.259456	28	\N	\N
130	27	72	f	2022-01-13 17:58:10.084993	28	\N	\N
131	27	73	f	2022-01-13 18:07:09.608696	28	\N	\N
132	27	74	f	2022-01-13 18:07:09.608696	28	\N	\N
133	27	75	f	2022-01-13 18:07:09.608696	28	\N	\N
134	27	45	f	2022-01-13 19:01:14.51718	28	\N	\N
135	27	46	f	2022-01-13 19:01:14.51718	28	\N	\N
136	27	47	f	2022-01-13 19:01:14.51718	28	\N	\N
137	27	48	f	2022-01-13 19:01:14.51718	28	\N	\N
138	27	23	f	2022-01-14 03:43:07.639362	28	\N	\N
139	27	24	f	2022-01-14 03:43:07.639362	28	\N	\N
140	27	25	f	2022-01-14 03:43:07.639362	28	\N	\N
141	27	77	f	2022-01-14 03:43:07.639362	28	\N	\N
142	27	78	f	2022-01-14 03:51:17.695488	28	\N	\N
143	27	20	f	2022-01-14 03:52:37.092886	28	\N	\N
144	27	21	f	2022-01-14 03:52:37.092886	28	\N	\N
145	27	22	f	2022-01-14 03:52:37.092886	28	\N	\N
146	27	49	f	2022-01-14 13:04:50.99897	28	\N	\N
147	27	50	f	2022-01-14 13:04:50.99897	28	\N	\N
148	27	51	f	2022-01-14 13:04:50.99897	28	\N	\N
149	27	52	f	2022-01-14 13:04:50.99897	28	\N	\N
150	27	53	f	2022-01-14 13:48:10.613754	28	\N	\N
151	27	54	f	2022-01-14 13:48:10.613754	28	\N	\N
152	27	55	f	2022-01-14 13:48:10.613754	28	\N	\N
153	27	56	f	2022-01-14 13:48:10.613754	28	\N	\N
157	33	5	f	2022-01-15 19:25:55.332541	28	\N	\N
158	33	7	f	2022-01-15 19:42:39.667573	28	\N	\N
159	33	6	f	2022-01-15 20:18:04.224132	28	\N	\N
161	33	8	f	2022-01-18 03:49:06.73383	28	\N	\N
163	33	80	f	2022-01-19 05:33:43.255918	28	\N	\N
164	33	81	f	2022-01-19 05:46:59.972617	28	\N	\N
165	33	82	f	2022-01-19 09:42:05.076138	28	\N	\N
166	33	83	f	2022-01-19 09:42:05.076138	28	\N	\N
167	33	84	f	2022-01-19 09:42:05.076138	28	\N	\N
168	33	85	f	2022-01-19 09:42:05.076138	28	\N	\N
169	33	86	f	2022-01-19 15:55:38.855392	28	\N	\N
170	33	87	f	2022-01-19 15:55:38.855392	28	\N	\N
171	33	88	f	2022-01-19 15:55:38.855392	28	\N	\N
172	33	89	f	2022-01-19 15:55:38.855392	28	\N	\N
173	33	90	f	2022-01-19 20:48:47.884515	28	\N	\N
174	33	91	f	2022-01-19 20:48:47.884515	28	\N	\N
175	33	92	f	2022-01-19 20:48:47.884515	28	\N	\N
176	33	93	f	2022-01-19 20:48:47.884515	28	\N	\N
\.


--
-- Data for Name: auth_session; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_session (id, token_id, user_code, username, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
12	12	bc1f31f0-1fc5-4ebd-841a-03669a78b9ec	akbar	f	2022-01-13 02:51:33.579095	29	\N	\N
13	13	d83c107f-c6bc-43fb-9ad6-be97d4f2e07e	admin	f	2022-01-13 02:51:46.954274	28	\N	\N
14	14	bc1f31f0-1fc5-4ebd-841a-03669a78b9ec	akbar	f	2022-01-13 07:34:41.475419	29	\N	\N
15	15	bc1f31f0-1fc5-4ebd-841a-03669a78b9ec	akbar	f	2022-01-13 07:36:03.340167	29	\N	\N
\.


--
-- Data for Name: auth_status; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_status (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	Active	ACTIVE	f	2022-01-12 04:22:00.381542	-1	\N	\N
2	No active	NO_ACTIVE	f	2022-01-12 04:22:52.556305	-1	\N	\N
3	hello	HELLO	t	2022-01-14 13:28:17.1998	28	2022-01-14 13:31:15.912188	28
\.


--
-- Data for Name: auth_token; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_token (id, user_id, token, duration, is_deleted, created_at) FROM stdin;
12	29	33579.0957b430460-a416-4908-9128-e19709560e5e33579.095	2022-01-13 03:01:33.579095	f	2022-01-13 02:51:33.579095
13	28	46954.274679780ab-b69c-4006-b095-8d50e290f68e46954.274	2022-01-13 03:01:46.954274	f	2022-01-13 02:51:46.954274
14	29	41475.4190c959cf8-e182-4031-90f7-74cfbc3a3ee541475.419	2022-01-13 07:44:41.475419	f	2022-01-13 07:34:41.475419
15	29	3340.167e9e018ba-01f1-4d0c-ac75-2fb5757d16433340.167	2022-01-13 07:46:03.340167	f	2022-01-13 07:36:03.340167
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_user (id, code, username, password, email, phone, chat_id, last_login_at, language, status, login_try_count, is_deleted, created_at, created_by, updated_at, updated_by, profile_pic, location) FROM stdin;
29	bc1f31f0-1fc5-4ebd-841a-03669a78b9ec	akbar	$2a$04$hpTm0n4KhuMij2RMcn1/Q.8hhsVdKy/cN/ySXrBNCfUjrEfbD1rX6	akbar@gmail.com	+998989551829	\N	2022-01-13 07:36:03.340167	UZ	ACTIVE	0	f	2022-01-13 02:50:56.377619	-1	2022-01-13 07:37:57.147047	28	\N	\N
28	d83c107f-c6bc-43fb-9ad6-be97d4f2e07e	admin	$2a$04$wc2bWkjdJ1CjqoGS4dL1Qe0mbr58NgbXLfsKGGHCxtX/f3NWQTIdm	admin@gmail.com	+998981351829	\N	2022-01-13 02:51:46.954274	EN	ACTIVE	0	f	2022-01-13 02:50:09.557422	-1	\N	\N	\N	\N
\.


--
-- Data for Name: auth_user_role; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_user_role (id, user_id, role_id, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
32	28	USER	f	2022-01-14 17:10:59.224332	28	2022-01-14 17:12:59.201503	28
27	28	ADMIN	f	2022-01-13 02:50:09.594656	28	2022-01-14 17:15:00.653651	28
28	29	USER	f	2022-01-13 02:50:56.389904	29	2022-01-15 13:49:11.791624	28
33	29	ADMIN	f	2022-01-14 17:11:15.244288	28	2022-01-15 13:32:20.365664	28
\.


--
-- Data for Name: basket; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.basket (id, user_id, order_id, product_id, product_count, total_price, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.category (id, parent_id, title, code, category_pic, description, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
2	1	Book	BOOK	\N	book categeory	f	2022-01-15 18:44:19.56063	-1	\N	\N
\.


--
-- Data for Name: like; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project."like" (id, user_id, product_id, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project."order" (id, user_id, type, status, product_count, total_price, is_deleted, created_at, created_by, updated_at, updated_by, card_id) FROM stdin;
\.


--
-- Data for Name: order_status; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.order_status (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: order_type; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.order_type (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.product (id, category_id, title, code, count, color, width, height, country, date_of_manufacture, description, extra, is_deleted, created_at, created_by, updated_at, updated_by, is_published) FROM stdin;
1	2	Oracle	ORACLE	100	white	30.00	30.00	America	2019-10-11 00:00:00	oracle sql product	\N	f	2022-01-15 19:28:19.958135	29	2022-01-15 20:33:01.063075	29	f
2	2	Oracle_two	ORACLE_TWO	100	white	30.00	30.00	America	2019-10-11 00:00:00	oracle sql product	\N	f	2022-01-15 19:34:15.585994	29	\N	\N	f
3	2	Oracle_three	ORACLE_THREE	100	white	30.00	30.00	America	2019-10-11 00:00:00	oracle sql product	\N	t	2022-01-17 14:51:31.098319	29	\N	\N	f
5	2	Oracle_three	OKRACLE_THREE	100	white	30.00	30.00	America	2019-10-11 00:00:00	oracle sql product	\N	f	2022-01-17 14:54:23.309019	29	\N	\N	f
6	2	Oracle_three	OKRACLE_THREhE	100	white	30.00	30.00	America	2019-10-11 00:00:00	oracle sql product	\N	f	2022-01-17 14:55:15.159927	29	\N	\N	f
7	2	Oracle_three	OKRACLjE_THREhE	100	white	30.00	30.00	America	2019-10-11 00:00:00	oracle sql product	\N	f	2022-01-17 14:56:28.301593	29	\N	\N	f
8	2	Oracle_three	OKRACLjE_THguyREhE	100	white	30.00	30.00	America	2019-10-11 00:00:00	oracle sql product	\N	f	2022-01-17 15:01:53.904176	29	\N	\N	f
9	2	Oracle_three	OKRACLjE_THguyREjkhE	100	white	30.00	30.00	America	2019-10-11 00:00:00	oracle sql product	\N	f	2022-01-17 15:17:05.106162	29	\N	\N	f
\.


--
-- Data for Name: product_comment; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.product_comment (id, product_id, user_id, message, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	1	29	hi bro order thi product today	f	2022-01-16 19:08:27.335532	29	\N	\N
2	1	29	hi bro order thi product today	t	2022-01-17 14:12:04.495275	29	\N	\N
\.


--
-- Data for Name: product_image; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.product_image (id, product_id, product_pic, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	8	pdp/pdp.png	f	2022-01-17 15:01:53.904176	29	\N	\N
2	9	pdp/pdp.png	f	2022-01-17 15:17:05.106162	29	\N	\N
\.


--
-- Data for Name: product_price; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.product_price (id, product_id, price, discount_percent, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
2	2	95000	0	t	2022-01-15 19:34:15.585994	29	\N	\N
3	3	95000	0	t	2022-01-17 14:51:31.098319	29	\N	\N
4	5	95000	0	f	2022-01-17 14:54:23.309019	29	\N	\N
5	6	95000	0	f	2022-01-17 14:55:15.159927	29	\N	\N
6	7	95000	0	f	2022-01-17 14:56:28.301593	29	\N	\N
7	8	95000	0	f	2022-01-17 15:01:53.904176	29	\N	\N
8	9	95000	0	f	2022-01-17 15:17:05.106162	29	\N	\N
1	1	13000	0	t	2022-01-15 19:28:19.958135	29	2022-01-18 14:32:42.037542	29
\.


--
-- Data for Name: product_rating; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.product_rating (id, product_id, views, purchased, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	8	0	0	f	2022-01-17 15:01:53.904176	29	\N	\N
2	9	0	0	f	2022-01-17 15:17:05.106162	29	\N	\N
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.transaction (id, user_id, order_id, type, status, quantity, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: transaction_status; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.transaction_status (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: transaction_type; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.transaction_type (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: settings; Owner: postgres
--

COPY settings.log (id, body, created_at, created_by) FROM stdin;
1	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-12 13:33:43.057711	-1
2	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-12 13:35:13.377293	-1
3	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-12 15:51:03.870227	-1
4	auth.auth_delete(p_delete_user_id integer, p_user_id integer)	2022-01-12 16:26:30.711362	-1
5	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-12 16:29:09.782279	-1
6	auth.auth_delete(p_delete_user_id integer, p_user_id integer)	2022-01-12 18:23:46.372944	-1
7	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-12 18:46:05.809525	-1
8	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-12 18:46:34.611451	-1
9	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-12 18:47:38.728255	-1
10	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-12 18:48:34.323046	-1
11	auth_logout(p_user_code uuid)	2022-01-12 18:48:39.460171	-1
12	auth_logout(p_user_code uuid)	2022-01-12 18:49:27.894116	-1
13	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-12 18:49:30.480262	-1
14	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-12 18:49:38.345967	-1
15	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-12 18:50:16.897574	-1
16	auth.auth_delete(p_delete_user_id integer, p_user_id integer)	2022-01-12 18:51:08.421485	-1
17	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-12 18:52:06.936889	-1
18	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-12 18:55:35.02866	-1
19	auth.auth_delete(p_delete_user_id integer, p_user_id integer)	2022-01-12 18:56:04.456354	-1
20	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-12 18:58:23.125165	-1
21	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-12 19:03:36.404728	-1
22	auth.auth_delete(p_delete_user_id integer, p_user_id integer)	2022-01-12 19:05:58.860551	-1
23	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-12 19:50:28.5991	-1
24	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-12 19:52:17.602088	-1
25	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-13 02:50:09.596074	-1
26	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-13 02:50:56.390693	-1
27	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-13 02:51:33.579095	-1
28	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-13 02:51:46.954274	-1
29	auth.auth_list(p_user_id integer) returns text	2022-01-13 03:57:26.258785	-1
30	auth.auth_list(p_user_id integer) returns text	2022-01-13 03:59:22.417209	-1
31	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:00:44.155433	-1
32	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:02:33.127277	-1
33	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:04:45.46621	-1
34	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:09:06.967153	-1
35	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:12:54.510981	-1
36	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:16:46.971295	-1
37	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:19:54.706916	-1
38	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:22:15.013894	-1
39	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:30:44.142343	-1
40	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:37:11.715148	-1
41	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:39:48.52429	-1
42	auth.auth_list(p_user_id integer) returns text	2022-01-13 04:48:52.973831	-1
43	auth.auth_get(p_user_id integer) returns text	2022-01-13 05:49:05.54048	-1
44	auth.auth_get(p_user_id integer) returns text	2022-01-13 05:49:57.58663	-1
45	auth.auth_get(p_user_id integer) returns text	2022-01-13 06:21:20.591992	-1
46	auth.auth_get(p_user_id integer) returns text	2022-01-13 06:21:56.995612	-1
47	auth.change_language(p_user_code uuid, p_to_language char(2))	2022-01-13 06:42:42.309718	-1
48	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-13 07:34:41.475419	-1
49	auth.reset_password(data text, p_user_id integer)	2022-01-13 07:35:52.044603	-1
50	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-13 07:36:03.340167	-1
51	auth.reset_password(data text, p_user_id integer)	2022-01-13 07:37:57.147047	-1
52	auth.user_id_by_code(p_user_code uuid) returns integer	2022-01-13 14:19:24.607821	-1
53	auth.user_id_by_code(p_user_code uuid) returns integer	2022-01-13 14:19:47.319302	-1
54	auth.card_my_list(p_user_id integer) returns text	2022-01-13 16:47:16.410778	-1
55	auth.card_my_list(p_user_id integer) returns text	2022-01-13 16:47:20.140364	-1
56	auth.card_my_list(p_user_id integer) returns text	2022-01-13 16:47:51.424689	-1
57	auth.card_list(p_user_id integer) returns text	2022-01-13 16:48:29.433342	-1
58	auth.card_list(p_user_id integer) returns text	2022-01-13 16:48:56.25275	-1
59	auth.card_create(data text, p_user_id integer) returns text	2022-01-13 16:55:55.214439	-1
60	auth.card_list(p_user_id integer) returns text	2022-01-13 16:57:32.46143	-1
61	auth.card_my_list(p_user_id integer) returns text	2022-01-13 16:57:49.95328	-1
62	auth.card_my_list(p_user_id integer) returns text	2022-01-13 16:58:03.899757	-1
63	auth.card_update(data text, p_user_id integer)	2022-01-13 17:02:39.278514	-1
64	auth.card_update(data text, p_user_id integer)	2022-01-13 17:03:30.010936	-1
65	auth.card_delete(card_id integer, p_user_id integer)	2022-01-13 17:04:53.124171	-1
66	auth.card_my_list(p_user_id integer) returns text	2022-01-13 17:42:00.129872	-1
67	card_create(data text, p_user_id integer, inout p_result text)	2022-01-13 17:42:33.844692	-1
68	auth.card_list(p_user_id integer) returns text	2022-01-13 17:43:06.955236	-1
69	auth.card_my_list(p_user_id integer) returns text	2022-01-13 17:43:59.812274	-1
70	auth.card_my_list(p_user_id integer) returns text	2022-01-13 17:44:06.977198	-1
71	auth.card_update(data text, p_user_id integer)	2022-01-13 17:44:38.569394	-1
72	auth.card_my_list(p_user_id integer) returns text	2022-01-13 17:44:42.833622	-1
73	card_create(data text, p_user_id integer, inout p_result text)	2022-01-13 17:59:00.02798	-1
75	checks.check_card_type_update_dto(inout update_dto dto.card_type_update_dto)	2022-01-13 18:33:04.299681	-1
76	checks.check_card_type_update_dto(inout update_dto dto.card_type_update_dto)	2022-01-13 18:33:36.81983	-1
77	auth.card_type_list(p_user_id integer) returns text	2022-01-13 18:42:09.22831	-1
78	checks.check_card_type_update_dto(inout update_dto dto.card_type_update_dto)	2022-01-13 18:42:52.970247	-1
79	auth.card_type_list(p_user_id integer) returns text	2022-01-13 18:42:55.927702	-1
80	auth.card_type_list(p_user_id integer) returns text	2022-01-13 18:45:18.890356	-1
81	auth.language_list(p_user_id integer) returns text	2022-01-13 20:44:29.54691	-1
82	auth.language_list(p_user_id integer) returns text	2022-01-13 20:44:37.163188	-1
83	auth.language_list(p_user_id integer) returns text	2022-01-13 20:45:58.321833	-1
84	auth.language_delete((p_code character varying, p_user_id integer) returns text	2022-01-13 20:47:27.71266	-1
85	auth.language_list(p_user_id integer) returns text	2022-01-13 20:47:30.227512	-1
86	auth.language_list(p_user_id integer) returns text	2022-01-13 20:49:19.475623	-1
88	checks.check_language_update_dto(INOUT update_dto dto.language_update_dto)	2022-01-13 20:49:44.972922	-1
89	auth.language_update(data text, p_user_id integer)	2022-01-13 20:49:44.972922	-1
90	auth.language_list(p_user_id integer) returns text	2022-01-13 20:49:49.31741	-1
91	checks.check_language_update_dto(INOUT update_dto dto.language_update_dto)	2022-01-13 20:50:21.302143	-1
92	auth.language_update(data text, p_user_id integer)	2022-01-13 20:50:21.302143	-1
93	checks.check_language_update_dto(INOUT update_dto dto.language_update_dto)	2022-01-13 20:50:36.69063	-1
94	auth.language_update(data text, p_user_id integer)	2022-01-13 20:50:36.69063	-1
95	auth.language_list(p_user_id integer) returns text	2022-01-13 20:50:39.120629	-1
96	auth.language_delete((p_code character varying, p_user_id integer) returns text	2022-01-13 20:50:57.030392	-1
97	auth.role_list(p_user_id integer) returns text	2022-01-14 03:43:12.767441	-1
98	auth.role_create(p_name character varying, p_code character varying, p_user_id integer) returns text	2022-01-14 03:44:25.38511	-1
99	auth.role_list(p_user_id integer) returns text	2022-01-14 03:44:33.428847	-1
101	checks.check_role_update_dto(INOUT update_dto dto.role_update_dto)	2022-01-14 03:45:43.903604	-1
102	auth.role_update(data text, p_user_id integer)	2022-01-14 03:45:43.903604	-1
103	auth.role_list(p_user_id integer) returns text	2022-01-14 03:46:15.971344	-1
104	checks.check_role_update_dto(INOUT update_dto dto.role_update_dto)	2022-01-14 03:46:25.64268	-1
105	auth.role_update(data text, p_user_id integer)	2022-01-14 03:46:25.64268	-1
106	auth.role_list(p_user_id integer) returns text	2022-01-14 03:46:35.816666	-1
107	auth.role_delete(p_code character varying, p_user_id integer)	2022-01-14 03:47:05.329253	-1
108	auth.role_list(p_user_id integer) returns text	2022-01-14 03:47:13.59706	-1
109	auth.permission_create(p_name character varying, p_code character varying, p_user_id integer) returns text	2022-01-14 12:53:40.276735	-1
110	auth.permission_delete(p_code character varying, p_user_id integer)	2022-01-14 12:54:30.095506	-1
111	auth.permission_list(p_user_id integer) returns text	2022-01-14 12:54:57.618314	-1
113	checks.check_permission_update_dto(INOUT update_dto dto.permission_update_dto)	2022-01-14 12:57:10.341711	-1
114	auth.permission_update(data text, p_user_id integer)	2022-01-14 12:57:10.341711	-1
115	checks.check_permission_update_dto(INOUT update_dto dto.permission_update_dto)	2022-01-14 12:57:38.973712	-1
116	auth.permission_update(data text, p_user_id integer)	2022-01-14 12:57:38.973712	-1
117	auth.status_create(p_name character varying, p_code character varying, p_user_id integer) returns text	2022-01-14 13:28:17.1998	-1
118	auth.status_list(p_user_id integer) returns text	2022-01-14 13:28:32.423598	-1
119	auth.status_delete(p_code character varying, p_user_id integer)	2022-01-14 13:29:04.183481	-1
120	auth.status_list(p_user_id integer) returns text	2022-01-14 13:29:11.849438	-1
122	checks.check_status_update_dto(INOUT update_dto dto.status_update_dto)	2022-01-14 13:30:09.909194	-1
123	auth.status_update(data text, p_user_id integer)	2022-01-14 13:30:09.909194	-1
124	checks.check_status_update_dto(INOUT update_dto dto.status_update_dto)	2022-01-14 13:30:25.241708	-1
125	auth.status_update(data text, p_user_id integer)	2022-01-14 13:30:25.241708	-1
126	checks.check_status_update_dto(INOUT update_dto dto.status_update_dto)	2022-01-14 13:30:49.055943	-1
127	auth.status_update(data text, p_user_id integer)	2022-01-14 13:30:49.055943	-1
128	auth.status_list(p_user_id integer) returns text	2022-01-14 13:31:01.215595	-1
129	auth.status_delete(p_code character varying, p_user_id integer)	2022-01-14 13:31:15.912188	-1
130	auth.status_list(p_user_id integer) returns text	2022-01-14 13:31:22.13766	-1
131	auth.user_role_create(p_create_user_id integer, p_code character varying, p_user_id integer) returns text	2022-01-14 17:10:59.224332	-1
132	auth.user_role_create(p_create_user_id integer, p_code character varying, p_user_id integer) returns text	2022-01-14 17:11:15.244288	-1
133	auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer)	2022-01-14 17:12:24.349805	-1
134	auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer)	2022-01-14 17:12:48.423951	-1
135	auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer)	2022-01-14 17:12:59.201503	-1
136	auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer)	2022-01-14 17:13:10.80765	-1
137	auth.user_role_list(p_user_id integer) returns text	2022-01-14 17:14:04.306583	-1
138	auth.user_role_list(p_user_id integer) returns text	2022-01-14 17:14:46.551979	-1
139	auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer)	2022-01-14 17:15:00.653651	-1
140	auth.user_role_list(p_user_id integer) returns text	2022-01-14 17:18:44.931286	-1
141	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:31:00.60792	-1
142	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:31:05.473121	-1
143	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:31:06.277601	-1
144	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:31:07.014065	-1
145	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:31:07.784565	-1
146	auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer)	2022-01-15 13:32:20.365664	-1
147	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:32:26.965724	-1
148	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:32:27.90583	-1
149	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:47:40.848731	-1
150	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:47:47.925331	-1
151	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:47:49.771286	-1
152	auth.user_role_list(p_user_id integer) returns text	2022-01-15 13:48:55.215416	-1
153	auth.user_role_delete(p_delete_user_id integer, p_code character varying, p_user_id integer)	2022-01-15 13:49:11.791624	-1
154	project.product_create(data character varying, p_user_id bigint, INOUT p_result text DEFAULT ''::text)	2022-01-15 19:28:19.958135	-1
155	project.product_create(data character varying, p_user_id bigint, INOUT p_result text DEFAULT ''::text)	2022-01-15 19:34:15.585994	-1
156	project.project_delete(p_product_id integer, p_user_id integer)	2022-01-15 19:47:27.913487	-1
157	project.product_update(data character varying, p_user_id integer)	2022-01-15 20:33:01.063075	-1
158	project.product_comment_create(data character varying, p_user_id integer, INOUT result_text text default ''::text)	2022-01-16 19:08:27.335532	-1
159	project.product_comment_create(data character varying, p_user_id integer, INOUT result_text text default ''::text)	2022-01-17 14:12:04.495275	-1
160	project.product_comment_delete(p_comment_id bigint, p_user_id integer)	2022-01-17 14:15:08.47153	-1
161	project.product_comment_delete(p_comment_id bigint, p_user_id integer)	2022-01-17 14:15:41.182848	-1
162	project.product_comment_delete(p_comment_id bigint, p_user_id integer)	2022-01-17 14:15:44.156579	-1
163	project.product_comment_delete(p_comment_id bigint, p_user_id integer)	2022-01-17 14:15:45.896251	-1
164	project.product_create(data character varying, p_user_id bigint, INOUT p_result text DEFAULT ''::text)	2022-01-17 14:51:31.098319	-1
165	project.project_delete(p_product_id integer, p_user_id integer)	2022-01-17 14:54:00.121211	-1
166	project.product_create(data character varying, p_user_id bigint, INOUT p_result text DEFAULT ''::text)	2022-01-17 14:54:23.309019	-1
167	project.product_create(data character varying, p_user_id bigint, INOUT p_result text DEFAULT ''::text)	2022-01-17 14:55:15.159927	-1
168	project.product_create(data character varying, p_user_id bigint, INOUT p_result text DEFAULT ''::text)	2022-01-17 14:56:28.301593	-1
169	project.product_create(data character varying, p_user_id bigint, INOUT p_result text DEFAULT ''::text)	2022-01-17 15:01:53.904176	-1
170	project.product_create(data character varying, p_user_id bigint, INOUT p_result text DEFAULT ''::text)	2022-01-17 15:17:05.106162	-1
171	project.product_image_delete(product_image_id integer, p_user_id integer)	2022-01-18 06:27:44.513592	-1
172	project.product_image_delete(product_image_id integer, p_user_id integer)	2022-01-18 06:34:13.472527	-1
173	project.product_price_delete(p_price_id bigint, p_user_id integer)	2022-01-18 14:39:37.343563	-1
174	system.comment_create(message varchar, p_user_id integer)	2022-01-19 05:21:24.598047	-1
175	system.comment_create(message varchar, p_user_id integer)	2022-01-19 05:22:49.332377	-1
176	system.comment_create(message varchar, p_user_id integer)	2022-01-19 05:23:40.268969	-1
177	system.comment_create(message varchar, p_user_id integer)	2022-01-19 05:24:20.40146	-1
178	system.comment_create(message varchar, p_user_id integer)	2022-01-19 05:24:24.767709	-1
179	system.comment_create(message varchar, p_user_id integer)	2022-01-19 05:25:53.042193	-1
180	system.comment_create(message varchar, p_user_id integer)	2022-01-19 05:37:28.090513	-1
181	system.comment_create(message varchar, p_user_id integer)	2022-01-19 05:45:59.706047	-1
182	system.comment_list(p_user_id integer) returns text	2022-01-19 05:55:10.155859	-1
183	function system.sponsor_create(data character varying, p_user_id integer) returns text	2022-01-19 10:13:38.408927	-1
184	function system.sponsor_create(data character varying, p_user_id integer) returns text	2022-01-19 10:21:24.852707	-1
185	function system.sponsor_create(data character varying, p_user_id integer) returns text	2022-01-19 10:24:13.113677	-1
186	system.comment_list(p_user_id integer) returns text	2022-01-19 11:43:15.610766	-1
187	system.rule_type_create(p_name varchar, p_code varchar, p_user_id integer)	2022-01-19 15:58:55.757096	-1
188	system.rule_create(p_type varchar, p_body text, p_user_id integer)	2022-01-19 16:11:41.220338	-1
189	system.rule_delete(p_rule_id bigint, p_user_id integer)	2022-01-19 16:30:14.092563	-1
190	system.rule_update(p_rule_id bigint, p_type varchar, p_body text, p_user_id integer)	2022-01-19 17:36:35.253737	-1
191	system.list_rule(p_user_id integer) returns text	2022-01-19 17:44:31.514686	-1
192	system.rule_type_delete(p_rule_type_id bigint, p_user_id integer)	2022-01-19 19:18:46.059998	-1
193	system.rule_type_update(p_rule_type_id bigint, p_name varchar, p_code varchar, p_user_id integer) returns text	2022-01-19 19:36:36.218327	-1
194	system.rule_type_list(p_user_id integer) returns text	2022-01-19 19:43:39.260625	-1
195	system.rule_type_list(p_user_id integer) returns text	2022-01-19 19:43:48.50733	-1
196	system.help_create(p_body text, p_user_id integer) returns text	2022-01-19 20:52:14.694978	-1
197	system.help_delete(p_help_id bigint, p_user_id integer)	2022-01-19 20:58:24.189206	-1
198	system.help_update(p_help_id bigint, p_body text, p_user_id integer)	2022-01-19 21:04:05.12564	-1
199	system.list_rule(p_user_id integer) returns text	2022-01-19 21:08:27.470155	-1
200	system.list_rule(p_user_id integer) returns text	2022-01-19 21:08:59.6809	-1
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: settings; Owner: postgres
--

COPY settings.message (id, message, code, language, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	user id is null	USER_ID_IS_NULL	EN	f	2022-01-12 05:39:42.45624	-1	\N	\N
2	идентификатор пользователя равен нулю	USER_ID_IS_NULL	RU	f	2022-01-12 05:39:42.45624	-1	\N	\N
3	foydalanuvchi identifikatori null	USER_ID_IS_NULL	UZ	f	2022-01-12 05:39:42.45624	-1	\N	\N
4	user not found	USER_NOT_FOUND	EN	f	2022-01-12 05:39:42.45624	-1	\N	\N
5	Пользователь не найден	USER_NOT_FOUND	RU	f	2022-01-12 05:39:42.45624	-1	\N	\N
6	foydalanuvchi topilmadi	USER_NOT_FOUND	UZ	f	2022-01-12 05:39:42.45624	-1	\N	\N
7	user not active	USER_NOT_ACTIVE	EN	f	2022-01-12 05:39:42.45624	-1	\N	\N
8	пользователь не активен	USER_NOT_ACTIVE	RU	f	2022-01-12 05:39:42.45624	-1	\N	\N
9	foydalanuvchi faol emas	USER_NOT_ACTIVE	UZ	f	2022-01-12 05:39:42.45624	-1	\N	\N
10	user is blocked	USER_IS_BLOCKED	EN	f	2022-01-12 05:39:42.45624	-1	\N	\N
11	пользователь заблокирован	USER_IS_BLOCKED	RU	f	2022-01-12 05:39:42.45624	-1	\N	\N
12	foydalanuvchi bloklangan	USER_IS_BLOCKED	UZ	f	2022-01-12 05:39:42.45624	-1	\N	\N
13	invalid parameter	INVALID_PARAMETER	EN	f	2022-01-12 05:39:42.45624	-1	\N	\N
14	Неверный параметр	INVALID_PARAMETER	RU	f	2022-01-12 05:39:42.45624	-1	\N	\N
15	yaroqsiz parametr	INVALID_PARAMETER	UZ	f	2022-01-12 05:39:42.45624	-1	\N	\N
16	language not found	LANGUAGE_NOT_FOUND	EN	f	2022-01-12 05:51:09.40768	-1	\N	\N
17	язык не найден	LANGUAGE_NOT_FOUND	RU	f	2022-01-12 05:51:09.40768	-1	\N	\N
18	til topilmadi	LANGUAGE_NOT_FOUND	UZ	f	2022-01-12 05:51:09.40768	-1	\N	\N
19	message code not found	MESSAGE_CODE_NOT_FOUND	EN	f	2022-01-12 05:51:09.40768	-1	\N	\N
20	код сообщения не найден	MESSAGE_CODE_NOT_FOUND	RU	f	2022-01-12 05:51:09.40768	-1	\N	\N
21	xabar kodi topilmadi	MESSAGE_CODE_NOT_FOUND	UZ	f	2022-01-12 05:51:09.40768	-1	\N	\N
22	is required to register	IS_REQUIRED_TO_REGISTER	EN	f	2022-01-12 07:38:15.125243	-1	\N	\N
23	необходимо зарегистрироваться	IS_REQUIRED_TO_REGISTER	RU	f	2022-01-12 07:38:15.125243	-1	\N	\N
24	ro‘yxatdan o‘tish talab qilinadi	IS_REQUIRED_TO_REGISTER	UZ	f	2022-01-12 07:38:15.125243	-1	\N	\N
25	is required to login	IS_REQUIRED_TO_LOGIN	EN	f	2022-01-12 07:38:15.125243	-1	\N	\N
26	требуется для входа	IS_REQUIRED_TO_LOGIN	RU	f	2022-01-12 07:38:15.125243	-1	\N	\N
27	kirish uchun talab qilinadi	IS_REQUIRED_TO_LOGIN	UZ	f	2022-01-12 07:38:15.125243	-1	\N	\N
28	username is available	USERNAME_IS_AVAILABLE	EN	f	2022-01-12 10:00:52.469366	-1	\N	\N
29	имя пользователя доступно	USERNAME_IS_AVAILABLE	RU	f	2022-01-12 10:00:52.469366	-1	\N	\N
32	электронная почта доступна	EMAIL_IS_AVAILABLE	RU	f	2022-01-12 10:00:52.469366	-1	\N	\N
33	elektron pochta mavjud	EMAIL_IS_AVAILABLE	UZ	f	2022-01-12 10:00:52.469366	-1	\N	\N
30	foydalanuvchi nomi mavjud	USERNAME_IS_AVAILABLE	UZ	f	2022-01-12 10:00:52.469366	-1	\N	\N
36	telefon raqami mavjud	PHONE_IS_AVAILABLE	UZ	f	2022-01-12 10:00:52.469366	-1	\N	\N
34	phone number is available	PHONE_IS_AVAILABLE	EN	f	2022-01-12 10:00:52.469366	-1	\N	\N
31	email is available	EMAIL_IS_AVAILABLE	EN	f	2022-01-12 10:00:52.469366	-1	\N	\N
35	номер телефона доступен	PHONE_IS_AVAILABLE	RU	f	2022-01-12 10:00:52.469366	-1	\N	\N
37	bad credentials	BAD_CREDENTIALS	EN	f	2022-01-12 13:52:09.298585	-1	\N	\N
38	Неверные учетные данные	BAD_CREDENTIALS	RU	f	2022-01-12 13:52:09.298585	-1	\N	\N
39	yomon hisob ma'lumotlari	BAD_CREDENTIALS	UZ	f	2022-01-12 13:52:09.298585	-1	\N	\N
40	you are not login	YOU_ARE_NOT_LOGIN	EN	f	2022-01-12 15:37:18.088683	-1	\N	\N
41	вы не авторизовались	YOU_ARE_NOT_LOGIN	RU	f	2022-01-12 15:37:18.088683	-1	\N	\N
42	siz login emassiz	YOU_ARE_NOT_LOGIN	UZ	f	2022-01-12 15:37:18.088683	-1	\N	\N
43	permission denied	PERMISSION_DENIED	EN	f	2022-01-12 16:06:05.997773	-1	\N	\N
44	доступ запрещен	PERMISSION_DENIED	RU	f	2022-01-12 16:06:05.997773	-1	\N	\N
45	ruxsat berilmadi	PERMISSION_DENIED	UZ	f	2022-01-12 16:06:05.997773	-1	\N	\N
46	is required to update	IS_REQUIRED_TO_UPDATE	EN	f	2022-01-12 19:56:11.972131	-1	\N	\N
47	необходимо обновить	IS_REQUIRED_TO_UPDATE	RU	f	2022-01-12 19:56:11.972131	-1	\N	\N
48	yangilash talab qilinadi	IS_REQUIRED_TO_UPDATE	UZ	f	2022-01-12 19:56:11.972131	-1	\N	\N
49	is required to reset password	IS_REQUIRED_TO_RESET_PASSWORD	EN	f	2022-01-13 06:57:39.681909	-1	\N	\N
50	требуется для сброса пароля	IS_REQUIRED_TO_RESET_PASSWORD	RU	f	2022-01-13 06:57:39.681909	-1	\N	\N
51	parolni tiklash uchun talab qilinadi	IS_REQUIRED_TO_RESET_PASSWORD	UZ	f	2022-01-13 06:57:39.681909	-1	\N	\N
52	is required to create card	IS_REQUIRED_TO_CREATE_CARD	EN	f	2022-01-13 14:58:23.958238	-1	\N	\N
53	требуется для создания карты	IS_REQUIRED_TO_CREATE_CARD	RU	f	2022-01-13 14:58:23.958238	-1	\N	\N
54	kartani yaratish uchun talab qilinadi	IS_REQUIRED_TO_CREATE_CARD	UZ	f	2022-01-13 14:58:23.958238	-1	\N	\N
55	is required to update card	IS_REQUIRED_TO_UPDATE_CARD	EN	f	2022-01-13 14:58:23.958238	-1	\N	\N
56	требуется обновить карту	IS_REQUIRED_TO_UPDATE_CARD	RU	f	2022-01-13 14:58:23.958238	-1	\N	\N
57	kartani yangilash uchun talab qilinadi	IS_REQUIRED_TO_UPDATE_CARD	UZ	f	2022-01-13 14:58:23.958238	-1	\N	\N
58	card type not found	CARD_TYPE_NOT_FOUND	EN	f	2022-01-13 15:06:48.770519	-1	\N	\N
59	тип карты не найден	CARD_TYPE_NOT_FOUND	RU	f	2022-01-13 15:06:48.770519	-1	\N	\N
60	karta turi topilmadi	CARD_TYPE_NOT_FOUND	UZ	f	2022-01-13 15:06:48.770519	-1	\N	\N
61	card number is already taken	CARD_NUMBER_IS_ALREADY_TAKEN	EN	f	2022-01-13 15:25:53.417027	-1	\N	\N
62	номер карты уже занят	CARD_NUMBER_IS_ALREADY_TAKEN	RU	f	2022-01-13 15:25:53.417027	-1	\N	\N
63	karta raqami allaqachon olingan	CARD_NUMBER_IS_ALREADY_TAKEN	UZ	f	2022-01-13 15:25:53.417027	-1	\N	\N
64	card not found	CARD_NOT_FOUND	EN	f	2022-01-13 16:15:36.314354	-1	\N	\N
65	карта не найдена	CARD_NOT_FOUND	RU	f	2022-01-13 16:15:36.314354	-1	\N	\N
66	karta topilmadi	CARD_NOT_FOUND	UZ	f	2022-01-13 16:15:36.314354	-1	\N	\N
67	card type is already taken	CARD_TYPE_IS_ALREADY_TAKEN	EN	f	2022-01-13 17:52:32.726406	-1	\N	\N
68	тип карты уже занят	CARD_TYPE_IS_ALREADY_TAKEN	RU	f	2022-01-13 17:52:32.726406	-1	\N	\N
69	karta turi allaqachon olingan	CARD_TYPE_IS_ALREADY_TAKEN	UZ	f	2022-01-13 17:52:32.726406	-1	\N	\N
70	language code is already taken	LANGUAGE_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-13 19:03:35.264209	-1	\N	\N
71	код языка уже занят	LANGUAGE_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-13 19:03:35.264209	-1	\N	\N
72	til kodi allaqachon olingan	LANGUAGE_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-13 19:03:35.264209	-1	\N	\N
73	role code is already taken	ROLE_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-13 20:55:29.272918	-1	\N	\N
74	код роли уже занят	ROLE_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-13 20:55:29.272918	-1	\N	\N
75	rol kodi allaqachon olingan	ROLE_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-13 20:55:29.272918	-1	\N	\N
76	role not found	ROLE_NOT_FOUND	EN	f	2022-01-14 03:14:43.116805	-1	\N	\N
77	роль не найдена	ROLE_NOT_FOUND	RU	f	2022-01-14 03:14:43.116805	-1	\N	\N
78	rol topilmadi	ROLE_NOT_FOUND	UZ	f	2022-01-14 03:14:43.116805	-1	\N	\N
80	разрешение не найдено	PERMISSION_NOT_FOUND	RU	f	2022-01-14 03:14:43.116805	-1	\N	\N
79	permission not found	PERMISSION_NOT_FOUND	EN	f	2022-01-14 03:14:43.116805	-1	\N	\N
81	ruxsat topilmadi	PERMISSION_NOT_FOUND	UZ	f	2022-01-14 03:14:43.116805	-1	\N	\N
82	permission code is already taken	PERMISSION_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-14 03:56:11.392917	-1	\N	\N
83	код доступа уже занят	PERMISSION_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-14 03:56:11.392917	-1	\N	\N
84	ruxsat kodi allaqachon olingan	PERMISSION_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-14 03:56:11.392917	-1	\N	\N
85	status not found	STATUS_NOT_FOUND	EN	f	2022-01-14 13:03:45.755425	-1	\N	\N
86	статус не найден	STATUS_NOT_FOUND	RU	f	2022-01-14 13:03:45.755425	-1	\N	\N
87	holati topilmadi	STATUS_NOT_FOUND	UZ	f	2022-01-14 13:03:45.755425	-1	\N	\N
88	status code is already taken	STATUS_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-14 13:03:45.755425	-1	\N	\N
89	код состояния уже занят	STATUS_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-14 13:03:45.755425	-1	\N	\N
90	holat kodi allaqachon olingan	STATUS_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-14 13:03:45.755425	-1	\N	\N
92	param is null	PARAM_IS_NULL	EN	f	2022-01-15 18:41:33.168696	-1	\N	\N
93	параметр равен нулю	PARAM_IS_NULL	RU	f	2022-01-15 18:41:33.168696	-1	\N	\N
94	param null	PARAM_IS_NULL	UZ	f	2022-01-15 18:41:33.168696	-1	\N	\N
95	not found	NOT_FOUND	EN	f	2022-01-15 18:46:26.771512	-1	\N	\N
96	не найден	NOT_FOUND	RU	f	2022-01-15 18:46:26.771512	-1	\N	\N
97	topilmadi	NOT_FOUND	UZ	f	2022-01-15 18:46:26.771512	-1	\N	\N
98	there is such a coded product	THERE_IS_SUCH_A_CODED_PRODUCT	EN	f	2022-01-15 18:51:40.705648	-1	\N	\N
99	есть такой кодированный продукт	THERE_IS_SUCH_A_CODED_PRODUCT	RU	f	2022-01-15 18:51:40.705648	-1	\N	\N
100	shunday kodlangan mahsulot mavjud	THERE_IS_SUCH_A_CODED_PRODUCT	UZ	f	2022-01-15 18:51:40.705648	-1	\N	\N
101	product not found	PRODUCT_NOT_FOUND	EN	f	2022-01-15 19:40:38.426287	-1	\N	\N
102	продукт не найден	PRODUCT_NOT_FOUND	RU	f	2022-01-15 19:40:38.426287	-1	\N	\N
103	mahsulot topilmadi	PRODUCT_NOT_FOUND	UZ	f	2022-01-15 19:40:38.426287	-1	\N	\N
104	Product image not found	PRODUCT_IMG_NOT_FOUND	EN	f	2022-01-18 06:25:14.310765	-1	\N	\N
105	Изображение продукта не найден	PRODUCT_IMG_NOT_FOUND	RU	f	2022-01-18 06:25:14.310765	-1	\N	\N
106	Mahsulot tasviri topilmadi	PRODUCT_IMG_NOT_FOUND	UZ	f	2022-01-18 06:25:14.310765	-1	\N	\N
107	comment not found	COMMENT_NOT_FOUND	EN	f	2022-01-19 05:31:11.142028	-1	\N	\N
108	комментарий не найден	COMMENT_NOT_FOUND	RU	f	2022-01-19 05:31:11.142028	-1	\N	\N
109	izoh topilmadi	COMMENT_NOT_FOUND	UZ	f	2022-01-19 05:31:11.142028	-1	\N	\N
110	sponsor not found	SPONSOR_NOT_FOUND	EN	f	2022-01-19 09:55:17.638267	-1	\N	\N
111	спонсор не найден	SPONSOR_NOT_FOUND	RU	f	2022-01-19 09:55:17.638267	-1	\N	\N
112	homiy topilmadi	SPONSOR_NOT_FOUND	UZ	f	2022-01-19 09:55:17.638267	-1	\N	\N
113	sponsor already created	SPONSOR_FOUND	EN	f	2022-01-19 10:13:20.668358	-1	\N	\N
114	спонсор уже создан	SPONSOR_FOUND	RU	f	2022-01-19 10:13:20.668358	-1	\N	\N
115	homiy allaqachon yaratilgan	SPONSOR_FOUND	UZ	f	2022-01-19 10:13:20.668358	-1	\N	\N
116	rule type already created	RULE_TYPE_FOUND	EN	f	2022-01-19 15:53:22.058044	-1	\N	\N
117	тип правила уже создан	RULE_TYPE_FOUND	RU	f	2022-01-19 15:53:22.058044	-1	\N	\N
118	qoida turi allaqachon yaratilgan	RULE_TYPE_FOUND	UZ	f	2022-01-19 15:53:22.058044	-1	\N	\N
119	rule found	RULE_FOUND	EN	f	2022-01-19 16:07:30.134554	-1	\N	\N
120	правило найдено	RULE_FOUND	RU	f	2022-01-19 16:07:30.134554	-1	\N	\N
121	qoida topildi	RULE_FOUND	UZ	f	2022-01-19 16:07:30.134554	-1	\N	\N
122	rule not found	RULE_NOT_FOUND	EN	f	2022-01-19 16:15:27.923694	-1	\N	\N
123	правило не найдено	RULE_NOT_FOUND	RU	f	2022-01-19 16:15:27.923694	-1	\N	\N
124	qoida topilmadi	RULE_NOT_FOUND	UZ	f	2022-01-19 16:15:27.923694	-1	\N	\N
125	rule type not found	RULE_TYPE_NOT_FOUND	EN	f	2022-01-19 19:16:21.890564	-1	\N	\N
126	тип правила не найден	RULE_TYPE_NOT_FOUND	RU	f	2022-01-19 19:16:21.890564	-1	\N	\N
127	qoida turi topilmadi	RULE_TYPE_NOT_FOUND	UZ	f	2022-01-19 19:16:21.890564	-1	\N	\N
128	help found	HELP_FOUND	EN	f	2022-01-19 20:44:59.560263	-1	\N	\N
129	помощь найдена	HELP_FOUND	RU	f	2022-01-19 20:44:59.560263	-1	\N	\N
130	yordam topildi	HELP_FOUND	UZ	f	2022-01-19 20:44:59.560263	-1	\N	\N
131	help not found	HELP_NOT_FOUND	EN	f	2022-01-19 20:56:17.644342	-1	\N	\N
132	помощь не найдена	HELP_NOT_FOUND	RU	f	2022-01-19 20:56:17.644342	-1	\N	\N
133	yordam topilmadi	HELP_NOT_FOUND	UZ	f	2022-01-19 20:56:17.644342	-1	\N	\N
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.comment (id, user_id, message, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	29	hi bro how are you?	f	2022-01-19 05:21:24.598047	29	\N	\N
5	29	hi bro how are you?	f	2022-01-19 05:22:49.332377	29	\N	\N
6	29	hi bro how are you?	f	2022-01-19 05:23:40.268969	29	\N	\N
7	29	hi bro how are you?	f	2022-01-19 05:24:20.40146	29	\N	\N
8	29	hi bro how are you?	f	2022-01-19 05:24:24.767709	29	\N	\N
9	29	hi bro how are you?	f	2022-01-19 05:25:53.042193	29	\N	\N
\.


--
-- Data for Name: help; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.help (id, body, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	not problem	f	2022-01-19 20:52:14.694978	29	2022-01-19 21:04:05.12564	29
\.


--
-- Data for Name: rule; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.rule (id, type, body, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	DEL_ACC	this message	f	2022-01-19 16:11:41.220338	29	2022-01-19 17:36:35.253737	29
\.


--
-- Data for Name: rule_type; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.rule_type (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	hi bro	DEL_ACC	f	2022-01-19 15:58:55.757096	29	2022-01-19 19:36:36.218327	29
\.


--
-- Data for Name: sponsors; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.sponsors (id, name, phone, email, logo, location, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	Oracle	993733273    	st2emx@gmail.com	logo.png	(2, 1)	f	2022-01-19 10:13:38.408927	29	\N	\N
4	Oracle2	99373341273  	st2e2mx@gmail.com	logo.png	(2, 1)	f	2022-01-19 10:21:24.852707	29	\N	\N
\.


--
-- Name: auth_balance_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_balance_id_seq', 5, true);


--
-- Name: auth_block_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_block_id_seq', 3, true);


--
-- Name: auth_card_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_card_id_seq', 4, true);


--
-- Name: auth_card_type_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_card_type_id_seq', 5, true);


--
-- Name: auth_language_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_language_id_seq', 5, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_permission_id_seq', 93, true);


--
-- Name: auth_role_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_role_id_seq', 5, true);


--
-- Name: auth_role_permission_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_role_permission_id_seq', 176, true);


--
-- Name: auth_session_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_session_id_seq', 15, true);


--
-- Name: auth_status_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_status_id_seq', 3, true);


--
-- Name: auth_token_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_token_id_seq', 15, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_user_id_seq', 29, true);


--
-- Name: auth_user_role_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_user_role_id_seq', 33, true);


--
-- Name: basket_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.basket_id_seq', 1, false);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.category_id_seq', 2, true);


--
-- Name: like_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.like_id_seq', 1, false);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.order_id_seq', 1, false);


--
-- Name: order_status_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.order_status_id_seq', 1, false);


--
-- Name: order_type_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.order_type_id_seq', 1, false);


--
-- Name: product_comment_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_comment_id_seq', 2, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_id_seq', 9, true);


--
-- Name: product_image_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_image_id_seq', 2, true);


--
-- Name: product_price_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_price_id_seq', 9, true);


--
-- Name: product_rating_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_rating_id_seq', 2, true);


--
-- Name: transaction_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.transaction_id_seq', 1, false);


--
-- Name: transaction_status_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.transaction_status_id_seq', 1, false);


--
-- Name: transaction_type_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.transaction_type_id_seq', 1, false);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: settings; Owner: postgres
--

SELECT pg_catalog.setval('settings.log_id_seq', 200, true);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: settings; Owner: postgres
--

SELECT pg_catalog.setval('settings.message_id_seq', 133, true);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.comment_id_seq', 9, true);


--
-- Name: help_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.help_id_seq', 1, true);


--
-- Name: rule_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.rule_id_seq', 1, true);


--
-- Name: rule_type_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.rule_type_id_seq', 1, true);


--
-- Name: sponsors_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.sponsors_id_seq', 4, true);


--
-- Name: auth_balance auth_balance_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_balance
    ADD CONSTRAINT auth_balance_pkey PRIMARY KEY (id);


--
-- Name: auth_block auth_block_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_block
    ADD CONSTRAINT auth_block_pkey PRIMARY KEY (id);


--
-- Name: auth_card auth_card_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_card
    ADD CONSTRAINT auth_card_pkey PRIMARY KEY (id);


--
-- Name: auth_card_type auth_card_type_code_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_card_type
    ADD CONSTRAINT auth_card_type_code_key UNIQUE (code);


--
-- Name: auth_card_type auth_card_type_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_card_type
    ADD CONSTRAINT auth_card_type_pkey PRIMARY KEY (id);


--
-- Name: auth_language auth_language_code_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_language
    ADD CONSTRAINT auth_language_code_key UNIQUE (code);


--
-- Name: auth_language auth_language_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_language
    ADD CONSTRAINT auth_language_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_code_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_permission
    ADD CONSTRAINT auth_permission_code_key UNIQUE (code);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_role auth_role_code_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_role
    ADD CONSTRAINT auth_role_code_key UNIQUE (code);


--
-- Name: auth_role_permission auth_role_permission_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_role_permission
    ADD CONSTRAINT auth_role_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_role auth_role_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_role
    ADD CONSTRAINT auth_role_pkey PRIMARY KEY (id);


--
-- Name: auth_session auth_session_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_session
    ADD CONSTRAINT auth_session_pkey PRIMARY KEY (id);


--
-- Name: auth_status auth_status_code_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_status
    ADD CONSTRAINT auth_status_code_key UNIQUE (code);


--
-- Name: auth_status auth_status_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_status
    ADD CONSTRAINT auth_status_pkey PRIMARY KEY (id);


--
-- Name: auth_token auth_token_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_token
    ADD CONSTRAINT auth_token_pkey PRIMARY KEY (id);


--
-- Name: auth_token auth_token_token_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_token
    ADD CONSTRAINT auth_token_token_key UNIQUE (token);


--
-- Name: auth_user auth_user_code_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user
    ADD CONSTRAINT auth_user_code_key UNIQUE (code);


--
-- Name: auth_user auth_user_email_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user
    ADD CONSTRAINT auth_user_email_key UNIQUE (email);


--
-- Name: auth_user auth_user_phone_key; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user
    ADD CONSTRAINT auth_user_phone_key UNIQUE (phone);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_role auth_user_role_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user_role
    ADD CONSTRAINT auth_user_role_pkey PRIMARY KEY (id);


--
-- Name: basket basket_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.basket
    ADD CONSTRAINT basket_pkey PRIMARY KEY (id);


--
-- Name: category category_code_key; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.category
    ADD CONSTRAINT category_code_key UNIQUE (code);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: like like_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."like"
    ADD CONSTRAINT like_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: order_status order_status_code_key; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.order_status
    ADD CONSTRAINT order_status_code_key UNIQUE (code);


--
-- Name: order_status order_status_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.order_status
    ADD CONSTRAINT order_status_pkey PRIMARY KEY (id);


--
-- Name: order_type order_type_code_key; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.order_type
    ADD CONSTRAINT order_type_code_key UNIQUE (code);


--
-- Name: order_type order_type_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.order_type
    ADD CONSTRAINT order_type_pkey PRIMARY KEY (id);


--
-- Name: product product_code_key; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product
    ADD CONSTRAINT product_code_key UNIQUE (code);


--
-- Name: product_comment product_comment_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_comment
    ADD CONSTRAINT product_comment_pkey PRIMARY KEY (id);


--
-- Name: product_image product_image_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_image
    ADD CONSTRAINT product_image_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product_price product_price_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_price
    ADD CONSTRAINT product_price_pkey PRIMARY KEY (id);


--
-- Name: product_rating product_rating_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_rating
    ADD CONSTRAINT product_rating_pkey PRIMARY KEY (id);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


--
-- Name: transaction_status transaction_status_code_key; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction_status
    ADD CONSTRAINT transaction_status_code_key UNIQUE (code);


--
-- Name: transaction_status transaction_status_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction_status
    ADD CONSTRAINT transaction_status_pkey PRIMARY KEY (id);


--
-- Name: transaction_type transaction_type_code_key; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction_type
    ADD CONSTRAINT transaction_type_code_key UNIQUE (code);


--
-- Name: transaction_type transaction_type_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction_type
    ADD CONSTRAINT transaction_type_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: settings; Owner: postgres
--

ALTER TABLE ONLY settings.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: settings; Owner: postgres
--

ALTER TABLE ONLY settings.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: help help_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.help
    ADD CONSTRAINT help_pkey PRIMARY KEY (id);


--
-- Name: rule rule_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.rule
    ADD CONSTRAINT rule_pkey PRIMARY KEY (id);


--
-- Name: rule_type rule_type_code_key; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.rule_type
    ADD CONSTRAINT rule_type_code_key UNIQUE (code);


--
-- Name: rule_type rule_type_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.rule_type
    ADD CONSTRAINT rule_type_pkey PRIMARY KEY (id);


--
-- Name: sponsors sponsors_email_key; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.sponsors
    ADD CONSTRAINT sponsors_email_key UNIQUE (email);


--
-- Name: sponsors sponsors_phone_key; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.sponsors
    ADD CONSTRAINT sponsors_phone_key UNIQUE (phone);


--
-- Name: sponsors sponsors_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.sponsors
    ADD CONSTRAINT sponsors_pkey PRIMARY KEY (id);


--
-- Name: auth_user_unique_index; Type: INDEX; Schema: auth; Owner: postgres
--

CREATE UNIQUE INDEX auth_user_unique_index ON auth.auth_user USING btree (username, is_deleted);


--
-- Name: auth_balance auth_balance_card_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_balance
    ADD CONSTRAINT auth_balance_card_id_fkey FOREIGN KEY (card_id) REFERENCES auth.auth_card(id) ON DELETE CASCADE;


--
-- Name: auth_block auth_block_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_block
    ADD CONSTRAINT auth_block_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id) ON DELETE CASCADE;


--
-- Name: auth_card auth_card_card_type_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_card
    ADD CONSTRAINT auth_card_card_type_fkey FOREIGN KEY (card_type) REFERENCES auth.auth_card_type(code) ON DELETE CASCADE;


--
-- Name: auth_card auth_card_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_card
    ADD CONSTRAINT auth_card_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id) ON DELETE CASCADE;


--
-- Name: auth_role_permission auth_role_permission_auth_user_role_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_role_permission
    ADD CONSTRAINT auth_role_permission_auth_user_role_id_fkey FOREIGN KEY (auth_user_role_id) REFERENCES auth.auth_user_role(id) ON DELETE CASCADE;


--
-- Name: auth_role_permission auth_role_permission_permission_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_role_permission
    ADD CONSTRAINT auth_role_permission_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth.auth_permission(id) ON DELETE CASCADE;


--
-- Name: auth_session auth_session_token_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_session
    ADD CONSTRAINT auth_session_token_id_fkey FOREIGN KEY (token_id) REFERENCES auth.auth_token(id) ON DELETE CASCADE;


--
-- Name: auth_session auth_session_user_code_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_session
    ADD CONSTRAINT auth_session_user_code_fkey FOREIGN KEY (user_code) REFERENCES auth.auth_user(code) ON DELETE CASCADE;


--
-- Name: auth_token auth_token_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_token
    ADD CONSTRAINT auth_token_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id);


--
-- Name: auth_user auth_user_language_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user
    ADD CONSTRAINT auth_user_language_fkey FOREIGN KEY (language) REFERENCES auth.auth_language(code) ON DELETE CASCADE;


--
-- Name: auth_user_role auth_user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user_role
    ADD CONSTRAINT auth_user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES auth.auth_role(code) ON DELETE CASCADE;


--
-- Name: auth_user_role auth_user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user_role
    ADD CONSTRAINT auth_user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id) ON DELETE CASCADE;


--
-- Name: auth_user auth_user_status_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user
    ADD CONSTRAINT auth_user_status_fkey FOREIGN KEY (status) REFERENCES auth.auth_status(code) ON DELETE CASCADE;


--
-- Name: basket basket_order_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.basket
    ADD CONSTRAINT basket_order_id_fkey FOREIGN KEY (order_id) REFERENCES project."order"(id) ON DELETE CASCADE;


--
-- Name: basket basket_product_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.basket
    ADD CONSTRAINT basket_product_id_fkey FOREIGN KEY (product_id) REFERENCES project.product(id) ON DELETE CASCADE;


--
-- Name: basket basket_user_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.basket
    ADD CONSTRAINT basket_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id) ON DELETE CASCADE;


--
-- Name: like like_product_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."like"
    ADD CONSTRAINT like_product_id_fkey FOREIGN KEY (product_id) REFERENCES project.product(id) ON DELETE CASCADE;


--
-- Name: like like_user_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."like"
    ADD CONSTRAINT like_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id) ON DELETE CASCADE;


--
-- Name: order order_card_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."order"
    ADD CONSTRAINT order_card_id_fkey FOREIGN KEY (card_id) REFERENCES auth.auth_card(id) ON DELETE CASCADE;


--
-- Name: order order_status_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."order"
    ADD CONSTRAINT order_status_fkey FOREIGN KEY (status) REFERENCES project.order_status(code) ON DELETE CASCADE;


--
-- Name: order order_type_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."order"
    ADD CONSTRAINT order_type_fkey FOREIGN KEY (type) REFERENCES project.order_type(code) ON DELETE CASCADE;


--
-- Name: order order_user_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project."order"
    ADD CONSTRAINT order_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id) ON DELETE CASCADE;


--
-- Name: product product_category_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product
    ADD CONSTRAINT product_category_id_fkey FOREIGN KEY (category_id) REFERENCES project.category(id) ON DELETE CASCADE;


--
-- Name: product_comment product_comment_product_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_comment
    ADD CONSTRAINT product_comment_product_id_fkey FOREIGN KEY (product_id) REFERENCES project.product(id);


--
-- Name: product_comment product_comment_user_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_comment
    ADD CONSTRAINT product_comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id);


--
-- Name: product_image product_image_product_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_image
    ADD CONSTRAINT product_image_product_id_fkey FOREIGN KEY (product_id) REFERENCES project.product(id) ON DELETE CASCADE;


--
-- Name: product_price product_price_product_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_price
    ADD CONSTRAINT product_price_product_id_fkey FOREIGN KEY (product_id) REFERENCES project.product(id);


--
-- Name: product_rating product_rating_product_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.product_rating
    ADD CONSTRAINT product_rating_product_id_fkey FOREIGN KEY (product_id) REFERENCES project.product(id);


--
-- Name: transaction transaction_order_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction
    ADD CONSTRAINT transaction_order_id_fkey FOREIGN KEY (order_id) REFERENCES project."order"(id) ON DELETE CASCADE;


--
-- Name: transaction transaction_status_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction
    ADD CONSTRAINT transaction_status_fkey FOREIGN KEY (status) REFERENCES project.transaction_status(code) ON DELETE CASCADE;


--
-- Name: transaction transaction_type_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction
    ADD CONSTRAINT transaction_type_fkey FOREIGN KEY (type) REFERENCES project.transaction_type(code) ON DELETE CASCADE;


--
-- Name: transaction transaction_user_id_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY project.transaction
    ADD CONSTRAINT transaction_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id) ON DELETE CASCADE;


--
-- Name: message message_language_fkey; Type: FK CONSTRAINT; Schema: settings; Owner: postgres
--

ALTER TABLE ONLY settings.message
    ADD CONSTRAINT message_language_fkey FOREIGN KEY (language) REFERENCES auth.auth_language(code) ON DELETE CASCADE;


--
-- Name: comment comment_user_id_fkey; Type: FK CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id) ON DELETE CASCADE;


--
-- Name: rule rule_type_fkey; Type: FK CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.rule
    ADD CONSTRAINT rule_type_fkey FOREIGN KEY (type) REFERENCES system.rule_type(code) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

