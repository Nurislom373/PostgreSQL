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
-- Name: mapper; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mapper;


ALTER SCHEMA mapper OWNER TO postgres;

--
-- Name: order; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "order";


ALTER SCHEMA "order" OWNER TO postgres;

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
-- Name: auth_user_register_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.auth_user_register_dto AS (
	username character varying,
	password character varying,
	email character varying,
	phone character varying,
	language character varying,
	profile_pic text
);


ALTER TYPE dto.auth_user_register_dto OWNER TO postgres;

--
-- Name: auth_user_reset_password_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.auth_user_reset_password_dto AS (
	id bigint,
	old_pwd character varying,
	new_pwd character varying,
	new_confirm_pwd character varying
);


ALTER TYPE dto.auth_user_reset_password_dto OWNER TO postgres;

--
-- Name: auth_user_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.auth_user_update_dto AS (
	id bigint,
	username character varying,
	password character varying,
	email character varying,
	phone character varying,
	language character varying,
	profile_pic text
);


ALTER TYPE dto.auth_user_update_dto OWNER TO postgres;

--
-- Name: category_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.category_create_dto AS (
	parent_id bigint,
	name character varying,
	code character varying,
	image_path text,
	description text
);


ALTER TYPE dto.category_create_dto OWNER TO postgres;

--
-- Name: category_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.category_update_dto AS (
	id bigint,
	parent_id bigint,
	name character varying,
	code character varying,
	image_path text,
	description text
);


ALTER TYPE dto.category_update_dto OWNER TO postgres;

--
-- Name: order_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.order_create_dto AS (
	category_id bigint,
	title character varying,
	description text,
	condition character varying,
	price character varying,
	location character varying,
	image text
);


ALTER TYPE dto.order_create_dto OWNER TO postgres;

--
-- Name: order_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.order_update_dto AS (
	id bigint,
	category_id bigint,
	title character varying,
	description text,
	condition character varying,
	price character varying,
	location character varying
);


ALTER TYPE dto.order_update_dto OWNER TO postgres;

--
-- Name: auth_language_create(character varying, character varying, bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_language_create(p_name character varying, p_code character varying, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_language  auth.auth_language;
    response  text;
    return_id bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_CREATE', p_user_id);

    if p_code is null then
        raise exception 'p_code param is null';
    end if;

    select * into t_language from auth.auth_language where not is_deleted and code = p_code;

    if FOUND then
        raise exception 'language code found';
    end if;

    if p_name is null then
        raise exception 'p_name param is null';
    end if;

    insert into auth.auth_language (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into return_id;

    call system.write_log('function auth.auth_language_create(p_name varchar, p_code varchar(2), p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION auth.auth_language_create(p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_language_delete(bigint, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_language_delete(p_language_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_language auth.auth_language;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_language_id is null then
        raise exception 'p_language_id param is null';
    end if;

    select * into t_language from auth.auth_language where id = p_language_id;

    if not FOUND then
        raise exception 'language not found';
    end if;

    update auth.auth_language
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_language_id;

    call system.write_log('procedure auth.auth_status_delete(p_status_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_language_delete(p_language_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_language_list(bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_language_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_language   jsonb;
    v_language_s jsonb = '[]';
    t_language   auth.auth_language%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_language in (select * from auth.auth_language where not is_deleted)
        loop
            v_language = jsonb_build_object('name', t_language.name);
            v_language = v_language || jsonb_build_object('code', t_language.code);
            v_language = v_language || jsonb_build_object('created_at', t_language.created_at);
            v_language_s = v_language_s || v_language;
        end loop;

    call system.write_log('function auth.auth_language_list(p_user_id bigint) returns text');
    return v_language_s::text;
end;
$$;


ALTER FUNCTION auth.auth_language_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_language_update(bigint, character varying, character varying, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_language_update(p_language_id bigint, p_name character varying, p_code character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_language auth.auth_language;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_UPDATE', p_user_id);

    if p_language_id is null then
        raise exception 'p-language_id is null';
    end if;

    select * into t_language from auth.auth_language where not is_deleted and id = p_language_id;

    if not FOUND then
        raise exception 'language not found';
    end if;

    if p_name is null then
        raise exception 'p_name param is null';
    end if;

    if p_code is null then
        raise exception 'p_code param is null';
    end if;

    update auth.auth_language
    set name       = p_name,
        code       = p_code,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_language_id;

    call system.write_log('procedure auth.auth_language_update(p_status_id bigint, p_name varchar, p_code varchar, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_language_update(p_language_id bigint, p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_permission_create(character varying, character varying, bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_permission_create(p_name character varying, p_code character varying, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_permission auth.auth_permission;
    response   text;
    return_id  bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_CREATE', p_user_id);

    if p_code is null then
        raise exception 'p_code param is null';
    end if;

    select * into t_permission from auth.auth_permission where not is_deleted and code = p_code;

    if FOUND then
        raise exception 'permission code found';
    end if;

    if p_name is null then
        raise exception 'p_name param is null';
    end if;

    insert into auth.auth_permission (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into return_id;

    call system.write_log('function auth.auth_permission_create(p_name varchar, p_code varchar(2), p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION auth.auth_permission_create(p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_permission_delete(bigint, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_permission_delete(p_permission_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_permission auth.auth_permission;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_permission_id is null then
        raise exception 'p_permission_id param is null';
    end if;

    select * into t_permission from auth.auth_permission where id = p_permission_id;

    if not FOUND then
        raise exception 'permission not found';
    end if;

    update auth.auth_permission
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_permission_id;

    call system.write_log('procedure auth.auth_permission_delete(p_permission_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_permission_delete(p_permission_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_permission_list(bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_permission_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_permission   jsonb;
    v_permission_s jsonb = '[]';
    t_permission   auth.auth_permission%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_permission in (select * from auth.auth_permission where not is_deleted)
        loop
            v_permission = jsonb_build_object('name', t_permission.name);
            v_permission = v_permission || jsonb_build_object('code', t_permission.code);
            v_permission = v_permission || jsonb_build_object('created_at', t_permission.created_at);
            v_permission_s = v_permission_s || v_permission;
        end loop;

    call system.write_log('function auth.auth_permission_list(p_user_id bigint) returns text');
    return v_permission_s::text;
end;
$$;


ALTER FUNCTION auth.auth_permission_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_permission_update(bigint, character varying, character varying, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_permission_update(p_permission_id bigint, p_name character varying, p_code character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_permission auth.auth_permission;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_UPDATE', p_user_id);

    if p_permission_id is null then
        raise exception 'p-permission_id is null';
    end if;

    select * into t_permission from auth.auth_permission where not is_deleted and id = p_permission_id;

    if not FOUND then
        raise exception 'permission not found';
    end if;

    if p_name is null then
        raise exception 'p_name param is null';
    end if;

    if p_code is null then
        raise exception 'p_code param is null';
    end if;

    update auth.auth_permission
    set name       = p_name,
        code       = p_code,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_permission_id;

    call system.write_log('procedure auth.auth_permission_update(p_status_id bigint, p_name varchar, p_code varchar, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_permission_update(p_permission_id bigint, p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_role_create(character varying, character varying, bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_role_create(p_name character varying, p_code character varying, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_role  auth.auth_role;
    response  text;
    return_id bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_CREATE', p_user_id);

    if p_code is null then
        raise exception 'p_code param is null';
    end if;

    select * into t_role from auth.auth_role where not is_deleted and code = p_code;

    if FOUND then
        raise exception 'role code found';
    end if;

    if p_name is null then
        raise exception 'p_name param is null';
    end if;

    insert into auth.auth_role (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into return_id;

    call system.write_log('function auth.auth_role_create(p_name varchar, p_code varchar, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION auth.auth_role_create(p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_role_delete(bigint, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_role_delete(p_role_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_role auth.auth_role;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_role_id is null then
        raise exception 'p_role_id param is null';
    end if;

    select * into t_role from auth.auth_role where id = p_role_id;

    if not FOUND then
        raise exception 'role not found';
    end if;

    update auth.auth_role set is_deleted = true, updated_at = now(), updated_by = p_user_id where id = p_role_id;

    call system.write_log('procedure auth.auth_role_delete(p_status_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_role_delete(p_role_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_role_list(bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_role_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_role   jsonb;
    v_role_s jsonb = '[]';
    t_role   auth.auth_role%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_role in (select * from auth.auth_role where not is_deleted)
        loop
            v_role = jsonb_build_object('name', t_role.name);
            v_role = v_role || jsonb_build_object('code', t_role.code);
            v_role = v_role || jsonb_build_object('created_at', t_role.created_at);
            v_role_s = v_role_s || v_role;
        end loop;

    call system.write_log('function auth.auth_role_list(p_user_id bigint) returns text');
    return v_role_s::text;
end;
$$;


ALTER FUNCTION auth.auth_role_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_role_permission_create(bigint, bigint, bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_role_permission_create(p_auth_role_id bigint, p_permission_id bigint, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_user_role  auth.auth_user_role;
    t_permission auth.auth_permission;
    response     text;
    return_id    bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_CREATE', p_user_id);

    if p_auth_role_id is null then
        raise exception 'p_code param is null';
    end if;

    select * into t_user_role from auth.auth_user_role where not is_deleted and id = p_auth_role_id;

    if not FOUND then
        raise exception 'user_role found';
    end if;

    if p_permission_id is null then
        raise exception 'permission param is null';
    end if;

    select * into t_permission from auth.auth_permission where not is_deleted and id = p_permission_id;

    if not FOUND then
        raise exception 'user_permission found';
    end if;

    insert into auth.auth_role_permission (auth_user_role_id, permission_id, created_by)
    values (p_auth_role_id, p_permission_id, p_user_id)
    returning id into return_id;

    call system.write_log('function auth.auth_role_permission_create(p_auth_role_id bigint, p_permission_id bigint, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION auth.auth_role_permission_create(p_auth_role_id bigint, p_permission_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_role_permission_delete(bigint, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_role_permission_delete(p_role_permission_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_role_permission auth.auth_role_permission;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_role_permission_id is null then
        raise exception 'p_role_permission_id param is null';
    end if;

    select * into t_role_permission from auth.auth_role_permission where id = p_role_permission_id;

    if not FOUND then
        raise exception 'role_permission not found';
    end if;

    update auth.auth_role_permission set is_deleted = true, updated_at = now(), updated_by = p_user_id where id = p_role_permission_id;

    call system.write_log('procedure auth.auth_role_permission_delete(p_status_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_role_permission_delete(p_role_permission_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_role_permission_list(bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_role_permission_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_role_permission   jsonb;
    v_role_permission_s jsonb = '[]';
    t_role_permission   auth.auth_role_permission%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_role_permission in (select * from auth.auth_role_permission where not is_deleted)
        loop
            v_role_permission = jsonb_build_object('auth_user_role_id', t_role_permission.auth_user_role_id);
            v_role_permission = v_role_permission || jsonb_build_object('permission_id', t_role_permission.permission_id);
            v_role_permission = v_role_permission || jsonb_build_object('created_at', t_role_permission.created_at);
            v_role_permission_s = v_role_permission_s || v_role_permission;
        end loop;

    call system.write_log('function auth.auth_role_permission_list(p_user_id bigint) returns text');
    return v_role_permission_s::text;
end;
$$;


ALTER FUNCTION auth.auth_role_permission_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_role_update(bigint, character varying, character varying, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_role_update(p_role_id bigint, p_name character varying, p_code character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_role auth.auth_role;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_UPDATE', p_user_id);

    if p_role_id is null then
        raise exception 'p-role_id is null';
    end if;

    select * into t_role from auth.auth_role where not is_deleted and id = p_role_id;

    if not FOUND then
        raise exception 'role not found';
    end if;

    if p_name is null then
        raise exception 'p_name param is null';
    end if;

    if p_code is null then
        raise exception 'p_code param is null';
    end if;

    update auth.auth_role
    set name       = p_name,
        code       = p_code,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_role_id;

    call system.write_log('procedure auth.auth_role_update(p_status_id bigint, p_name varchar, p_code varchar, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_role_update(p_role_id bigint, p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_status_create(character varying, character varying, bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_status_create(p_name character varying, p_code character varying, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_status  auth.auth_status;
    response  text;
    return_id bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_CREATE', p_user_id);

    if p_code is null then
        raise exception 'p_code param is null';
    end if;

    select * into t_status from auth.auth_status where not is_deleted and code = p_code;

    if FOUND then
        raise exception 'status code found';
    end if;

    if p_name is null then
        raise exception 'p_name param is null';
    end if;

    insert into auth.auth_status (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into return_id;

    call system.write_log('function auth.auth_status_create(p_name varchar, p_code varchar, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION auth.auth_status_create(p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_status_delete(bigint, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_status_delete(p_status_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_status auth.auth_status;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_status_id is null then
        raise exception 'p_status_id param is null';
    end if;

    select * into t_status from auth.auth_status where id = p_status_id;

    if not FOUND then
        raise exception 'status not found';
    end if;

    update auth.auth_status set is_deleted = true, updated_at = now(), updated_by = p_user_id where id = p_status_id;

    call system.write_log('procedure auth.auth_status_delete(p_status_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_status_delete(p_status_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_status_list(bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_status_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_status   jsonb;
    v_status_s jsonb = '[]';
    t_status   auth.auth_status%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_status in (select * from auth.auth_status where not is_deleted)
        loop
            v_status = jsonb_build_object('name', t_status.name);
            v_status = v_status || jsonb_build_object('code', t_status.code);
            v_status = v_status || jsonb_build_object('created_at', t_status.created_at);
            v_status_s = v_status_s || v_status;
        end loop;

    call system.write_log('function auth.auth_status_list(p_user_id bigint) returns text');
    return v_status_s::text;
end;
$$;


ALTER FUNCTION auth.auth_status_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_status_update(bigint, character varying, character varying, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_status_update(p_status_id bigint, p_name character varying, p_code character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_status auth.auth_status;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_UPDATE', p_user_id);

    if p_status_id is null then
        raise exception 'p-status_id is null';
    end if;

    select * into t_status from auth.auth_status where not is_deleted and id = p_status_id;

    if not FOUND then
        raise exception 'status not found';
    end if;

    if p_name is null then
        raise exception 'p_name param is null';
    end if;

    if p_code is null then
        raise exception 'p_code param is null';
    end if;

    update auth.auth_status
    set name       = p_name,
        code       = p_code,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_status_id;

    call system.write_log('procedure auth.auth_status_update(p_status_id bigint, p_name varchar, p_code varchar, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_status_update(p_status_id bigint, p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_token_create(bigint, bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_token_create(t_user_id bigint, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_token   auth.auth_token;
    response  text;
    return_id bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_CREATE', p_user_id);

    if t_user_id is null then
        raise exception 't_user_id param is null';
    end if;

    select * into t_token from auth.auth_token where not is_deleted and user_id = t_user_id;

    if FOUND then
        raise exception 'token found';
    end if;

    insert into auth.auth_token (user_id, created_by)
    values (t_user_id, p_user_id)
    returning id into return_id;

    call system.write_log('function auth.auth_token_create(t_user_id bigint, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION auth.auth_token_create(t_user_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_token_delete(bigint, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_token_delete(p_token_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_token auth.auth_token;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_token_id is null then
        raise exception 'p_token_id param is null';
    end if;

    select * into t_token from auth.auth_token where id = p_token_id;

    if not FOUND then
        raise exception 'token not found';
    end if;

    update auth.auth_token set is_deleted = true, updated_at = now(), updated_by = p_user_id where id = p_token_id;

    call system.write_log('procedure auth.auth_token_delete(p_status_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_token_delete(p_token_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_token_list(bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_token_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_token   jsonb;
    v_token_s jsonb = '[]';
    t_token   auth.auth_token%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_token in (select * from auth.auth_token where not is_deleted)
        loop
            v_token = jsonb_build_object('user_id', t_token.user_id);
            v_token = v_token || jsonb_build_object('token', t_token.token);
            v_token = v_token || jsonb_build_object('duration', t_token.duration);
            v_token = v_token || jsonb_build_object('created_at', t_token.created_at);
            v_token_s = v_token_s || v_token;
        end loop;

    call system.write_log('function auth.auth_token_list(p_user_id bigint) returns text');
    return v_token_s::text;
end;
$$;


ALTER FUNCTION auth.auth_token_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_user_change_language(bigint, character varying, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_user_change_language(ch_user_id bigint, ch_user_lang character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('USER_CHANGE_LANG', p_user_id);

    if ch_user_id is null then
        raise exception 'ch_user_id param is null';
    end if;

    select * into t_auth_user from auth.auth_user where id = ch_user_id;

    if not FOUND then
        raise exception 'user not found';
    end if;

    update auth.auth_user set language = ch_user_lang, updated_at = now(), updated_by = p_user_id where id = ch_user_id;

    call system.write_log('procedure auth.auth_user_change_language(ch_user_id bigint, ch_user_lang varchar, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_user_change_language(ch_user_id bigint, ch_user_lang character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_user_delete(bigint, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_user_delete(del_user_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('USER_DELETE', p_user_id);

    if del_user_id is null then
        raise exception 'del_user_id param is null';
    end if;

    select * into t_auth_user from auth.auth_user where id = del_user_id;

    if not FOUND then
        raise exception 'delete user not found';
    end if;

    update auth.auth_user set is_deleted = true where id = del_user_id;

    call system.write_log('procedure auth.auth_user_delete(del_user_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_user_delete(del_user_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_user_like_order_delete(bigint, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_user_like_order_delete(p_user_like_order_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_user_like_order auth.user_like_order;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_user_like_order_id is null then
        raise exception 'p_user_like_order_id param is null';
    end if;

    select * into t_user_like_order from auth.user_like_order where id = p_user_like_order_id;

    if not FOUND then
        raise exception 'user_like_order not found';
    end if;

    update auth.user_like_order
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_user_like_order_id;

    call system.write_log('procedure auth.auth_user_like_order_delete(p_status_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_user_like_order_delete(p_user_like_order_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_user_like_order_list(bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_user_like_order_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_user_like_order   jsonb;
    v_user_like_order_s jsonb = '[]';
    t_user_like_order   auth.user_like_order%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_user_like_order in (select * from auth.user_like_order where not is_deleted)
        loop
            v_user_like_order = jsonb_build_object('user_id', t_user_like_order.user_id);
            v_user_like_order = v_user_like_order || jsonb_build_object('order_id', t_user_like_order.order_id);
            v_user_like_order = v_user_like_order || jsonb_build_object('created_at', t_user_like_order.created_at);
            v_user_like_order_s = v_user_like_order_s || v_user_like_order;
        end loop;

    call system.write_log('function auth.auth_user_like_order_list(p_user_id bigint) returns text');
    return v_user_like_order_s::text;
end;
$$;


ALTER FUNCTION auth.auth_user_like_order_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_user_login(character varying, character varying, text); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_user_login(p_username character varying, p_pwd character varying, INOUT p_result text DEFAULT ''::text)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user;
    t_token     auth.auth_token;
begin
    if p_username is null then
        raise exception 'p_username param is null';
    end if;

    if p_pwd is null then
        raise exception 'p_pwd param is null';
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and username = p_username;

    if not FOUND then
        raise exception 'user not found';
    end if;

    if not utils.matches(password := p_pwd, encoded_password := t_auth_user.password) then
        raise exception 'password incorrect';
    end if;

    if t_auth_user.status <> 'ACTIVE' then
        raise exception 'user not active';
    end if;

    insert into auth.auth_token (user_id) values (t_auth_user.id) returning * into t_token;

    insert into auth.auth_session (token_id, user_code, created_by)
    values (t_token.id, t_auth_user.code, t_auth_user.id);

    call system.write_log('procedure auth.auth_user_login(p_username varchar, p_pwd varchar, INOUT p_result text default ''''::text)');
    p_result = 'successfully registered';
end;
$$;


ALTER PROCEDURE auth.auth_user_login(p_username character varying, p_pwd character varying, INOUT p_result text) OWNER TO postgres;

--
-- Name: auth_user_register(character varying); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_user_register(data character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    dataJson    json := data;
    dto         dto.auth_user_register_dto;
    return_code uuid;
    response    text;
begin
    call utils.check_data(data);
    dto = mapper.to_auth_user_register_dto(dataJson);
    call checks.check_auth_user_register_dto(dto);

    insert into auth.auth_user (username, password, email, phone, language, status, profile_pic)
    values (dto.username, utils.encoding_password(dto.password), dto.email, dto.phone, dto.language, 'NOT_ACTIVE',
            dto.profile_pic)
    returning code into return_code;

    call system.write_log('function auth.auth_user_register(data character varying) returns text');
    response = 'code = ' || return_code;
    return response;
end;
$$;


ALTER FUNCTION auth.auth_user_register(data character varying) OWNER TO postgres;

--
-- Name: auth_user_reset_password(character varying, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_user_reset_password(data character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    dto         dto.auth_user_reset_password_dto;
    dataJson    json := data;
    t_auth_user auth.auth_user;
begin
    call auth.is_active(p_user_id);
    call utils.check_data(data);
    call auth.has_permission('USER_RESET_PASSWORD', p_user_id);
    dto = mapper.to_auth_user_reset_password_dto(dataJson);

    if dto.id is null then
        raise exception 'dto.id param is null';
    end if;

    select * into t_auth_user from auth.auth_user where id = dto.id;

    if not FOUND then
        raise exception 'user not found';
    end if;

    if not utils.matches(dto.old_pwd, t_auth_user.password) then
        raise exception 'old password is incorrect';
    end if;

    if dto.new_pwd <> dto.new_confirm_pwd then
        raise exception 'confirm is incorrect';
    end if;

    update auth.auth_user set password = utils.encoding_password(dto.new_pwd), updated_at = now(), updated_by = p_user_id where id = dto.id;

    call system.write_log('procedure auth.auth_user_reset_password(data character varying, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_user_reset_password(data character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: auth_user_update(text, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_user_update(data text, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json := data;
    dto      dto.auth_user_update_dto;
    up_dto   dto.auth_user_update_dto;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('USER_UPDATE', p_user_id);
    dto = mapper.to_auth_user_update_dto(dataJson);
    up_dto = checks.check_auth_user_update_dto(dto);

    update auth.auth_user
    set username = up_dto.username,
        email    = up_dto.email,
        phone    = up_dto.phone
    where id = up_dto.id;

    call system.write_log('procedure auth.auth_user_update(data text, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.auth_user_update(data text, p_user_id bigint) OWNER TO postgres;

--
-- Name: has_permission(character varying, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.has_permission(p_permission_code character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user       auth.auth_user%rowtype;
    t_auth_permission auth.auth_permission%rowtype;
begin
    select * into t_auth_user from auth.auth_user where not is_deleted and id = p_user_id;
    if not FOUND then
        raise exception 'user not found';
    end if;

    select * into t_auth_permission from auth.auth_permission where not is_deleted and code = p_permission_code;
    if not exists(select *
                  from auth.auth_role_permission
                  where not is_deleted
                    and permission_id = t_auth_permission.id
                    and auth_user_role_id = any (select auth.auth_user_role.id
                                                 from auth.auth_user_role
                                                 where not auth_user_role.is_deleted
                                                   and user_id = p_user_id)) then
        raise exception 'permission denied';
    end if;
end;
$$;


ALTER PROCEDURE auth.has_permission(p_permission_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: is_active(bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.is_active(p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user;
begin
    if p_user_id is null then
        raise exception 'p_user_id param is null';
    end if;

    select * into t_auth_user from auth.auth_user where id = p_user_id;

    if not FOUND then
        raise exception 'user not found';
    end if;

    if t_auth_user.status <> 'ACTIVE' then
        raise exception 'user not active';
    end if;
end;
$$;


ALTER PROCEDURE auth.is_active(p_user_id bigint) OWNER TO postgres;

--
-- Name: user_like_order_create(bigint, bigint, bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.user_like_order_create(t_user_id bigint, p_order_id bigint, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_user    auth.auth_user;
    t_order   "order"."order";
    response  text;
    return_id bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('AUTH_CREATE', p_user_id);

    if t_user_id is null then
        raise exception 't_user_id param is null';
    end if;

    select * into t_user from auth.auth_user where not is_deleted and id = t_user_id;

    if not FOUND then
        raise exception 'user not found';
    end if;

    if p_order_id is null then
        raise exception 'order param is null';
    end if;

    select * into t_order from "order"."order" where not is_deleted and id = p_order_id;

    if not FOUND then
        raise exception 'order not found';
    end if;

    insert into auth.user_like_order (user_id, order_id, created_by)
    values (t_user_id, p_order_id, p_user_id)
    returning id into return_id;

    call system.write_log('function auth.user_like_order_create(t_user_id bigint, p_order_id bigint, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION auth.user_like_order_create(t_user_id bigint, p_order_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: user_like_order_delete(bigint, bigint); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.user_like_order_delete(p_user_like_order_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_user_like_order auth.user_like_order;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_user_like_order_id is null then
        raise exception 'p_user_like_order_id param is null';
    end if;

    select * into t_user_like_order from auth.user_like_order where id = p_user_like_order_id;

    if not FOUND then
        raise exception 'user_like_order not found';
    end if;

    update auth.user_like_order
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_user_like_order_id;

    call system.write_log('procedure auth.auth_user_like_order_delete(p_status_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE auth.user_like_order_delete(p_user_like_order_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: user_like_order_list(bigint); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.user_like_order_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_user_like_order   jsonb;
    v_user_like_order_s jsonb = '[]';
    t_user_like_order   auth.user_like_order%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_user_like_order in (select * from auth.user_like_order where not is_deleted)
        loop
            v_user_like_order = jsonb_build_object('user_id', t_user_like_order.user_id);
            v_user_like_order = v_user_like_order || jsonb_build_object('order_id', t_user_like_order.order_id);
            v_user_like_order = v_user_like_order || jsonb_build_object('created_at', t_user_like_order.created_at);
            v_user_like_order_s = v_user_like_order_s || v_user_like_order;
        end loop;

    call system.write_log('function auth.auth_user_like_order_list(p_user_id bigint) returns text');
    return v_user_like_order_s::text;
end;
$$;


ALTER FUNCTION auth.user_like_order_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: check_auth_user_register_dto(dto.auth_user_register_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_auth_user_register_dto(dto dto.auth_user_register_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user;
begin
    if dto.username is null then
        raise exception 'username is null';
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and username = dto.username;

    if FOUND then
        raise exception 'username already taken choose another username';
    end if;

    if dto.email is null then
        raise exception 'email is null';
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and email = dto.email;

    if FOUND then
        raise exception 'this email used, sorry bro!';
    end if;

    if dto.password is null then
        raise exception 'password is null';
    end if;

    if dto.language is null then
        raise exception 'language is null';
    end if;

    if dto.phone is null then
        raise exception 'phone is null';
    end if;
end;
$$;


ALTER PROCEDURE checks.check_auth_user_register_dto(dto dto.auth_user_register_dto) OWNER TO postgres;

--
-- Name: check_auth_user_update_dto(dto.auth_user_update_dto); Type: FUNCTION; Schema: checks; Owner: postgres
--

CREATE FUNCTION checks.check_auth_user_update_dto(dto dto.auth_user_update_dto) RETURNS dto.auth_user_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user;
    up_dto      dto.auth_user_update_dto;
begin
    if dto.id is null then
        raise exception 'dto.id is null';
    end if;

    select * into t_auth_user from auth.auth_user where id = dto.id;

    if not FOUND then
        raise exception 'user not found';
    end if;

    up_dto.id = dto.id;

    if dto.username is null then
        up_dto.username = t_auth_user.username;
    else
        up_dto.username = dto.username;
    end if;

    if dto.email is null then
        up_dto.email = t_auth_user.email;
    else
        up_dto.email = dto.email;
    end if;

    if dto.phone is null then
        up_dto.phone = t_auth_user.phone;
    else
        up_dto.phone = dto.phone;
    end if;

    return up_dto;
end;
$$;


ALTER FUNCTION checks.check_auth_user_update_dto(dto dto.auth_user_update_dto) OWNER TO postgres;

--
-- Name: check_category_create_dto(dto.category_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_category_create_dto(dto dto.category_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_category "order".category;
begin
    if dto.name is null then
        raise exception 'dto.name param is null';
    end if;

    if dto.code is null then
        raise exception 'dto.code param is null';
    end if;

    select * into t_category from "order".category where code = dto.code;

    if FOUND then
        raise exception 'category code already created';
    end if;
    
    if dto.image_path is null then
        raise exception 'image_path param is null';
    end if;

    if dto.description is null then
        raise exception 'dto.description param is null';
    end if;
end;
$$;


ALTER PROCEDURE checks.check_category_create_dto(dto dto.category_create_dto) OWNER TO postgres;

--
-- Name: check_category_update_dto(dto.category_update_dto); Type: FUNCTION; Schema: checks; Owner: postgres
--

CREATE FUNCTION checks.check_category_update_dto(dto dto.category_update_dto) RETURNS dto.category_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    t_category "order".category;
    up_dto     dto.category_update_dto;
begin
    if dto.id is null then
        raise exception 'dto.id param is null';
    end if;

    select * into t_category from "order".category where not is_deleted and category.id = dto.id;

    if not FOUND then
        raise exception 'category not found';
    end if;

    up_dto.id = dto.id;

    if dto.name is null then
        up_dto.name = t_category.name;
    else
        up_dto.name = dto.name;
    end if;

    if dto.parent_id is null then
        up_dto.parent_id = t_category.parent_id;
    else
        up_dto.parent_id = dto.parent_id;
    end if;

    if dto.code is null then
        up_dto.code = t_category.code;
    else
        up_dto.code = dto.code;
    end if;

    if dto.description is null then
        up_dto.description = t_category.description;
    else
        up_dto.description = dto.description;
    end if;

    return up_dto;
end;
$$;


ALTER FUNCTION checks.check_category_update_dto(dto dto.category_update_dto) OWNER TO postgres;

--
-- Name: check_order_create_dto(dto.order_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_order_create_dto(dto dto.order_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
begin
    if dto.title is null then
        raise exception 'dto.title param is null';
    end if;

    if dto.category_id is null then
        raise exception 'dto.category_id param is null';
    end if;

    if dto.description is null then
        raise exception 'dto.description param is null';
    end if;

    if dto.condition is null then
        raise exception 'dto.condition param is null';
    end if;

    if dto.price is null then
        raise exception 'dto.price param is null';
    end if;

    if dto.location is null then
        raise exception 'dto.location param is null';
    end if;
end;
$$;


ALTER PROCEDURE checks.check_order_create_dto(dto dto.order_create_dto) OWNER TO postgres;

--
-- Name: check_order_update_dto(dto.order_update_dto); Type: FUNCTION; Schema: checks; Owner: postgres
--

CREATE FUNCTION checks.check_order_update_dto(dto dto.order_update_dto) RETURNS dto.order_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    t_order "order"."order";
    up_dto  dto.order_update_dto;
begin
    if dto.id is null then
        raise exception 'dto id is null';
    end if;

    select * into t_order from "order"."order" where id = dto.id;

    if not FOUND then
        raise exception 'order not found';
    end if;

    up_dto.id = dto.id;

    if dto.title is null then
        up_dto.title = t_order.title;
    else
        up_dto.title = dto.title;
    end if;

    if dto.category_id is null then
        up_dto.category_id = t_order.category_id;
    else
        up_dto.category_id = dto.category_id;
    end if;

    if dto.description is null then
        up_dto.description = t_order.description;
    else
        up_dto.description = dto.description;
    end if;

    if dto.condition is null then
        up_dto.condition = t_order.condition;
    else
        up_dto.condition = dto.condition;
    end if;

    if dto.price is null then
        up_dto.price = t_order.price;
    else
        up_dto.price = dto.price;
    end if;

    if dto.location is null then
        up_dto.location = t_order.location;
    else
        up_dto.location = dto.location;
    end if;

    return up_dto;
end;
$$;


ALTER FUNCTION checks.check_order_update_dto(dto dto.order_update_dto) OWNER TO postgres;

--
-- Name: to_auth_user_register_dto(json); Type: FUNCTION; Schema: mapper; Owner: postgres
--

CREATE FUNCTION mapper.to_auth_user_register_dto(data json) RETURNS dto.auth_user_register_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.auth_user_register_dto;
begin
    dto.username = data ->> 'username';
    dto.password = data ->> 'password';
    dto.email = data ->> 'email';
    dto.phone = data ->> 'phone';
    dto.language = data ->> 'language';
    dto.profile_pic = data ->> 'profile_pic';
    return dto;
end;
$$;


ALTER FUNCTION mapper.to_auth_user_register_dto(data json) OWNER TO postgres;

--
-- Name: to_auth_user_reset_password_dto(json); Type: FUNCTION; Schema: mapper; Owner: postgres
--

CREATE FUNCTION mapper.to_auth_user_reset_password_dto(data json) RETURNS dto.auth_user_reset_password_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.auth_user_reset_password_dto;
begin
    dto.id = (data ->> 'user_id')::bigint;
    dto.old_pwd = data ->> 'old_pwd';
    dto.new_pwd = data ->> 'new_pwd';
    dto.new_confirm_pwd = data ->> 'new_confirm_pwd';
    return dto;
end;
$$;


ALTER FUNCTION mapper.to_auth_user_reset_password_dto(data json) OWNER TO postgres;

--
-- Name: to_auth_user_update_dto(json); Type: FUNCTION; Schema: mapper; Owner: postgres
--

CREATE FUNCTION mapper.to_auth_user_update_dto(data json) RETURNS dto.auth_user_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.auth_user_update_dto;
begin
    dto.id = (data ->> 'user_id')::bigint;
    dto.username = data ->> 'username';
    dto.password = data ->> 'password';
    dto.email = data ->> 'email';
    dto.phone = data ->> 'phone';
    dto.language = data ->> 'language';
    dto.profile_pic = data ->> 'profile_pic';
    return dto;
end;
$$;


ALTER FUNCTION mapper.to_auth_user_update_dto(data json) OWNER TO postgres;

--
-- Name: to_category_create_dto(json); Type: FUNCTION; Schema: mapper; Owner: postgres
--

CREATE FUNCTION mapper.to_category_create_dto(data json) RETURNS dto.category_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.category_create_dto;
begin
    dto.parent_id = (data ->> 'parent_id')::bigint;
    dto.image_path = data ->> 'image_path';
    dto.name = data ->> 'name';
    dto.code = data ->> 'code';
    dto.description = data ->> 'description';
    return dto;
end;
$$;


ALTER FUNCTION mapper.to_category_create_dto(data json) OWNER TO postgres;

--
-- Name: to_category_update_dto(json); Type: FUNCTION; Schema: mapper; Owner: postgres
--

CREATE FUNCTION mapper.to_category_update_dto(data json) RETURNS dto.category_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.category_update_dto;
begin
    dto.id = (data ->> 'category_id')::bigint;
    dto.parent_id = (data ->> 'parent_id')::bigint;
    dto.name = data ->> 'name';
    dto.code = data ->> 'code';
    dto.image_path = data ->> 'image_path';
    dto.description = data ->> 'description';
    return dto;
end;
$$;


ALTER FUNCTION mapper.to_category_update_dto(data json) OWNER TO postgres;

--
-- Name: to_order_create_dto(json); Type: FUNCTION; Schema: mapper; Owner: postgres
--

CREATE FUNCTION mapper.to_order_create_dto(data json) RETURNS dto.order_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.order_create_dto;
begin
    dto.category_id = (data ->> 'category_id')::bigint;
    dto.title = data ->> 'title';
    dto.description = data ->> 'description';
    dto.price = data ->> 'price';
    dto.condition = data ->> 'condition';
    dto.location = data ->> 'location';
    dto.image = data ->> 'image';
    return dto;
end;
$$;


ALTER FUNCTION mapper.to_order_create_dto(data json) OWNER TO postgres;

--
-- Name: to_order_update_dto(json); Type: FUNCTION; Schema: mapper; Owner: postgres
--

CREATE FUNCTION mapper.to_order_update_dto(data json) RETURNS dto.order_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.order_update_dto;
begin
    dto.id = (data ->> 'order_id')::bigint;
    dto.category_id = (data ->> 'category_id')::bigint;
    dto.title = data ->> 'title';
    dto.description = data ->> 'description';
    dto.condition = data ->> 'condition';
    dto.price = data ->> 'price';
    dto.location = data ->> 'location';
    return dto;
end;
$$;


ALTER FUNCTION mapper.to_order_update_dto(data json) OWNER TO postgres;

--
-- Name: category_create(character varying, bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".category_create(data character varying, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    dataJson  json := data;
    dto       dto.category_create_dto;
    return_id bigint;
    response  text;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_CREATE', p_user_id);
    dto = mapper.to_category_create_dto(dataJson);
    call checks.check_category_create_dto(dto);

    insert into "order".category (parent_id, name, code, description, created_by)
    values (dto.parent_id, dto.name, dto.code, dto.description, p_user_id)
    returning id into return_id;

    insert into "order".category_image (category_id, image_path, created_by)
    values (return_id, dto.image_path, p_user_id);

    insert into "order".category_rating (category_id, views, created_by) values (return_id, 0, p_user_id);

    call system.write_log('function "order".category_create(data character varying, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION "order".category_create(data character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: category_delete(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".category_delete(p_category_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_category "order".category;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_DELETE', p_user_id);

    if p_category_id is null then
        raise exception 'category_id param is null';
    end if;

    select * into t_category from "order".category where id = p_category_id;

    if not FOUND then
        raise exception 'category not found';
    end if;

    update "order".category set is_deleted = true where id = p_category_id;
    update "order".category_image set is_deleted = true where category_id = p_category_id;
    update "order".category_rating set is_deleted = true where category_id = p_category_id;
    call system.write_log('procedure "order".category_delete(category_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".category_delete(p_category_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: category_image_create(bigint, text, bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".category_image_create(p_category_id bigint, p_image_path text, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_category "order".category;
    response   text;
    return_id  bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_CREATE', p_user_id);

    if p_category_id is null then
        raise exception 'p_category_id param is null';
    end if;

    select * into t_category from "order".category where not is_deleted and id = p_category_id;

    if not FOUND then
        raise exception 'category not found';
    end if;

    if p_image_path is null then
        raise exception 'p_image_path param is null';
    end if;

    insert into "order".category_image (category_id, image_path, created_by)
    values (p_category_id, p_image_path, p_user_id)
    returning id into return_id;

    call system.write_log('function "order".category_image_create(p_category_id bigint, p_image_path text, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION "order".category_image_create(p_category_id bigint, p_image_path text, p_user_id bigint) OWNER TO postgres;

--
-- Name: category_image_delete(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".category_image_delete(p_category_image_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_category_image "order".category_image;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_DELETE', p_user_id);

    if p_category_image_id is null then
        raise exception 'p_category_image_id param is null';
    end if;

    select * into t_category_image from "order".category_image where not is_deleted and id = p_category_image_id;

    if not FOUND then
        raise exception 'category not found';
    end if;

    update "order".category_image
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = p_category_image_id;

    call system.write_log('procedure "order".category_image_delete(p_category_image_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".category_image_delete(p_category_image_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: category_image_list(bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".category_image_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_category_image   jsonb;
    v_category_images jsonb = '[]';
    t_category_image   "order".category_image%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_LIST', p_user_id);

    for t_category_image in (select * from "order".category_image where not is_deleted)
        loop
            v_category_image = jsonb_build_object('category_id', t_category_image.category_id);
            v_category_image = v_category_image || jsonb_build_object('image_path', t_category_image.image_path);
            v_category_image = v_category_image || jsonb_build_object('created_at', t_category_image.created_at);
            v_category_images = v_category_images || v_category_image;
        end loop;

    call system.write_log('function "order".category_image_list(p_user_id bigint) returns text');
    return v_category_images::text;
end;
$$;


ALTER FUNCTION "order".category_image_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: category_image_update(bigint, text, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".category_image_update(p_category_image_id bigint, p_image_path text, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_category_image "order".category_image;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_UPDATE', p_user_id);

    if p_category_image_id is null then
        raise exception 'p_category_image_id param is null';
    end if;

    select * into t_category_image from "order".category_image where not is_deleted and id = p_category_image_id;

    if not FOUND then
        raise exception 'category not found';
    end if;

    update "order".category_image
    set image_path = p_image_path,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = p_category_image_id;

    call system.write_log('procedure "order".category_image_update(p_category_image_id bigint, p_image_path text, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".category_image_update(p_category_image_id bigint, p_image_path text, p_user_id bigint) OWNER TO postgres;

--
-- Name: category_list(bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".category_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_category  jsonb;
    v_categories jsonb = '[]';
    t_category  "order".category%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_LIST', p_user_id);

    for t_category in (select * from "order".category where not is_deleted)
        loop
            v_category = jsonb_build_object('parent_id', t_category.parent_id);
            v_category = v_category || jsonb_build_object('name', t_category.name);
            v_category = v_category || jsonb_build_object('code', t_category.code);
            v_category = v_category || jsonb_build_object('description', t_category.description);
            v_categories = v_categories || v_category;
        end loop;

    call system.write_log('function "order".category_list(p_user_id bigint) returns text');
    return v_categories::text;
end;
$$;


ALTER FUNCTION "order".category_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: category_rating_create(bigint, integer, bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".category_rating_create(p_category_id bigint, p_views integer, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_category "order".category;
    response   text;
    return_id  bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_CREATE', p_user_id);

    if p_category_id is null then
        raise exception 'p_category_id param is null';
    end if;

    select * into t_category from "order".category where not is_deleted and id = p_category_id;

    if not FOUND then
        raise exception 'category not found';
    end if;

    if p_views is null then
        raise exception 'p_views param is null';
    end if;

    insert into "order".category_rating (category_id, views, created_by)
    values (p_category_id, p_views, p_user_id)
    returning id into return_id;

    call system.write_log('function "order".category_image_create(p_category_id bigint, p_image_path text, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION "order".category_rating_create(p_category_id bigint, p_views integer, p_user_id bigint) OWNER TO postgres;

--
-- Name: category_rating_create(bigint, text, bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".category_rating_create(p_category_id bigint, p_views text, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_category "order".category;
    response   text;
    return_id  bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_CREATE', p_user_id);

    if p_category_id is null then
        raise exception 'p_category_id param is null';
    end if;

    select * into t_category from "order".category where not is_deleted and id = p_category_id;

    if not FOUND then
        raise exception 'category not found';
    end if;

    if p_views is null then
        raise exception 'p_views param is null';
    end if;

    insert into "order".category_rating (category_id, views, created_by)
    values (p_category_id, p_views, p_user_id)
    returning id into return_id;

    call system.write_log('function "order".category_image_create(p_category_id bigint, p_image_path text, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION "order".category_rating_create(p_category_id bigint, p_views text, p_user_id bigint) OWNER TO postgres;

--
-- Name: category_rating_delete(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".category_rating_delete(p_category_rating_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_category_rating "order".category_rating;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_DELETE', p_user_id);

    if p_category_rating_id is null then
        raise exception 'p_category_rating_id param is null';
    end if;

    select * into t_category_rating from "order".category_rating where not is_deleted and id = p_category_rating_id;

    if not FOUND then
        raise exception 'category not found';
    end if;

    update "order".category_rating
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = p_category_rating_id;

    call system.write_log('procedure "order".category_image_delete(p_category_rating_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".category_rating_delete(p_category_rating_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: category_rating_list(bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".category_rating_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_category_rating  jsonb;
    v_category_ratings jsonb = '[]';
    t_category_rating  "order".category_rating%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_LIST', p_user_id);

    for t_category_rating in (select * from "order".category_rating where not is_deleted)
        loop
            v_category_rating = jsonb_build_object('category_id', t_category_rating.category_id);
            v_category_rating = v_category_rating || jsonb_build_object('views', t_category_rating.views);
            v_category_rating = v_category_rating || jsonb_build_object('created_at', t_category_rating.created_at);
            v_category_ratings = v_category_ratings || v_category_rating;
        end loop;

    call system.write_log('function "order".category_rating_list(p_user_id bigint) returns text');
    return v_category_ratings::text;
end;
$$;


ALTER FUNCTION "order".category_rating_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: category_rating_update(bigint, integer, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".category_rating_update(p_category_rating_id bigint, p_view integer, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_category_rating "order".category_rating;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_UPDATE', p_user_id);

    if p_category_rating_id is null then
        raise exception 'p_category_rating_id param is null';
    end if;

    select * into t_category_rating from "order".category_rating where not is_deleted and id = p_category_rating_id;

    if not FOUND then
        raise exception 'category_rating not found';
    end if;

    update "order".category_rating
    set views      = p_view,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = p_category_rating_id;

    call system.write_log('procedure "order".category_rating_update(p_category_rating_id bigint, p_view text, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".category_rating_update(p_category_rating_id bigint, p_view integer, p_user_id bigint) OWNER TO postgres;

--
-- Name: category_update(character varying, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".category_update(data character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json := data;
    dto      dto.category_update_dto;
    up_dto   dto.category_update_dto;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CATEGORY_UPDATE', p_user_id);
    dto = mapper.to_category_update_dto(dataJson);
    up_dto = checks.check_category_update_dto(dto);

    update "order".category
    set parent_id   = up_dto.parent_id,
        name        = up_dto.name,
        code        = up_dto.code,
        description = up_dto.description
    where id = up_dto.id;

    call system.write_log('procedure "order".category_update(data character varying, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".category_update(data character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_comment_create(bigint, text, bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_comment_create(p_order_id bigint, p_comment text, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_order   "order"."order";
    response  text;
    return_id bigint;
begin
    call auth.is_active(p_user_id);

    if p_order_id is null then
        raise exception 'p_order_id param is null';
    end if;

    select * into t_order from "order"."order" where id = p_order_id;

    if not FOUND then
        raise exception 'order nt found';
    end if;

    if p_comment is null then
        raise exception 'p_comment param is null';
    end if;

    insert into "order".order_comment (order_id, user_id, comment, created_by)
    values (p_order_id, p_user_id, p_comment, p_user_id)
    returning id into return_id;

    call system.write_log('function "order".order_comment_create(p_order_id bigint, p_comment text, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION "order".order_comment_create(p_order_id bigint, p_comment text, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_comment_delete(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_comment_delete(p_comment_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_comment "order".order_comment;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_comment_id is null then
        raise exception 'p_comment_id param is null';
    end if;

    select * into t_comment from "order".order_comment where id = p_comment_id;

    if not FOUND then
        raise exception 'comment not found';
    end if;

    update "order".order_comment
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = p_comment_id;

    call system.write_log('procedure "order".order_comment_delete(p_comment_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_comment_delete(p_comment_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_comment_list(bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_comment_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_order_comment  jsonb;
    v_order_comments jsonb = '[]';
    t_order_comment  "order".order_comment%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_order_comment in (select * from "order".order_comment where not is_deleted)
        loop
            v_order_comment = jsonb_build_object('order_id', t_order_comment.order_id);
            v_order_comment = v_order_comment || jsonb_build_object('comment', t_order_comment.comment);
            v_order_comment = v_order_comment || jsonb_build_object('created_at', t_order_comment.created_at);
            v_order_comments = v_order_comments || v_order_comment;
        end loop;

    call system.write_log('function "order".order_comment_list(p_user_id bigint) returns text');
    return v_order_comments::text;
end;
$$;


ALTER FUNCTION "order".order_comment_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: order_condition_create(character varying, character varying, bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_condition_create(p_name character varying, p_code character varying, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_order_condition "order".order_condition;
    response          text;
    return_id         bigint;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_CREATE', p_user_id);

    if p_code is null then
        raise exception 'p_code param is null';
    end if;

    select * into t_order_condition from "order".order_condition where not is_deleted and code = p_code;

    if FOUND then
        raise exception 'order_condition found';
    end if;

    if p_name is null then
        raise exception 'p_name param is null';
    end if;

    insert into "order".order_condition (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into return_id;

    call system.write_log('function "order".order_condition_create(p_name varchar, p_code varchar, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION "order".order_condition_create(p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_condition_delete(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_condition_delete(p_condition_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_condition "order".order_condition;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);

    if p_condition_id is null then
        raise exception 'p_condition param is null';
    end if;

    select * into t_condition from "order".order_condition where id = p_condition_id;

    if not FOUND then
        raise exception 'condition not found';
    end if;

    update "order".order_condition
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = p_condition_id;

    call system.write_log('procedure "order".order_condition_delete(p_condition_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_condition_delete(p_condition_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_condition_list(bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_condition_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_order_condition  jsonb;
    v_order_conditions jsonb = '[]';
    t_order_condition  "order".order_condition%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_order_condition in (select * from "order".order_condition where not is_deleted)
        loop
            v_order_condition = jsonb_build_object('name', t_order_condition.name);
            v_order_condition = v_order_condition || jsonb_build_object('code', t_order_condition.code);
            v_order_condition = v_order_condition || jsonb_build_object('created_at', t_order_condition.created_at);
            v_order_conditions = v_order_conditions || v_order_condition;
        end loop;

    call system.write_log('function "order".order_comment_list(p_user_id bigint) returns text');
    return v_order_conditions::text;
end;
$$;


ALTER FUNCTION "order".order_condition_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: order_condition_update(bigint, character varying, character varying, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_condition_update(p_condition_id bigint, p_name character varying, p_code character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_condition "order".order_condition;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_UPDATE', p_user_id);

    if p_condition_id is null then
        raise exception 'p_condition is null';
    end if;

    select * into t_condition from "order".order_condition where id = p_condition_id;

    if not FOUND then
        raise exception 'condition not found';
    end if;

    if p_name = ''::varchar then
        p_name = t_condition.name;
    end if;

    if p_code = ''::varchar then
        p_code = t_condition.code;
    end if;

    update "order".order_condition
    set name       = p_name,
        code       = p_code,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_condition_id;

    call system.write_log('procedure "order".order_condition_update(p_condition_id bigint, p_name varchar, p_code varchar,
                                                p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_condition_update(p_condition_id bigint, p_name character varying, p_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_create(character varying, bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_create(data character varying, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    dataJson  json := data;
    dto       dto.order_create_dto;
    return_id bigint;
    response  text;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_CREATE', p_user_id);
    dto = mapper.to_order_create_dto(dataJson);
    call checks.check_order_create_dto(dto);

    insert into "order"."order" (category_id, title, description, condition, price, location, created_by)
    values (dto.category_id, dto.title, dto.description, dto.condition, dto.price, dto.location, p_user_id)
    returning id into return_id;

    if not dto.image is null then
        insert into "order".order_image (order_id, image_path, created_by) values (return_id, dto.image, p_user_id);
    end if;

    insert into "order".order_view (order_id, view_count, created_by) values (return_id, 0, p_user_id);

    call system.write_log('function "order".order_create(data character varying, p_user_id bigint)');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION "order".order_create(data character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_delete(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_delete(p_order_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_order "order".order;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);

    if p_order_id is null then
        raise exception 'p_order_id param is null';
    end if;

    select * into t_order from "order".order where not is_deleted and id = p_order_id;

    if not FOUND then
        raise exception 'order not found';
    end if;

    update "order".order set is_deleted = true where not is_deleted and id = p_order_id;
    call system.write_log('procedure "order".order_delete(p_order_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_delete(p_order_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_image_create(bigint, text, bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_image_create(p_order_id bigint, p_image_path text, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_order   "order"."order";
    response  text;
    return_id bigint;
begin
    call auth.is_active(p_user_id);

    if p_order_id is null then
        raise exception 'p_order_id param is null';
    end if;

    select * into t_order from "order"."order" where id = p_order_id;

    if not FOUND then
        raise exception 'order nt found';
    end if;

    if p_image_path is null then
        raise exception 'p_image_path param is null';
    end if;

    insert into "order".order_image (order_id, image_path, created_by)
    values (p_order_id, p_image_path, p_user_id)
    returning id into return_id;

    call system.write_log('function "order".order_image_create(p_order_id bigint, p_image_path text, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION "order".order_image_create(p_order_id bigint, p_image_path text, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_image_delete(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_image_delete(p_image_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_image "order".order_image;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_image_id is null then
        raise exception 'p_image_id param is null';
    end if;

    select * into t_image from "order".order_image where id = p_image_id;

    if not FOUND then
        raise exception 'image not found';
    end if;

    update "order".order_image
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = p_image_id;

    call system.write_log('procedure "order".order_image_delete(p_image_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_image_delete(p_image_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_image_list(bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_image_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_order_image  jsonb;
    v_order_images jsonb = '[]';
    t_order_image  "order".order_image%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_order_image in (select * from "order".order_image where not is_deleted)
        loop
            v_order_image = jsonb_build_object('order_id', t_order_image.order_id);
            v_order_image = v_order_image || jsonb_build_object('image_path', t_order_image.image_path);
            v_order_image = v_order_image || jsonb_build_object('created_at', t_order_image.created_at);
            v_order_images = v_order_images || v_order_image;
        end loop;

    call system.write_log('function "order".order_comment_list(p_user_id bigint) returns text');
    return v_order_images::text;
end;
$$;


ALTER FUNCTION "order".order_image_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: order_image_update(bigint, text, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_image_update(p_image_id bigint, p_image_path text, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_image "order".order_image;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_UPDATE', p_user_id);

    if p_image_id is null then
        raise exception 'p_image is null';
    end if;

    select * into t_image from "order".order_image where id = p_image_id;

    if not FOUND then
        raise exception 'image not found';
    end if;

    if p_image_path is null then
        raise exception 'image path param is null';
    end if;

    update "order".order_image
    set image_path = p_image_path,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_image_id;

    call system.write_log('procedure "order".order_image_update(p_image_id bigint, p_image_path text, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_image_update(p_image_id bigint, p_image_path text, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_is_published(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_is_published(p_order_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_view "order"."order";
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_UPDATE', p_user_id);

    if p_order_id is null then
        raise exception 'p_order_id is null';
    end if;

    select * into t_view from "order"."order" where not is_deleted and not is_published and id = p_order_id;

    if not FOUND then
        raise exception 'order not found';
    end if;

    update "order"."order"
    set is_published = true,
        updated_at   = now(),
        updated_by   = p_user_id
    where id = p_order_id;

    call system.write_log('procedure "order".order_is_published(p_order_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_is_published(p_order_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_list(bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_order  jsonb;
    v_orders jsonb = '[]';
    t_order  "order"."order"%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_order in (select * from "order"."order" where not is_deleted)
        loop
            v_order = jsonb_build_object('category_id', t_order.category_id);
            v_order = v_order || jsonb_build_object('title', t_order.title);
            v_order = v_order || jsonb_build_object('description', t_order.description);
            v_order = v_order || jsonb_build_object('price', t_order.price);
            v_order = v_order || jsonb_build_object('location', t_order.location);
            v_orders = v_orders || v_order;
        end loop;

    call system.write_log(' function "order".order_list(p_user_id bigint) returns text');
    return v_orders::text;
end;
$$;


ALTER FUNCTION "order".order_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: order_not_is_published(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_not_is_published(p_order_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_view "order"."order";
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_UPDATE', p_user_id);

    if p_order_id is null then
        raise exception 'p_order_id is null';
    end if;

    select * into t_view from "order"."order" where not is_deleted and is_published and id = p_order_id;

    if not FOUND then
        raise exception 'order not found';
    end if;

    update "order"."order"
    set is_published = false,
        updated_at   = now(),
        updated_by   = p_user_id
    where id = p_order_id;

    call system.write_log('procedure "order".order_not_is_published(p_order_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_not_is_published(p_order_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_price_update(bigint, character varying, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_price_update(p_order_id bigint, p_price character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_view "order"."order";
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_UPDATE', p_user_id);

    if p_order_id is null then
        raise exception 'p_order_id is null';
    end if;

    select * into t_view from "order"."order" where not is_deleted and id = p_order_id;

    if not FOUND then
        raise exception 'order not found';
    end if;

    update "order"."order"
    set price = p_price,
        updated_at   = now(),
        updated_by   = p_user_id
    where id = p_order_id;

    call system.write_log('procedure "order".order_price_update(p_order_id bigint, p_price varchar, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_price_update(p_order_id bigint, p_price character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_update(character varying, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_update(data character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json := data;
    dto      dto.order_update_dto;
    up_dto   dto.order_update_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_UPDATE', p_user_id);
    dto = mapper.to_order_update_dto(dataJson);
    up_dto = checks.check_order_update_dto(dto);

    update "order"."order"
    set title       = up_dto.title,
        category_id = up_dto.category_id,
        description = up_dto.description,
        condition   = up_dto.condition,
        price       = up_dto.price,
        location    = up_dto.location,
        updated_at  = now(),
        updated_by  = p_user_id
    where not is_deleted
      and id = up_dto.id;

    call system.write_log('procedure "order".order_update(data character varying, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_update(data character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_view_create(bigint, integer, bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_view_create(p_order_id bigint, p_view integer, p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    t_order   "order"."order";
    response  text;
    return_id bigint;
begin
    call auth.is_active(p_user_id);

    if p_order_id is null then
        raise exception 'p_order_id param is null';
    end if;

    select * into t_order from "order"."order" where id = p_order_id;

    if not FOUND then
        raise exception 'order nt found';
    end if;

    if p_view is null then
        raise exception 'p_view_path param is null';
    end if;

    insert into "order".order_view (order_id, view_count, created_by)
    values (p_order_id, p_view, p_user_id)
    returning id into return_id;

    call system.write_log('function "order".order_view_create(p_order_id bigint, p_view integer, p_user_id bigint) returns text');
    response = 'id = ' || return_id;
    return response;
end;
$$;


ALTER FUNCTION "order".order_view_create(p_order_id bigint, p_view integer, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_view_delete(bigint, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_view_delete(p_view_id bigint, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_view "order".order_view;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_DELETE', p_user_id);
    if p_view_id is null then
        raise exception 'p_view_id param is null';
    end if;

    select * into t_view from "order".order_view where id = p_view_id;

    if not FOUND then
        raise exception 'view not found';
    end if;

    update "order".order_view
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = p_view_id;

    call system.write_log('procedure "order".order_view_delete(p_view_id bigint, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_view_delete(p_view_id bigint, p_user_id bigint) OWNER TO postgres;

--
-- Name: order_view_list(bigint); Type: FUNCTION; Schema: order; Owner: postgres
--

CREATE FUNCTION "order".order_view_list(p_user_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_order_view  jsonb;
    v_order_views jsonb = '[]';
    t_order_view  "order".order_view%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_LIST', p_user_id);

    for t_order_view in (select * from "order".order_view where not is_deleted)
        loop
            v_order_view = jsonb_build_object('order_id', t_order_view.order_id);
            v_order_view = v_order_view || jsonb_build_object('view_count', t_order_view.view_count);
            v_order_view = v_order_view || jsonb_build_object('created_at', t_order_view.created_at);
            v_order_views = v_order_views || v_order_view;
        end loop;

    call system.write_log('function "order".order_comment_list(p_user_id bigint) returns text');
    return v_order_views::text;
end;
$$;


ALTER FUNCTION "order".order_view_list(p_user_id bigint) OWNER TO postgres;

--
-- Name: order_view_update(bigint, integer, bigint); Type: PROCEDURE; Schema: order; Owner: postgres
--

CREATE PROCEDURE "order".order_view_update(p_view_id bigint, p_view integer, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_view "order".order_view;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('ORDER_UPDATE', p_user_id);

    if p_view_id is null then
        raise exception 'p_view is null';
    end if;

    select * into t_view from "order".order_view where id = p_view_id;

    if not FOUND then
        raise exception 'view not found';
    end if;

    if p_view is null then
        raise exception 'view path param is null';
    end if;

    update "order".order_view
    set view_count = p_view,
        updated_at = now(),
        updated_by = p_user_id
    where id = p_view_id;

    call system.write_log('procedure "order".order_view_update(p_view_id bigint, p_view integer, p_user_id bigint)');
end;
$$;


ALTER PROCEDURE "order".order_view_update(p_view_id bigint, p_view integer, p_user_id bigint) OWNER TO postgres;

--
-- Name: encoding_password(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.encoding_password(password character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
begin
    return buildIns.crypt(password, buildIns.gen_salt('bf', 4));
end;
$$;


ALTER FUNCTION public.encoding_password(password character varying) OWNER TO postgres;

--
-- Name: has_permission(character varying, bigint); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.has_permission(p_permission_code character varying, p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user       auth.auth_user%rowtype;
    t_auth_permission auth.auth_permission%rowtype;
begin
    select * into t_auth_user from auth.auth_user where not is_deleted and id = p_user_id;
    if not FOUND then
        raise exception 'user not found';
    end if;

    select * into t_auth_permission from auth.auth_permission where not is_deleted and code = p_permission_code;
    if not exists(select *
                  from auth.auth_role_permission
                  where not is_deleted
                    and permission_id = t_auth_permission.id
                    and auth_user_role_id = any (select auth.auth_user_role.id
                                                 from auth.auth_user_role
                                                 where not auth_user_role.is_deleted
                                                   and user_id = p_user_id)) then
        raise exception 'permission denied';
    end if;
end;
$$;


ALTER PROCEDURE public.has_permission(p_permission_code character varying, p_user_id bigint) OWNER TO postgres;

--
-- Name: is_active(bigint); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.is_active(p_user_id bigint)
    LANGUAGE plpgsql
    AS $$
declare
    t_auth_user auth.auth_user;
begin
    if p_user_id is null then
        raise exception 'p_user_id param is null';
    end if;

    select * into t_auth_user from auth.auth_user where id = p_user_id;

    if not FOUND then
        raise exception 'user not found';
    end if;

    if t_auth_user.status <> 'ACTIVE' then
        raise exception 'user not active';
    end if;
end;
$$;


ALTER PROCEDURE public.is_active(p_user_id bigint) OWNER TO postgres;

--
-- Name: write_log(text); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.write_log(message text)
    LANGUAGE plpgsql
    AS $$
begin
    if message is null then
        raise exception 'message param is null';
    end if;

    insert into system.log (body) values (message);
end;
$$;


ALTER PROCEDURE system.write_log(message text) OWNER TO postgres;

--
-- Name: check_data(text); Type: PROCEDURE; Schema: utils; Owner: postgres
--

CREATE PROCEDURE utils.check_data(data text)
    LANGUAGE plpgsql
    AS $$
begin
    if data is null or '{}'::text = data or '' = data then
        raise exception 'invalid data';
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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_block; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_block (
    id bigint NOT NULL,
    user_id bigint,
    duration timestamp without time zone,
    blocked_for character varying,
    blocked_at character varying,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_block OWNER TO postgres;

--
-- Name: auth_block_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_block_id_seq
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
-- Name: auth_language; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.auth_language (
    id bigint NOT NULL,
    name character varying,
    code character varying(2),
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_language OWNER TO postgres;

--
-- Name: auth_language_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_language_id_seq
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
    id bigint NOT NULL,
    name character varying,
    code character varying(30),
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_permission_id_seq
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
    id bigint NOT NULL,
    name character varying,
    code character varying(30),
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_role OWNER TO postgres;

--
-- Name: auth_role_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_role_id_seq
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
    id bigint NOT NULL,
    auth_user_role_id bigint,
    permission_id bigint,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_role_permission OWNER TO postgres;

--
-- Name: auth_role_permission_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_role_permission_id_seq
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
    id bigint NOT NULL,
    token_id bigint,
    user_code uuid,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_session OWNER TO postgres;

--
-- Name: auth_session_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_session_id_seq
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
    id bigint NOT NULL,
    name character varying,
    code character varying(30),
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_status OWNER TO postgres;

--
-- Name: auth_status_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_status_id_seq
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
    id bigint NOT NULL,
    user_id bigint,
    token text DEFAULT buildins.gen_random_uuid(),
    duration timestamp without time zone DEFAULT (now() + '00:30:00'::interval),
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_token OWNER TO postgres;

--
-- Name: auth_token_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_token_id_seq
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
    id bigint NOT NULL,
    code uuid DEFAULT buildins.gen_random_uuid(),
    username character varying,
    password character varying,
    email character varying,
    phone character varying(13),
    language character varying(2),
    last_login_at timestamp with time zone,
    status character varying,
    profile_pic text,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint DEFAULT '-1'::integer,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_user OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_user_id_seq
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
    id bigint NOT NULL,
    user_id bigint,
    role_id bigint,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.auth_user_role OWNER TO postgres;

--
-- Name: auth_user_role_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.auth_user_role_id_seq
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
-- Name: user_like_order; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth.user_like_order (
    id bigint NOT NULL,
    user_id bigint,
    order_id bigint,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE auth.user_like_order OWNER TO postgres;

--
-- Name: user_like_order_id_seq; Type: SEQUENCE; Schema: auth; Owner: postgres
--

CREATE SEQUENCE auth.user_like_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.user_like_order_id_seq OWNER TO postgres;

--
-- Name: user_like_order_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: postgres
--

ALTER SEQUENCE auth.user_like_order_id_seq OWNED BY auth.user_like_order.id;


--
-- Name: category; Type: TABLE; Schema: order; Owner: postgres
--

CREATE TABLE "order".category (
    id bigint NOT NULL,
    parent_id bigint,
    name character varying,
    code character varying,
    description text,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE "order".category OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: order; Owner: postgres
--

CREATE SEQUENCE "order".category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "order".category_id_seq OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: postgres
--

ALTER SEQUENCE "order".category_id_seq OWNED BY "order".category.id;


--
-- Name: category_image; Type: TABLE; Schema: order; Owner: postgres
--

CREATE TABLE "order".category_image (
    id bigint NOT NULL,
    category_id bigint,
    image_path text,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE "order".category_image OWNER TO postgres;

--
-- Name: category_image_id_seq; Type: SEQUENCE; Schema: order; Owner: postgres
--

CREATE SEQUENCE "order".category_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "order".category_image_id_seq OWNER TO postgres;

--
-- Name: category_image_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: postgres
--

ALTER SEQUENCE "order".category_image_id_seq OWNED BY "order".category_image.id;


--
-- Name: category_rating; Type: TABLE; Schema: order; Owner: postgres
--

CREATE TABLE "order".category_rating (
    id bigint NOT NULL,
    category_id bigint,
    views integer,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE "order".category_rating OWNER TO postgres;

--
-- Name: category_rating_id_seq; Type: SEQUENCE; Schema: order; Owner: postgres
--

CREATE SEQUENCE "order".category_rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "order".category_rating_id_seq OWNER TO postgres;

--
-- Name: category_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: postgres
--

ALTER SEQUENCE "order".category_rating_id_seq OWNED BY "order".category_rating.id;


--
-- Name: order; Type: TABLE; Schema: order; Owner: postgres
--

CREATE TABLE "order"."order" (
    id bigint NOT NULL,
    category_id bigint,
    title character varying,
    description text,
    condition character varying,
    price character varying,
    location character varying,
    is_published boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE "order"."order" OWNER TO postgres;

--
-- Name: order_comment; Type: TABLE; Schema: order; Owner: postgres
--

CREATE TABLE "order".order_comment (
    id bigint NOT NULL,
    order_id bigint,
    user_id bigint,
    comment text,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE "order".order_comment OWNER TO postgres;

--
-- Name: order_comment_id_seq; Type: SEQUENCE; Schema: order; Owner: postgres
--

CREATE SEQUENCE "order".order_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "order".order_comment_id_seq OWNER TO postgres;

--
-- Name: order_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: postgres
--

ALTER SEQUENCE "order".order_comment_id_seq OWNED BY "order".order_comment.id;


--
-- Name: order_condition; Type: TABLE; Schema: order; Owner: postgres
--

CREATE TABLE "order".order_condition (
    id bigint NOT NULL,
    name character varying,
    code character varying,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE "order".order_condition OWNER TO postgres;

--
-- Name: order_condition_id_seq; Type: SEQUENCE; Schema: order; Owner: postgres
--

CREATE SEQUENCE "order".order_condition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "order".order_condition_id_seq OWNER TO postgres;

--
-- Name: order_condition_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: postgres
--

ALTER SEQUENCE "order".order_condition_id_seq OWNED BY "order".order_condition.id;


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: order; Owner: postgres
--

CREATE SEQUENCE "order".order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "order".order_id_seq OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: postgres
--

ALTER SEQUENCE "order".order_id_seq OWNED BY "order"."order".id;


--
-- Name: order_image; Type: TABLE; Schema: order; Owner: postgres
--

CREATE TABLE "order".order_image (
    id bigint NOT NULL,
    order_id bigint,
    image_path text,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE "order".order_image OWNER TO postgres;

--
-- Name: order_image_id_seq; Type: SEQUENCE; Schema: order; Owner: postgres
--

CREATE SEQUENCE "order".order_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "order".order_image_id_seq OWNER TO postgres;

--
-- Name: order_image_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: postgres
--

ALTER SEQUENCE "order".order_image_id_seq OWNED BY "order".order_image.id;


--
-- Name: order_view; Type: TABLE; Schema: order; Owner: postgres
--

CREATE TABLE "order".order_view (
    id bigint NOT NULL,
    order_id bigint,
    view_count integer,
    is_deleted boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_at timestamp with time zone,
    updated_by bigint
);


ALTER TABLE "order".order_view OWNER TO postgres;

--
-- Name: order_view_id_seq; Type: SEQUENCE; Schema: order; Owner: postgres
--

CREATE SEQUENCE "order".order_view_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "order".order_view_id_seq OWNER TO postgres;

--
-- Name: order_view_id_seq; Type: SEQUENCE OWNED BY; Schema: order; Owner: postgres
--

ALTER SEQUENCE "order".order_view_id_seq OWNED BY "order".order_view.id;


--
-- Name: log; Type: TABLE; Schema: system; Owner: postgres
--

CREATE TABLE system.log (
    id bigint NOT NULL,
    body text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE system.log OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: system; Owner: postgres
--

CREATE SEQUENCE system.log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE system.log_id_seq OWNER TO postgres;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: system; Owner: postgres
--

ALTER SEQUENCE system.log_id_seq OWNED BY system.log.id;


--
-- Name: auth_block id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_block ALTER COLUMN id SET DEFAULT nextval('auth.auth_block_id_seq'::regclass);


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
-- Name: user_like_order id; Type: DEFAULT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.user_like_order ALTER COLUMN id SET DEFAULT nextval('auth.user_like_order_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".category ALTER COLUMN id SET DEFAULT nextval('"order".category_id_seq'::regclass);


--
-- Name: category_image id; Type: DEFAULT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".category_image ALTER COLUMN id SET DEFAULT nextval('"order".category_image_id_seq'::regclass);


--
-- Name: category_rating id; Type: DEFAULT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".category_rating ALTER COLUMN id SET DEFAULT nextval('"order".category_rating_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order"."order" ALTER COLUMN id SET DEFAULT nextval('"order".order_id_seq'::regclass);


--
-- Name: order_comment id; Type: DEFAULT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".order_comment ALTER COLUMN id SET DEFAULT nextval('"order".order_comment_id_seq'::regclass);


--
-- Name: order_condition id; Type: DEFAULT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".order_condition ALTER COLUMN id SET DEFAULT nextval('"order".order_condition_id_seq'::regclass);


--
-- Name: order_image id; Type: DEFAULT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".order_image ALTER COLUMN id SET DEFAULT nextval('"order".order_image_id_seq'::regclass);


--
-- Name: order_view id; Type: DEFAULT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".order_view ALTER COLUMN id SET DEFAULT nextval('"order".order_view_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.log ALTER COLUMN id SET DEFAULT nextval('system.log_id_seq'::regclass);


--
-- Data for Name: auth_block; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_block (id, user_id, duration, blocked_for, blocked_at, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: auth_language; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_language (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	English	EN	f	2022-01-22 11:30:15.728019+05	\N	\N	\N
2	Russia	RU	f	2022-01-22 20:20:17.759569+05	\N	\N	\N
3	Uzbek	UZ	f	2022-01-22 20:20:26.156017+05	\N	2022-01-23 14:57:09.7703+05	2
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_permission (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	user delete	USER_DELETE	f	2022-01-22 12:04:54.318259+05	\N	\N	\N
2	user create	USER_CREATE	f	2022-01-22 12:04:54.318259+05	\N	\N	\N
3	user list	USER_LIST	f	2022-01-22 12:04:54.318259+05	\N	\N	\N
4	user update	USER_UPDATE	f	2022-01-22 12:04:54.318259+05	\N	\N	\N
5	user language change	USER_CHANGE_LANG	f	2022-01-22 14:40:24.081975+05	\N	\N	\N
6	user reset password	USER_RESET_PASSWORD	f	2022-01-22 14:40:24.081975+05	\N	\N	\N
7	category create	CATEGORY_CREATE	f	2022-01-22 21:49:22.850206+05	\N	\N	\N
8	category delete	CATEGORY_DELETE	f	2022-01-22 21:49:22.850206+05	\N	\N	\N
9	category update	CATEGORY_UPDATE	f	2022-01-22 21:49:22.850206+05	\N	\N	\N
10	category list	CATEGORY_LIST	f	2022-01-22 21:49:22.850206+05	\N	\N	\N
11	category block	CATEGORY_BLOCK	f	2022-01-22 21:49:22.850206+05	\N	\N	\N
12	order create	ORDER_CREATE	f	2022-01-23 10:33:25.137402+05	\N	\N	\N
13	order delete	ORDER_DELETE	f	2022-01-23 10:33:25.137402+05	\N	\N	\N
14	order update	ORDER_UPDATE	f	2022-01-23 10:33:25.137402+05	\N	\N	\N
15	order list	ORDER_LIST	f	2022-01-23 10:33:25.137402+05	\N	\N	\N
16	all auth create	AUTH_CREATE	f	2022-01-23 14:38:32.49158+05	\N	\N	\N
17	all auth delete	AUTH_DELETE	f	2022-01-23 14:38:32.49158+05	\N	\N	\N
18	all auth update	AUTH_UPDATE	f	2022-01-23 14:38:32.49158+05	\N	\N	\N
19	all auth list	AUTH_LIST	f	2022-01-23 14:38:32.49158+05	\N	\N	\N
\.


--
-- Data for Name: auth_role; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_role (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
2	Manager	HR	f	2022-01-22 12:03:54.319754+05	\N	\N	\N
3	SuperAdmin	SUPER	f	2022-01-22 12:03:54.319754+05	\N	\N	\N
1	Admin	ADMIN	f	2022-01-22 12:03:54.319754+05	\N	2022-01-23 15:08:14.451153+05	2
\.


--
-- Data for Name: auth_role_permission; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_role_permission (id, auth_user_role_id, permission_id, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	1	1	f	2022-01-22 12:07:52.035096+05	\N	\N	\N
2	1	2	f	2022-01-22 12:07:52.035096+05	\N	\N	\N
3	1	3	f	2022-01-22 12:07:52.035096+05	\N	\N	\N
4	1	4	f	2022-01-22 12:07:52.035096+05	\N	\N	\N
5	1	5	f	2022-01-22 14:43:00.769887+05	\N	\N	\N
6	1	6	f	2022-01-22 14:43:00.769887+05	\N	\N	\N
7	1	7	f	2022-01-22 21:50:04.462969+05	\N	\N	\N
8	1	8	f	2022-01-22 21:50:04.462969+05	\N	\N	\N
9	1	9	f	2022-01-22 21:50:04.462969+05	\N	\N	\N
10	1	10	f	2022-01-22 21:50:04.462969+05	\N	\N	\N
11	1	11	f	2022-01-22 21:50:04.462969+05	\N	\N	\N
12	1	12	f	2022-01-23 10:33:51.416785+05	\N	\N	\N
13	1	13	f	2022-01-23 10:33:51.416785+05	\N	\N	\N
14	1	14	f	2022-01-23 10:33:51.416785+05	\N	\N	\N
15	1	15	f	2022-01-23 10:33:51.416785+05	\N	\N	\N
16	1	16	f	2022-01-23 14:38:50.683892+05	\N	\N	\N
17	1	17	f	2022-01-23 14:38:50.683892+05	\N	\N	\N
18	1	18	f	2022-01-23 14:38:50.683892+05	\N	\N	\N
19	1	19	f	2022-01-23 14:38:50.683892+05	\N	2022-01-23 15:18:49.863728+05	2
\.


--
-- Data for Name: auth_session; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_session (id, token_id, user_code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	1	490b5ae8-d3c0-474c-82f5-3ab730c7ea01	f	2022-01-22 11:52:39.788923+05	2	\N	\N
2	2	490b5ae8-d3c0-474c-82f5-3ab730c7ea01	f	2022-01-22 21:31:24.180897+05	2	\N	\N
3	3	8a2a20b6-6083-4a65-bea4-c0a1b511d757	f	2022-01-22 21:32:50.134777+05	4	\N	\N
\.


--
-- Data for Name: auth_status; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_status (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	not active	NOT_ACTIVE	f	2022-01-22 11:33:16.392775+05	\N	\N	\N
2	active	ACTIVE	f	2022-01-22 11:52:21.402745+05	\N	\N	\N
3	Bob	BOBO	f	2022-01-23 14:42:41.949216+05	2	2022-01-23 14:50:59.914661+05	2
\.


--
-- Data for Name: auth_token; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_token (id, user_id, token, duration, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	2	b8d014e5-4c32-4eb1-8191-4aed99d4245d	2022-01-22 07:22:39.788923	f	2022-01-22 11:52:39.788923+05	\N	\N	\N
2	2	6261d856-bb71-47e5-a39e-d73fd71b61aa	2022-01-22 17:01:24.180897	f	2022-01-22 21:31:24.180897+05	\N	\N	\N
3	4	db6869e7-4eb6-4da7-ab82-680752fbc8db	2022-01-22 17:02:50.134777	f	2022-01-22 21:32:50.134777+05	\N	\N	\N
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_user (id, code, username, password, email, phone, language, last_login_at, status, profile_pic, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
2	490b5ae8-d3c0-474c-82f5-3ab730c7ea01	bob	$2a$04$IDap4Q7TSf8vLOC7hTH9TOWbB7GuTrM8i6SV.YQNsyzXarYvNfRSG	bob@gmail.com	+68667776291	EN	\N	ACTIVE	\N	f	2022-01-22 11:36:50.656143+05	-1	\N	\N
3	e0142a7a-2f6d-46d3-b2db-4c7a4b3db980	lol	$2a$04$Cslkp5Yksadi.CPKELxQUeEmXcFac6E.x.bJ/QjU.Z7V.LHQ0kaWC	heklklllo@gmail.com	+564576674	RU	\N	NOT_ACTIVE	\N	f	2022-01-22 12:28:31.684511+05	-1	2022-01-22 20:20:34.52786+05	2
4	8a2a20b6-6083-4a65-bea4-c0a1b511d757	bobby	$2a$04$kAI1oAF2ZnAIrvKj683XkeATaEQFZGbGq61sCEZIheSdcuvGnoRJW	bopob@gmail.com	+68667776291	EN	\N	ACTIVE	\N	f	2022-01-22 21:31:49.952553+05	-1	\N	\N
\.


--
-- Data for Name: auth_user_role; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_user_role (id, user_id, role_id, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	2	3	f	2022-01-22 12:07:23.348079+05	\N	\N	\N
\.


--
-- Data for Name: user_like_order; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.user_like_order (id, user_id, order_id, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	2	2	f	2022-01-23 15:35:41.339082+05	2	2022-01-23 15:37:52.713039+05	2
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: order; Owner: postgres
--

COPY "order".category (id, parent_id, name, code, description, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	\N	PDP	ACCESS	this message	f	2022-01-22 22:04:20.75241+05	2	\N	\N
\.


--
-- Data for Name: category_image; Type: TABLE DATA; Schema: order; Owner: postgres
--

COPY "order".category_image (id, category_id, image_path, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
2	1	lol.png	f	2022-01-23 09:18:25.02754+05	2	\N	\N
1	1	hi.png	f	2022-01-22 22:04:20.75241+05	2	2022-01-23 09:34:02.953343+05	2
\.


--
-- Data for Name: category_rating; Type: TABLE DATA; Schema: order; Owner: postgres
--

COPY "order".category_rating (id, category_id, views, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	1	0	f	2022-01-22 22:04:20.75241+05	2	\N	\N
2	1	300	f	2022-01-23 09:41:58.78416+05	2	2022-01-23 09:47:15.362717+05	2
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: order; Owner: postgres
--

COPY "order"."order" (id, category_id, title, description, condition, price, location, is_published, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
2	1	bobby	this method is bad	NEW	9000$	(1.0, 2.0)	f	f	2022-01-23 11:25:18.809297+05	2	2022-01-23 14:35:20.852703+05	2
\.


--
-- Data for Name: order_comment; Type: TABLE DATA; Schema: order; Owner: postgres
--

COPY "order".order_comment (id, order_id, user_id, comment, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	2	2	fgshbdjshygt	f	2022-01-23 12:07:26.771717+05	2	2022-01-23 12:13:30.819245+05	2
\.


--
-- Data for Name: order_condition; Type: TABLE DATA; Schema: order; Owner: postgres
--

COPY "order".order_condition (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	new	NEW	f	2022-01-23 11:02:59.527318+05	\N	\N	\N
2	old	OLD	f	2022-01-23 11:02:59.527318+05	\N	\N	\N
3	medium	MEDIUM	f	2022-01-23 11:02:59.527318+05	\N	\N	\N
4	bob	BOB	f	2022-01-23 12:24:04.613514+05	2	2022-01-23 12:43:09.163129+05	2
\.


--
-- Data for Name: order_image; Type: TABLE DATA; Schema: order; Owner: postgres
--

COPY "order".order_image (id, order_id, image_path, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	2	fgvh.png	f	2022-01-23 13:58:01.880895+05	2	2022-01-23 14:04:25.738151+05	2
\.


--
-- Data for Name: order_view; Type: TABLE DATA; Schema: order; Owner: postgres
--

COPY "order".order_view (id, order_id, view_count, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	1	0	f	2022-01-23 11:21:22.613118+05	2	\N	\N
2	2	0	f	2022-01-23 11:25:18.809297+05	2	\N	\N
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.log (id, body, created_at) FROM stdin;
1	function auth.auth_user_register(data character varying) returns text	2022-01-22 11:35:16.290446+05
2	function auth.auth_user_register(data character varying) returns text	2022-01-22 11:36:50.656143+05
3	procedure auth.auth_user_login(p_username varchar, p_pwd varchar, INOUT p_result text default ''::text)	2022-01-22 11:52:39.788923+05
4	function auth.auth_user_register(data character varying) returns text	2022-01-22 12:28:31.684511+05
5	procedure auth.auth_user_delete(del_user_id bigint, p_user_id bigint)	2022-01-22 12:28:44.65877+05
6	procedure auth.auth_user_update(data text, p_user_id bigint)	2022-01-22 14:26:30.405363+05
7	procedure auth.auth_user_update(data text, p_user_id bigint)	2022-01-22 14:37:48.24042+05
8	procedure auth.auth_user_login(p_username varchar, p_pwd varchar, INOUT p_result text default ''::text)	2022-01-22 21:31:24.180897+05
9	function auth.auth_user_register(data character varying) returns text	2022-01-22 21:31:49.952553+05
10	procedure auth.auth_user_login(p_username varchar, p_pwd varchar, INOUT p_result text default ''::text)	2022-01-22 21:32:50.134777+05
11	procedure auth.auth_user_reset_password(data character varying, p_user_id bigint)	2022-01-22 21:33:33.616003+05
12	function "order".category_create(data character varying, p_user_id bigint) returns text	2022-01-22 22:04:20.75241+05
13	procedure "order".category_delete(category_id bigint, p_user_id bigint)	2022-01-22 22:10:50.060204+05
14	procedure "order".category_delete(category_id bigint, p_user_id bigint)	2022-01-22 22:33:08.620642+05
15	procedure "order".category_update(data character varying, p_user_id bigint)	2022-01-23 08:48:24.913791+05
16	procedure "order".category_update(data character varying, p_user_id bigint)	2022-01-23 08:56:09.434913+05
17	function "order".category_list(p_user_id bigint) returns text	2022-01-23 09:01:46.540716+05
18	function "order".category_image_create(p_category_id bigint, p_image_path text, p_user_id bigint) returns text	2022-01-23 09:18:25.02754+05
19	procedure "order".category_image_delete(p_category_image_id bigint, p_user_id bigint)	2022-01-23 09:23:49.512086+05
20	procedure "order".category_image_update(p_category_image_id bigint, p_image_path text, p_user_id bigint)	2022-01-23 09:34:02.953343+05
21	function "order".category_image_list(p_user_id bigint) returns text	2022-01-23 09:37:35.251961+05
22	function "order".category_image_create(p_category_id bigint, p_image_path text, p_user_id bigint) returns text	2022-01-23 09:41:58.78416+05
23	procedure "order".category_image_delete(p_category_rating_id bigint, p_user_id bigint)	2022-01-23 09:44:30.577178+05
24	procedure "order".category_rating_update(p_category_rating_id bigint, p_view text, p_user_id bigint)	2022-01-23 09:47:15.362717+05
25	function "order".category_rating_list(p_user_id bigint) returns text	2022-01-23 10:20:03.224703+05
26	function "order".order_create(data character varying, p_user_id bigint)	2022-01-23 11:21:22.613118+05
27	function "order".order_create(data character varying, p_user_id bigint)	2022-01-23 11:25:18.809297+05
28	procedure "order".order_delete(p_order_id bigint, p_user_id bigint)	2022-01-23 11:33:00.918984+05
29	procedure "order".order_update(data character varying, p_user_id bigint)	2022-01-23 11:50:13.995592+05
30	 function "order".order_list(p_user_id bigint) returns text	2022-01-23 11:59:46.136098+05
31	procedure "order".order_comment_delete(p_comment_id bigint, p_user_id bigint)	2022-01-23 12:13:30.819245+05
32	function "order".order_comment_list(p_user_id bigint) returns text	2022-01-23 12:19:25.563027+05
33	function "order".order_condition_create(p_name varchar, p_code varchar, p_user_id bigint) returns text	2022-01-23 12:24:04.613514+05
34	procedure "order".order_condition_delete(p_condition_id bigint, p_user_id bigint)	2022-01-23 12:27:01.635147+05
35	procedure "order".order_condition_update(p_condition_id bigint, p_name varchar, p_code varchar,\r\n                                                p_user_id bigint)	2022-01-23 12:41:13.219036+05
36	procedure "order".order_condition_update(p_condition_id bigint, p_name varchar, p_code varchar,\r\n                                                p_user_id bigint)	2022-01-23 12:43:09.163129+05
37	function "order".order_comment_list(p_user_id bigint) returns text	2022-01-23 12:45:41.338207+05
38	function "order".order_image_create(p_order_id bigint, p_image_path text, p_user_id bigint) returns text	2022-01-23 13:58:01.880895+05
39	procedure "order".order_image_delete(p_image_id bigint, p_user_id bigint)	2022-01-23 14:01:10.91923+05
40	procedure "order".order_image_update(p_image_id bigint, p_image_path text, p_user_id bigint)	2022-01-23 14:04:25.738151+05
41	function "order".order_comment_list(p_user_id bigint) returns text	2022-01-23 14:06:32.7158+05
42	function "order".order_comment_list(p_user_id bigint) returns text	2022-01-23 14:21:51.079655+05
43	function "order".order_comment_list(p_user_id bigint) returns text	2022-01-23 14:27:52.834951+05
44	procedure "order".order_is_published(p_order_id bigint, p_user_id bigint)	2022-01-23 14:31:41.575345+05
45	procedure "order".order_price_update(p_order_id bigint, p_price varchar, p_user_id bigint)	2022-01-23 14:35:20.852703+05
46	function auth.auth_status_create(p_name varchar, p_code varchar, p_user_id bigint) returns text	2022-01-23 14:42:41.949216+05
47	procedure auth.auth_status_delete(p_status_id bigint, p_user_id bigint)	2022-01-23 14:45:33.724936+05
48	procedure auth.auth_status_delete(p_status_id bigint, p_user_id bigint)	2022-01-23 14:46:07.629778+05
49	procedure auth.auth_status_update(p_status_id bigint, p_name varchar, p_code varchar, p_user_id bigint)	2022-01-23 14:50:59.914661+05
50	function auth.auth_status_list(p_user_id bigint) returns text	2022-01-23 14:54:04.288041+05
51	procedure auth.auth_status_delete(p_status_id bigint, p_user_id bigint)	2022-01-23 14:57:09.7703+05
52	function auth.auth_language_list(p_user_id bigint) returns text	2022-01-23 14:58:56.021061+05
53	function auth.auth_permission_create(p_name varchar, p_code varchar(2), p_user_id bigint) returns text	2022-01-23 15:00:35.073917+05
54	function auth.auth_permission_list(p_user_id bigint) returns text	2022-01-23 15:04:16.86291+05
55	procedure auth.auth_role_delete(p_status_id bigint, p_user_id bigint)	2022-01-23 15:08:14.451153+05
56	function auth.auth_role_list(p_user_id bigint) returns text	2022-01-23 15:09:49.508022+05
57	procedure auth.auth_role_permission_delete(p_status_id bigint, p_user_id bigint)	2022-01-23 15:18:49.863728+05
58	function auth.auth_role_permission_list(p_user_id bigint) returns text	2022-01-23 15:21:00.03077+05
59	function auth.user_like_order_create(t_user_id bigint, p_order_id bigint, p_user_id bigint) returns text	2022-01-23 15:35:41.339082+05
60	procedure auth.auth_user_like_order_delete(p_status_id bigint, p_user_id bigint)	2022-01-23 15:37:52.713039+05
61	function auth.auth_user_like_order_list(p_user_id bigint) returns text	2022-01-23 15:39:33.837232+05
\.


--
-- Name: auth_block_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_block_id_seq', 1, false);


--
-- Name: auth_language_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_language_id_seq', 3, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_permission_id_seq', 20, true);


--
-- Name: auth_role_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_role_id_seq', 3, true);


--
-- Name: auth_role_permission_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_role_permission_id_seq', 19, true);


--
-- Name: auth_session_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_session_id_seq', 3, true);


--
-- Name: auth_status_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_status_id_seq', 3, true);


--
-- Name: auth_token_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_token_id_seq', 3, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_user_id_seq', 4, true);


--
-- Name: auth_user_role_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_user_role_id_seq', 1, true);


--
-- Name: user_like_order_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.user_like_order_id_seq', 1, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: order; Owner: postgres
--

SELECT pg_catalog.setval('"order".category_id_seq', 1, true);


--
-- Name: category_image_id_seq; Type: SEQUENCE SET; Schema: order; Owner: postgres
--

SELECT pg_catalog.setval('"order".category_image_id_seq', 2, true);


--
-- Name: category_rating_id_seq; Type: SEQUENCE SET; Schema: order; Owner: postgres
--

SELECT pg_catalog.setval('"order".category_rating_id_seq', 2, true);


--
-- Name: order_comment_id_seq; Type: SEQUENCE SET; Schema: order; Owner: postgres
--

SELECT pg_catalog.setval('"order".order_comment_id_seq', 1, true);


--
-- Name: order_condition_id_seq; Type: SEQUENCE SET; Schema: order; Owner: postgres
--

SELECT pg_catalog.setval('"order".order_condition_id_seq', 4, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: order; Owner: postgres
--

SELECT pg_catalog.setval('"order".order_id_seq', 2, true);


--
-- Name: order_image_id_seq; Type: SEQUENCE SET; Schema: order; Owner: postgres
--

SELECT pg_catalog.setval('"order".order_image_id_seq', 1, true);


--
-- Name: order_view_id_seq; Type: SEQUENCE SET; Schema: order; Owner: postgres
--

SELECT pg_catalog.setval('"order".order_view_id_seq', 2, true);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.log_id_seq', 61, true);


--
-- Name: auth_block auth_block_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_block
    ADD CONSTRAINT auth_block_pkey PRIMARY KEY (id);


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
-- Name: user_like_order user_like_order_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.user_like_order
    ADD CONSTRAINT user_like_order_pkey PRIMARY KEY (id);


--
-- Name: category category_code_key; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".category
    ADD CONSTRAINT category_code_key UNIQUE (code);


--
-- Name: category_image category_image_pkey; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".category_image
    ADD CONSTRAINT category_image_pkey PRIMARY KEY (id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: category_rating category_rating_pkey; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".category_rating
    ADD CONSTRAINT category_rating_pkey PRIMARY KEY (id);


--
-- Name: order_comment order_comment_pkey; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".order_comment
    ADD CONSTRAINT order_comment_pkey PRIMARY KEY (id);


--
-- Name: order_condition order_condition_code_key; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".order_condition
    ADD CONSTRAINT order_condition_code_key UNIQUE (code);


--
-- Name: order_condition order_condition_pkey; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".order_condition
    ADD CONSTRAINT order_condition_pkey PRIMARY KEY (id);


--
-- Name: order_image order_image_pkey; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".order_image
    ADD CONSTRAINT order_image_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order"."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: order_view order_view_pkey; Type: CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".order_view
    ADD CONSTRAINT order_view_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: system; Owner: postgres
--

ALTER TABLE ONLY system.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: auth_role_permission auth_role_permission_auth_user_role_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_role_permission
    ADD CONSTRAINT auth_role_permission_auth_user_role_id_fkey FOREIGN KEY (auth_user_role_id) REFERENCES auth.auth_user_role(id);


--
-- Name: auth_role_permission auth_role_permission_permission_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_role_permission
    ADD CONSTRAINT auth_role_permission_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth.auth_permission(id);


--
-- Name: auth_session auth_session_token_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_session
    ADD CONSTRAINT auth_session_token_id_fkey FOREIGN KEY (token_id) REFERENCES auth.auth_token(id);


--
-- Name: auth_user auth_user_language_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user
    ADD CONSTRAINT auth_user_language_fkey FOREIGN KEY (language) REFERENCES auth.auth_language(code);


--
-- Name: auth_user_role auth_user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user_role
    ADD CONSTRAINT auth_user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES auth.auth_role(id);


--
-- Name: auth_user auth_user_status_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.auth_user
    ADD CONSTRAINT auth_user_status_fkey FOREIGN KEY (status) REFERENCES auth.auth_status(code);


--
-- Name: user_like_order user_like_order_order_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.user_like_order
    ADD CONSTRAINT user_like_order_order_id_fkey FOREIGN KEY (order_id) REFERENCES "order"."order"(id);


--
-- Name: user_like_order user_like_order_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth.user_like_order
    ADD CONSTRAINT user_like_order_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.auth_user(id);


--
-- Name: category_image category_image_category_id_fkey; Type: FK CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".category_image
    ADD CONSTRAINT category_image_category_id_fkey FOREIGN KEY (category_id) REFERENCES "order".category(id);


--
-- Name: category_rating category_rating_category_id_fkey; Type: FK CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order".category_rating
    ADD CONSTRAINT category_rating_category_id_fkey FOREIGN KEY (category_id) REFERENCES "order".category(id);


--
-- Name: order order_category_id_fkey; Type: FK CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order"."order"
    ADD CONSTRAINT order_category_id_fkey FOREIGN KEY (category_id) REFERENCES "order".category(id);


--
-- Name: order order_condition_fkey; Type: FK CONSTRAINT; Schema: order; Owner: postgres
--

ALTER TABLE ONLY "order"."order"
    ADD CONSTRAINT order_condition_fkey FOREIGN KEY (condition) REFERENCES "order".order_condition(code);


--
-- PostgreSQL database dump complete
--

