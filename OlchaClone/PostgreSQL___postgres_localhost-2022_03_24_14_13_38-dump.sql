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
-- Name: basket_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.basket_create_dto AS (
	user_id integer,
	order_id integer,
	product_id integer,
	product_count integer,
	total_price character varying(50)
);


ALTER TYPE dto.basket_create_dto OWNER TO postgres;

--
-- Name: basket_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.basket_update_dto AS (
	id integer,
	product_count integer,
	total_price character varying(50)
);


ALTER TYPE dto.basket_update_dto OWNER TO postgres;

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
-- Name: category_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.category_create_dto AS (
	title character varying,
	code character varying,
	pic character varying,
	description text
);


ALTER TYPE dto.category_create_dto OWNER TO postgres;

--
-- Name: category_sub_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.category_sub_create_dto AS (
	parent_id integer,
	title character varying,
	code character varying,
	pic character varying,
	description text
);


ALTER TYPE dto.category_sub_create_dto OWNER TO postgres;

--
-- Name: category_sub_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.category_sub_update_dto AS (
	id bigint,
	parent_id bigint,
	title character varying,
	code character varying,
	pic character varying,
	description text
);


ALTER TYPE dto.category_sub_update_dto OWNER TO postgres;

--
-- Name: category_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.category_update_dto AS (
	id bigint,
	title character varying,
	code character varying,
	pic character varying,
	description text
);


ALTER TYPE dto.category_update_dto OWNER TO postgres;

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
-- Name: like_dislike_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.like_dislike_dto AS (
	user_id integer,
	product_id integer
);


ALTER TYPE dto.like_dislike_dto OWNER TO postgres;

--
-- Name: order_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.order_create_dto AS (
	card_id integer,
	user_id integer,
	type character varying,
	status character varying,
	product_count integer,
	total_price character varying(50)
);


ALTER TYPE dto.order_create_dto OWNER TO postgres;

--
-- Name: order_status_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.order_status_update_dto AS (
	name character varying(50),
	old_code character varying(50),
	new_code character varying(50)
);


ALTER TYPE dto.order_status_update_dto OWNER TO postgres;

--
-- Name: order_type_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.order_type_update_dto AS (
	name character varying(50),
	old_code character varying(50),
	new_code character varying(50)
);


ALTER TYPE dto.order_type_update_dto OWNER TO postgres;

--
-- Name: order_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.order_update_dto AS (
	id integer,
	card_id integer,
	type character varying,
	status character varying,
	product_count integer,
	total_price character varying(50)
);


ALTER TYPE dto.order_update_dto OWNER TO postgres;

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
-- Name: product_comment_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_comment_create_dto AS (
	product_id integer,
	user_id integer,
	message text
);


ALTER TYPE dto.product_comment_create_dto OWNER TO postgres;

--
-- Name: product_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_create_dto AS (
	category_id integer,
	title character varying,
	code character varying,
	count integer,
	color character varying,
	width numeric(10,2),
	height numeric(10,2),
	country character varying,
	date_of_manufacture character varying,
	description text,
	price character varying(30),
	extra json,
	image json
);


ALTER TYPE dto.product_create_dto OWNER TO postgres;

--
-- Name: product_image_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_image_create_dto AS (
	product_id integer,
	product_pic json
);


ALTER TYPE dto.product_image_create_dto OWNER TO postgres;

--
-- Name: product_image_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_image_update_dto AS (
	id integer,
	product_pic text
);


ALTER TYPE dto.product_image_update_dto OWNER TO postgres;

--
-- Name: product_price_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_price_create_dto AS (
	product_id integer,
	price character varying(30),
	discount_percent smallint
);


ALTER TYPE dto.product_price_create_dto OWNER TO postgres;

--
-- Name: product_price_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_price_update_dto AS (
	product_id integer,
	price character varying(30),
	discount_percent smallint
);


ALTER TYPE dto.product_price_update_dto OWNER TO postgres;

--
-- Name: product_rating_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_rating_create_dto AS (
	product_id integer,
	views smallint,
	purchased smallint
);


ALTER TYPE dto.product_rating_create_dto OWNER TO postgres;

--
-- Name: product_rating_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_rating_update_dto AS (
	product_id integer,
	views smallint,
	purchased smallint
);


ALTER TYPE dto.product_rating_update_dto OWNER TO postgres;

--
-- Name: product_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.product_update_dto AS (
	id integer,
	title character varying,
	count integer,
	color character varying,
	width numeric(10,2),
	height numeric(10,2),
	country character varying,
	date_of_manufacture character varying,
	description text,
	price character varying(30),
	discount_percent smallint,
	extra json
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
	phone character(13),
	email character varying(100),
	logo text,
	location point
);


ALTER TYPE dto.sponsor_create_dto OWNER TO postgres;

--
-- Name: sponsor_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.sponsor_update_dto AS (
	id integer,
	name character varying,
	phone character(13),
	email character varying(100),
	logo text,
	location point
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
-- Name: transaction_create_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.transaction_create_dto AS (
	user_id integer,
	order_id integer,
	type character varying(100),
	status character varying(100),
	quantity character varying(50)
);


ALTER TYPE dto.transaction_create_dto OWNER TO postgres;

--
-- Name: transaction_status_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.transaction_status_update_dto AS (
	old_code character varying(100),
	new_code character varying(100),
	name character varying(100)
);


ALTER TYPE dto.transaction_status_update_dto OWNER TO postgres;

--
-- Name: transaction_type_update_dto; Type: TYPE; Schema: dto; Owner: postgres
--

CREATE TYPE dto.transaction_type_update_dto AS (
	old_code character varying(100),
	new_code character varying(100),
	name character varying(100)
);


ALTER TYPE dto.transaction_type_update_dto OWNER TO postgres;

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
-- Name: auth_register(text, integer); Type: PROCEDURE; Schema: auth; Owner: postgres
--

CREATE PROCEDURE auth.auth_register(data text, INOUT p_result integer DEFAULT '-1'::integer)
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
    p_result = new_user_id;
end;
$$;


ALTER PROCEDURE auth.auth_register(data text, INOUT p_result integer) OWNER TO postgres;

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
-- Name: auth_user_detail(uuid); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_user_detail(p_user_code uuid) RETURNS text
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


ALTER FUNCTION auth.auth_user_detail(p_user_code uuid) OWNER TO postgres;

--
-- Name: auth_user_get(uuid); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.auth_user_get(p_user_code uuid) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_auth_user jsonb;
    t_auth_user auth.auth_user%rowtype;
begin
    select * into t_auth_user from auth.auth_user where not is_deleted and code = p_user_code;
    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;
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
    call settings.log_insert('auth.auth_user_get(p_user_code uuid) returns text');
    return (v_auth_user::text);
end;
$$;


ALTER FUNCTION auth.auth_user_get(p_user_code uuid) OWNER TO postgres;

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
-- Name: card_get(integer, integer); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION auth.card_get(p_card_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_card jsonb;
    t_card auth.auth_card%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('GET_CARD', p_user_id);

    select * into t_card from auth.auth_card where not is_deleted and id = p_card_id;
    if not FOUND then
        raise exception '%', settings.translate('CARD_NOT_FOUND', 'UZ');
    end if;

    v_card = jsonb_build_object('user', (select auth.auth_user_get(auth.user_id_by_code(t_card.user_id)))::jsonb);
    v_card = v_card || jsonb_build_object('card_type', t_card.card_type);
    v_card = v_card || jsonb_build_object('number', t_card.number);
    v_card = v_card || jsonb_build_object('holder_name', t_card.holder_name);
    v_card = v_card || jsonb_build_object('expire_date', t_card.expire_date);
    v_card = v_card || jsonb_build_object('created_at', t_card.created_at);

    call settings.log_insert('auth.card_get(p_card_id integer, p_user_id integer) returns text');
    return (v_card::text);
end
$$;


ALTER FUNCTION auth.card_get(p_card_id integer, p_user_id integer) OWNER TO postgres;

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
    user_code     uuid;
    v_user_role   jsonb;
    v_user_role_l jsonb = '[]';
    t_user_role   auth.auth_user_role%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_USER_ROLE', p_user_id);

    for t_user_role in (select * from auth.auth_user_role where not is_deleted)
        loop
            user_code = auth.user_code_by_id(t_user_role.user_id);
            v_user_role =
                    jsonb_build_object('user', (auth.auth_user_get(user_code))::jsonb);
            v_user_role = v_user_role || jsonb_build_object('code', t_user_role.role_id);
            v_user_role = v_user_role || jsonb_build_object('created_at', t_user_role.created_at);
            v_user_role_l = v_user_role_l || v_user_role;
        end loop;

    call settings.log_insert('auth.user_role_list(p_user_id integer) returns text');
    return (v_user_role_l::text);
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
-- Name: check_basket_create_dto(dto.basket_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_basket_create_dto(INOUT create_dto dto.basket_create_dto)
    LANGUAGE plpgsql
    AS $$
begin
    if create_dto.user_id is null then
        raise exception '% user id', settings.translate('IS_REQUIRED_TO_CREATE_BASKET', 'UZ');
    end if;

    if create_dto.order_id is null then
        raise exception '% order id', settings.translate('IS_REQUIRED_TO_CREATE_BASKET', 'UZ');
    end if;

    if create_dto.product_id is null then
        raise exception '% product id', settings.translate('IS_REQUIRED_TO_CREATE_BASKET', 'UZ');
    end if;

    if create_dto.product_count is null then
        raise exception '% product count', settings.translate('IS_REQUIRED_TO_CREATE_BASKET', 'UZ');
    end if;

    if create_dto.total_price is null then
        raise exception '% total price', settings.translate('IS_REQUIRED_TO_CREATE_BASKET', 'UZ');
    end if;
end
$$;


ALTER PROCEDURE checks.check_basket_create_dto(INOUT create_dto dto.basket_create_dto) OWNER TO postgres;

--
-- Name: check_basket_update_dto(dto.basket_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_basket_update_dto(INOUT update_dto dto.basket_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_basket project.basket%rowtype;
begin
    if update_dto.id is null then
        raise exception '% id', settings.translate('IS_REQUIRED_TO_CREATE_BASKET', 'UZ');
    end if;

    select * into t_basket from project.basket where not is_deleted and id = update_dto.id;
    if not FOUND then
        raise exception '%', settings.translate('BASKET_NOT_FOUND', 'UZ');
    end if;

    if update_dto.product_count is null then
        update_dto.product_count = t_basket.product_count;
    end if;

    if update_dto.total_price is null then
        update_dto.total_price = t_basket.total_price;
    end if;
end
$$;


ALTER PROCEDURE checks.check_basket_update_dto(INOUT update_dto dto.basket_update_dto) OWNER TO postgres;

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
-- Name: check_category_create_dto(dto.category_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_category_create_dto(INOUT create_dto dto.category_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_category project.category%rowtype;
begin
    if create_dto.title is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if create_dto.code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_category from project.category where not is_deleted and code = create_dto.code;
    if FOUND then
        raise exception '%', settings.translate('CATEGORY_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;
end
$$;


ALTER PROCEDURE checks.check_category_create_dto(INOUT create_dto dto.category_create_dto) OWNER TO postgres;

--
-- Name: check_category_sub_create_dto(dto.category_sub_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_category_sub_create_dto(INOUT create_dto dto.category_sub_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_category project.category%rowtype;
begin
    if create_dto.parent_id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if not exists(select * from project.category where not is_deleted and id = create_dto.parent_id) then
        raise exception '%', settings.translate('SUB_CATEGORY_NOT_FOUND', 'UZ');
    end if;

    if create_dto.title is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if create_dto.code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_category from project.category where not is_deleted and code = create_dto.code;
    if FOUND then
        raise exception '%', settings.translate('CATEGORY_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;
end
$$;


ALTER PROCEDURE checks.check_category_sub_create_dto(INOUT create_dto dto.category_sub_create_dto) OWNER TO postgres;

--
-- Name: check_category_sub_update_dto(dto.category_sub_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_category_sub_update_dto(INOUT update_dto dto.category_sub_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_category project.category%rowtype;
begin
    if update_dto.id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_category from project.category where not is_deleted and id = update_dto.id;

    if not FOUND then
        raise exception '%', settings.translate('CATEGORY_NOT_FOUND', 'UZ');
    end if;

    if update_dto.parent_id is null then
        update_dto.parent_id = t_category.parent_id;
    else
        select * into t_category from project.category where not is_deleted and id = update_dto.parent_id;
        if not FOUND then
            raise exception '%', settings.translate('PARENT_NOT_FOUND', 'UZ');
        end if;
    end if;

    if update_dto.title is null then
        update_dto.title = t_category.title;
    end if;

    if update_dto.pic is null then
        update_dto.pic = t_category.category_pic;
    end if;

    if update_dto.description is null then
        update_dto.description = t_category.description;
    end if;

    if update_dto.code is null then
        update_dto.code = t_category.code;
    else
        select * into t_category from project.category where not is_deleted and code = update_dto.code;
        if FOUND then
            raise exception '%', settings.translate('CATEGORY_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;
end
$$;


ALTER PROCEDURE checks.check_category_sub_update_dto(INOUT update_dto dto.category_sub_update_dto) OWNER TO postgres;

--
-- Name: check_category_update_dto(dto.category_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_category_update_dto(INOUT update_dto dto.category_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_category project.category%rowtype;
begin
    if update_dto.id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_category from project.category where not is_deleted and id = update_dto.id;

    if not FOUND then
        raise exception '%', settings.translate('CATEGORY_NOT_FOUND', 'UZ');
    end if;

    if update_dto.title is null then
        update_dto.title = t_category.title;
    end if;

    if update_dto.pic is null then
        update_dto.pic = t_category.category_pic;
    end if;

    if update_dto.description is null then
        update_dto.description = t_category.description;
    end if;

    if update_dto.code is null then
        update_dto.code = t_category.code;
    else
        select * into t_category from project.category where not is_deleted and code = update_dto.code;
        if FOUND then
            raise exception '%', settings.translate('CATEGORY_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;
end
$$;


ALTER PROCEDURE checks.check_category_update_dto(INOUT update_dto dto.category_update_dto) OWNER TO postgres;

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
-- Name: check_like_dislike_dto(dto.like_dislike_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_like_dislike_dto(INOUT add_dto dto.like_dislike_dto)
    LANGUAGE plpgsql
    AS $$
begin
    if add_dto.user_id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if not exists(select * from auth.auth_user where not is_deleted and id = add_dto.user_id) then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    if add_dto.product_id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if not exists(select * from project.product where not is_deleted and id = add_dto.product_id) then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;
end
$$;


ALTER PROCEDURE checks.check_like_dislike_dto(INOUT add_dto dto.like_dislike_dto) OWNER TO postgres;

--
-- Name: check_order_create_dto(dto.order_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_order_create_dto(INOUT create_dto dto.order_create_dto)
    LANGUAGE plpgsql
    AS $$
begin
    if create_dto.user_id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if create_dto.product_count is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if create_dto.total_price is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if create_dto.type is null then
        create_dto.type = 'DELIVERING';
    end if;

    if create_dto.status is null then
        create_dto.status = 'START';
    end if;
end
$$;


ALTER PROCEDURE checks.check_order_create_dto(INOUT create_dto dto.order_create_dto) OWNER TO postgres;

--
-- Name: check_order_status_update_dto(dto.order_status_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_order_status_update_dto(INOUT update_dto dto.order_status_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_status project.order_status%rowtype;
begin
    if update_dto.old_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_status from project.order_status where not is_deleted and code = update_dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_STATUS_NOT_FOUND', 'UZ');
    end if;

    if update_dto.new_code is null then
        update_dto.new_code = t_status.code;
    else
        if exists(select * from project.order_status where not is_deleted and code = update_dto.new_code) then
            raise exception '%', settings.translate('ORDER_STATUS_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;

    if update_dto.name is null then
        update_dto.name = t_status.name;
    end if;

    call settings.log_insert('checks.check_order_status_update_dto(inout update_dto dto.order_status_update_dto)');
end
$$;


ALTER PROCEDURE checks.check_order_status_update_dto(INOUT update_dto dto.order_status_update_dto) OWNER TO postgres;

--
-- Name: check_order_type_update_dto(dto.order_type_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_order_type_update_dto(INOUT update_dto dto.order_type_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_type project.order_type%rowtype;
begin
    if update_dto.old_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_type from project.order_type where not is_deleted and code = update_dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_TYPE_NOT_FOUND', 'UZ');
    end if;

    if update_dto.new_code is null then
        update_dto.new_code = t_type.code;
    else
        if exists(select * from project.order_type where not is_deleted and code = update_dto.new_code) then
            raise exception '%', settings.translate('ORDER_TYPE_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;

    if update_dto.name is null then
        update_dto.name = t_type.name;
    end if;

    call settings.log_insert('checks.check_order_type_update_dto(inout update_dto dto.order_type_update_dto)');
end
$$;


ALTER PROCEDURE checks.check_order_type_update_dto(INOUT update_dto dto.order_type_update_dto) OWNER TO postgres;

--
-- Name: check_order_update_dto(dto.order_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_order_update_dto(INOUT update_dto dto.order_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_order project.order%rowtype;
begin
    if update_dto.id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_order from project.order where not is_deleted and id = update_dto.id;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_NOT_FOUND', 'UZ');
    end if;

    if update_dto.card_id is null then
        update_dto.card_id = t_order.card_id;
    end if;

    if update_dto.product_count is null then
        update_dto.product_count = t_order.product_count;
    end if;

    if update_dto.total_price is null then
        update_dto.total_price = t_order.total_price;
    end if;

    if update_dto.type is null then
        update_dto.type = t_order.type;
    end if;

    if update_dto.status is null then
        update_dto.status = t_order.status;
    end if;
end
$$;


ALTER PROCEDURE checks.check_order_update_dto(INOUT update_dto dto.order_update_dto) OWNER TO postgres;

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
-- Name: check_product_comment_create_dto(dto.product_comment_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_comment_create_dto(INOUT create_dto dto.product_comment_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_user    auth.auth_user%rowtype;
    t_product project.product%rowtype;
begin
    if create_dto.user_id is null then
        raise exception '% user id', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_COMMENT', 'UZ');
    end if;

    select * into t_user from auth.auth_user where not is_deleted and id = create_dto.user_id;
    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    if create_dto.product_id is null then
        raise exception '% product id', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_COMMENT', 'UZ');
    end if;

    select * into t_product from project.product where not is_deleted and id = create_dto.product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;

    if create_dto.message is null then
        raise exception '% message', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_COMMENT', 'UZ');
    end if;
end
$$;


ALTER PROCEDURE checks.check_product_comment_create_dto(INOUT create_dto dto.product_comment_create_dto) OWNER TO postgres;

--
-- Name: check_product_create_dto(dto.product_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_create_dto(INOUT dto dto.product_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_product  project.product%rowtype;
    t_category project.category%rowtype;
begin
    if dto.category_id is null then
        raise exception '% category id', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    select * into t_category from project.category where not is_deleted and id = dto.category_id;
    if NOT FOUND then
        raise exception '%', settings.translate('CATEGORY_NOT_FOUND', 'UZ');
    end if;

    if dto.code is null then
        raise exception '% code', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    select * into t_product from project.product where not is_deleted and code = dto.code;
    if FOUND then
        raise exception '% ', settings.translate('PRODUCT_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    if dto.price is null then
        raise exception '% price', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    if dto.title is null then
        raise exception '% title', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    if dto.count is null then
        raise exception '% count', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    if dto.color is null then
        raise exception '% color', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    if dto.width is null then
        raise exception '% width', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    if dto.height is null then
        raise exception '% height', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    if dto.country is null then
        raise exception '% country', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    if dto.date_of_manufacture is null then
        raise exception '% date of manufacture', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;

    if dto.image is null then
        raise exception '% image', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT', 'UZ');
    end if;
end;
$$;


ALTER PROCEDURE checks.check_product_create_dto(INOUT dto dto.product_create_dto) OWNER TO postgres;

--
-- Name: check_product_image_create_dto(dto.product_image_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_image_create_dto(INOUT create_dto dto.product_image_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_product project.product%rowtype;
begin
    if create_dto.product_id is null then
        raise exception '% product id', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_IMAGE', 'UZ');
    end if;

    select * into t_product from project.product where not is_deleted and id = create_dto.product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;

    if create_dto.product_pic is null then
        raise exception '% product pic', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_IMAGE', 'UZ');
    end if;
end
$$;


ALTER PROCEDURE checks.check_product_image_create_dto(INOUT create_dto dto.product_image_create_dto) OWNER TO postgres;

--
-- Name: check_product_image_update_dto(dto.product_image_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_image_update_dto(INOUT update_dto dto.product_image_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_image project.product_image%rowtype;
begin
    if update_dto.id is null then
        raise exception '% id', settings.translate('IS_REQUIRED_TO_UPDATE_PRODUCT_IMAGE', 'UZ');
    end if;

    select * into t_image from project.product_image where not is_deleted and id = update_dto.id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_IMAGE_NOT_FOUND', 'UZ');
    end if;

    if update_dto.product_pic is null then
        update_dto.product_pic = t_image.product_pic;
    end if;
end
$$;


ALTER PROCEDURE checks.check_product_image_update_dto(INOUT update_dto dto.product_image_update_dto) OWNER TO postgres;

--
-- Name: check_product_price_create_dto(dto.product_price_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_price_create_dto(INOUT create_dto dto.product_price_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_product project.product%rowtype;
begin
    if create_dto.product_id is null then
        raise exception '% product id', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_PRICE', 'UZ');
    end if;

    select * into t_product from project.product where not is_deleted and id = create_dto.product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;

    if create_dto.price is null then
        raise exception '% price', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_RATING', 'UZ');
    end if;

    if create_dto.discount_percent is null then
        create_dto.discount_percent = 0;
    end if;
end
$$;


ALTER PROCEDURE checks.check_product_price_create_dto(INOUT create_dto dto.product_price_create_dto) OWNER TO postgres;

--
-- Name: check_product_price_update_dto(dto.product_price_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_price_update_dto(INOUT update_dto dto.product_price_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_price project.product_price%rowtype;
begin
    if update_dto.product_id is null then
        raise exception '% product id', settings.translate('IS_REQUIRED_TO_UPDATE_PRODUCT_PRICE', 'UZ');
    end if;

    select * into t_price from project.product_price where not is_deleted and product_id = update_dto.product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_PRICE_NOT_FOUND', 'UZ');
    end if;

    if update_dto.price is null then
        update_dto.price = t_price.price;
    end if;

    if update_dto.discount_percent is null then
        update_dto.discount_percent = t_price.discount_percent;
    end if;
end
$$;


ALTER PROCEDURE checks.check_product_price_update_dto(INOUT update_dto dto.product_price_update_dto) OWNER TO postgres;

--
-- Name: check_product_rating_create_dto(dto.product_rating_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_rating_create_dto(INOUT create_dto dto.product_rating_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_product project.product%rowtype;
begin
    if create_dto.product_id is null then
        raise exception '% product id', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_RATING', 'UZ');
    end if;

    select * into t_product from project.product where not is_deleted and id = create_dto.product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;

    if create_dto.views is null then
        raise exception '% views', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_RATING', 'UZ');
    end if;

    if create_dto.purchased is null then
        raise exception '% purchased', settings.translate('IS_REQUIRED_TO_CREATE_PRODUCT_RATING', 'UZ');
    end if;
end
$$;


ALTER PROCEDURE checks.check_product_rating_create_dto(INOUT create_dto dto.product_rating_create_dto) OWNER TO postgres;

--
-- Name: check_product_rating_update_dto(dto.product_rating_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_rating_update_dto(INOUT update_dto dto.product_rating_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_rating project.product_rating%rowtype;
begin
    if update_dto.product_id is null then
        raise exception '% product id', settings.translate('IS_REQUIRED_TO_UPDATE_PRODUCT_RATING', 'UZ');
    end if;

    select * into t_rating from project.product_rating where not is_deleted and product_id = update_dto.product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_RATING_NOT_FOUND', 'UZ');
    end if;

    if update_dto.views is null then
        update_dto.views = t_rating.views;
    end if;

    if update_dto.purchased is null then
        update_dto.purchased = t_rating.purchased;
    end if;
end
$$;


ALTER PROCEDURE checks.check_product_rating_update_dto(INOUT update_dto dto.product_rating_update_dto) OWNER TO postgres;

--
-- Name: check_product_update_dto(dto.product_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_product_update_dto(INOUT p_update dto.product_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_product_price project.product_price%rowtype;
    t_product       project.product%rowtype;
begin
    if p_update.id is null then
        raise exception 'id %', settings.translate('IS_REQUIRED_TO_UPDATE_PRODUCT', 'UZ');
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
    t_sponsor system.sponsors%rowtype;
begin
    if p_dto.name is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_sponsor from system.sponsors where not is_deleted and name = p_dto.name;
    if FOUND then
        raise exception '%', settings.translate('SPONSOR_NAME_IS_AVAILABLE', 'UZ');
    end if;

    if p_dto.email is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if p_dto.logo is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if p_dto.phone is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    if p_dto.location is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
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
    t_sponsor system.sponsors%rowtype;
begin
    if p_dto.id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_sponsor from system.sponsors where not is_deleted and id = p_dto.id;
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
-- Name: check_transaction_create_dto(dto.transaction_create_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_transaction_create_dto(INOUT create_dto dto.transaction_create_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_order              project.order%rowtype;
    t_auth_user          auth.auth_user%rowtype;
    t_transaction_type   project.transaction_type%rowtype;
    t_transaction_status project.transaction_status%rowtype;
begin
    if create_dto.user_id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and id = create_dto.user_id;
    if not FOUND then
        raise exception '%', settings.translate('USER_NOT_FOUND', 'UZ');
    end if;

    if create_dto.order_id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_order from project.order where not is_deleted and id = create_dto.order_id;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_NOT_FOUND', 'UZ');
    end if;

    if create_dto.type is null then
        raise exception '% type', settings.translate('IS_REQUIRED_TO_CREATE_TRANSACTION', 'UZ');
    else
        select * into t_transaction_type from project.transaction_type where not is_deleted and code = create_dto.type;
        if NOT FOUND then
            raise exception '%', settings.translate('TRANSACTION_TYPE_NOT_FOUND', 'UZ');
        end if;
    end if;

    if create_dto.status is null then
        raise exception '% status', settings.translate('IS_REQUIRED_TO_CREATE_TRANSACTION', 'UZ');
    else
        select *
        into t_transaction_status
        from project.transaction_status
        where not is_deleted
          and code = create_dto.status;
        if NOT FOUND then
            raise exception '%', settings.translate('TRANSACTION_STATUS_NOT_FOUND', 'UZ');
        end if;
    end if;

    if create_dto.quantity is null then
        raise exception '% quantity', settings.translate('IS_REQUIRED_TO_CREATE_TRANSACTION', 'UZ');
    end if;

    call settings.log_insert('checks.check_transaction_create_dto(INOUT create_dto dto.transaction_create_dto)');
end;
$$;


ALTER PROCEDURE checks.check_transaction_create_dto(INOUT create_dto dto.transaction_create_dto) OWNER TO postgres;

--
-- Name: check_transaction_status_update_dto(dto.transaction_status_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_transaction_status_update_dto(INOUT update_dto dto.transaction_status_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_status project.transaction_status%rowtype;
begin
    if update_dto.old_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_status from project.transaction_status where not is_deleted and code = update_dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('TRANSACTION_STATUS_NOT_FOUND', 'UZ');
    end if;

    if update_dto.new_code is null then
        update_dto.new_code = t_status.code;
    else
        if exists(select * from project.transaction_status where not is_deleted and code = update_dto.new_code) then
            raise exception '%', settings.translate('TRANSACTION_STATUS_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;

    if update_dto.name is null then
        update_dto.name = t_status.name;
    end if;

    call settings.log_insert('checks.check_transaction_status_update_dto(INOUT update_dto dto.transaction_status_update_dto)');
end;
$$;


ALTER PROCEDURE checks.check_transaction_status_update_dto(INOUT update_dto dto.transaction_status_update_dto) OWNER TO postgres;

--
-- Name: check_transaction_type_update_dto(dto.transaction_type_update_dto); Type: PROCEDURE; Schema: checks; Owner: postgres
--

CREATE PROCEDURE checks.check_transaction_type_update_dto(INOUT update_dto dto.transaction_type_update_dto)
    LANGUAGE plpgsql
    AS $$
declare
    t_type project.transaction_type%rowtype;
begin
    if update_dto.old_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_type from project.transaction_type where not is_deleted and code = update_dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('TRANSACTION_TYPE_NOT_FOUND', 'UZ');
    end if;

    if update_dto.new_code is null then
        update_dto.new_code = t_type.code;
    else
        if exists(select * from project.transaction_type where not is_deleted and code = update_dto.new_code) then
            raise exception '%', settings.translate('TRANSACTION_TYPE_CODE_IS_ALREADY_TAKEN', 'UZ');
        end if;
    end if;

    if update_dto.name is null then
        update_dto.name = t_type.name;
    end if;

    call settings.log_insert('checks.check_transaction_type_update_dto(INOUT update_dto dto.transaction_type_update_dto)');
end;
$$;


ALTER PROCEDURE checks.check_transaction_type_update_dto(INOUT update_dto dto.transaction_type_update_dto) OWNER TO postgres;

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
-- Name: to_basket_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_basket_create_dto(datajson json) RETURNS dto.basket_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.basket_create_dto;
begin
    dto.user_id = (dataJson ->> 'user_id')::integer;
    dto.order_id = (dataJson ->> 'order_id')::integer;
    dto.product_id = (dataJson ->> 'product_id')::integer;
    dto.product_count = (dataJson ->> 'product_count')::integer;
    dto.total_price = dataJson ->> 'total_price';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_basket_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_basket_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_basket_update_dto(datajson json) RETURNS dto.basket_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.basket_update_dto;
begin
    dto.id = (dataJson ->> 'id')::integer;
    dto.product_count = (dataJson ->> 'product_count')::integer;
    dto.total_price = dataJson ->> 'total_price';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_basket_update_dto(datajson json) OWNER TO postgres;

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
-- Name: to_category_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_category_create_dto(datajson json) RETURNS dto.category_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.category_create_dto;
begin
    dto.title = dataJson ->> 'title';
    dto.code = dataJson ->> 'code';
    dto.pic = dataJson ->> 'pic';
    dto.description = dataJson ->> 'description';
end
$$;


ALTER FUNCTION mappers.to_category_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_category_sub_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_category_sub_create_dto(datajson json) RETURNS dto.category_sub_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.category_sub_create_dto;
begin
    dto.parent_id = (dataJson ->> 'parent_id')::integer;
    dto.title = dataJson ->> 'title';
    dto.code = dataJson ->> 'code';
    dto.pic = dataJson ->> 'pic';
    dto.description = dataJson ->> 'description';
end
$$;


ALTER FUNCTION mappers.to_category_sub_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_category_sub_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_category_sub_update_dto(datajson json) RETURNS dto.category_sub_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.category_sub_update_dto;
begin
    dto.id = (dataJson ->> 'id')::bigint;
    dto.parent_id = (dataJson ->> 'parent_id')::bigint;
    dto.title = dataJson ->> 'title';
    dto.code = dataJson ->> 'code';
    dto.pic = dataJson ->> 'pic';
    dto.description = dataJson ->> 'description';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_category_sub_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_category_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_category_update_dto(datajson json) RETURNS dto.category_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.category_update_dto;
begin
    dto.id = (dataJson ->> 'id')::bigint;
    dto.title = dataJson ->> 'title';
    dto.code = dataJson ->> 'code';
    dto.pic = dataJson ->> 'pic';
    dto.description = dataJson ->> 'description';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_category_update_dto(datajson json) OWNER TO postgres;

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
-- Name: to_like_dislike_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_like_dislike_dto(datajson json) RETURNS dto.like_dislike_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.like_dislike_dto;
begin
    dto.user_id = (dataJson ->> 'user_id')::integer;
    dto.product_id = (dataJson ->> 'product_id')::integer;
    return dto;
end
$$;


ALTER FUNCTION mappers.to_like_dislike_dto(datajson json) OWNER TO postgres;

--
-- Name: to_order_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_order_create_dto(datajson json) RETURNS dto.order_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.order_create_dto;
begin
    dto.card_id = (dataJson ->> 'card_id')::integer;
    dto.user_id = (dataJson ->> 'user_id')::integer;
    dto.product_count = (dataJson ->> 'product_count')::integer;
    dto.total_price = dataJson ->> 'total_price';
    dto.type = dataJson ->> 'type';
    dto.status = dataJson ->> 'status';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_order_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_order_status_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_order_status_update_dto(datajson json) RETURNS dto.order_status_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.order_status_update_dto;
begin
    dto.name = dataJson ->> 'name';
    dto.old_code = dataJson ->> 'old_code';
    dto.new_code = dataJson ->> 'new_code';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_order_status_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_order_type_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_order_type_update_dto(datajson json) RETURNS dto.order_type_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.order_type_update_dto;
begin
    dto.name = dataJson ->> 'name';
    dto.old_code = dataJson ->> 'old_code';
    dto.new_code = dataJson ->> 'new_code';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_order_type_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_order_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_order_update_dto(datajson json) RETURNS dto.order_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.order_update_dto;
begin
    dto.id = (dataJson ->> 'id')::integer;
    dto.card_id = (dataJson ->> 'card_id')::integer;
    dto.product_count = (dataJson ->> 'product_count')::integer;
    dto.total_price = dataJson ->> 'total_price';
    dto.type = dataJson ->> 'type';
    dto.status = dataJson ->> 'status';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_order_update_dto(datajson json) OWNER TO postgres;

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
-- Name: to_product_comment_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_comment_create_dto(datajson json) RETURNS dto.product_comment_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_comment_create_dto;
begin
    dto.product_id = (dataJson ->> 'product_id')::integer;
    dto.user_id = (dataJson ->> 'user_id')::integer;
    dto.message = dataJson ->> 'message';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_product_comment_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_product_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_create_dto(data json) RETURNS dto.product_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_create_dto;
begin
    dto.category_id = (data ->> 'category_id')::integer;
    dto.title = data ->> 'title';
    dto.code = data ->> 'code';
    dto.count = (data ->> 'count')::integer;
    dto.color = data ->> 'color';
    dto.width = (data ->> 'width')::numeric;
    dto.height = (data ->> 'height')::numeric;
    dto.country = data ->> 'country';
    dto.price = data ->> 'price';
    dto.date_of_manufacture = data ->> 'date_of_manufacture';
    dto.description = data ->> 'description';
    dto.extra = data -> 'extra';
    dto.image = data -> 'image';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_product_create_dto(data json) OWNER TO postgres;

--
-- Name: to_product_image_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_image_create_dto(datajson json) RETURNS dto.product_image_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_image_create_dto;
begin
    dto.product_id = (dataJson ->> 'product_id')::integer;
    dto.product_pic = dataJson -> 'product_pic';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_product_image_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_product_image_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_image_update_dto(datajson json) RETURNS dto.product_image_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_image_update_dto;
begin
    dto.id = (dataJson ->> 'id')::integer;
    dto.product_pic = dataJson ->> 'product_pic';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_product_image_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_product_price_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_price_create_dto(datajson json) RETURNS dto.product_price_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_price_create_dto;
begin
    dto.product_id = (dataJson ->> 'product_id')::integer;
    dto.price = dataJson ->> 'price';
    dto.discount_percent = (dataJson ->> 'discount_percent')::smallint;
    return dto;
end
$$;


ALTER FUNCTION mappers.to_product_price_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_product_price_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_price_update_dto(datajson json) RETURNS dto.product_price_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_price_update_dto;
begin
    dto.product_id = (dataJson ->> 'product_id')::integer;
    dto.price = dataJson ->> 'price';
    dto.discount_percent = (dataJson ->> 'discount_percent')::smallint;
    return dto;
end
$$;


ALTER FUNCTION mappers.to_product_price_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_product_rating_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_rating_create_dto(datajson json) RETURNS dto.product_rating_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_rating_create_dto;
begin
    dto.product_id = (dataJson ->> 'product_id')::integer;
    dto.views = (dataJson ->> 'views')::smallint;
    dto.purchased = (dataJson ->> 'purchased')::smallint;
    return dto;
end
$$;


ALTER FUNCTION mappers.to_product_rating_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_product_rating_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_product_rating_update_dto(datajson json) RETURNS dto.product_rating_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_rating_update_dto;
begin
    dto.product_id = (dataJson ->> 'product_id')::integer;
    dto.views = (dataJson ->> 'views')::smallint;
    dto.purchased = (dataJson ->> 'purchased')::smallint;
    return dto;
end
$$;


ALTER FUNCTION mappers.to_product_rating_update_dto(datajson json) OWNER TO postgres;

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
    dto.discount_percent = (data ->> 'discount_percent')::smallint;
    dto.extra = data -> 'extra';
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
-- Name: to_sponsor_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_sponsor_update_dto(data json) RETURNS dto.sponsor_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.sponsor_update_dto;
begin
    dto.id = (data ->> 'sponsor_id')::bigint;
    dto.name = data ->> 'name';
    dto.phone = data ->> 'phone';
    dto.email = data ->> 'email';
    dto.logo = data ->> 'logo';
    dto.location = data ->> 'location';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_sponsor_update_dto(data json) OWNER TO postgres;

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
-- Name: to_transaction_create_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_transaction_create_dto(datajson json) RETURNS dto.transaction_create_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.transaction_create_dto;
begin
    dto.user_id = (dataJson ->> 'user_id')::integer;
    dto.order_id = (dataJson ->> 'order_id')::integer;
    dto.type = dataJson ->> 'type';
    dto.status = dataJson ->> 'status';
    dto.quantity = dataJson ->> 'quantity';
    return dto;
end
$$;


ALTER FUNCTION mappers.to_transaction_create_dto(datajson json) OWNER TO postgres;

--
-- Name: to_transaction_status_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_transaction_status_update_dto(datajson json) RETURNS dto.transaction_status_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.transaction_status_update_dto;
begin
    dto.old_code = dataJson ->> 'old_code';
    dto.new_code = dataJson ->> 'new_code';
    dto.name = dataJson ->> 'name';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_transaction_status_update_dto(datajson json) OWNER TO postgres;

--
-- Name: to_transaction_type_update_dto(json); Type: FUNCTION; Schema: mappers; Owner: postgres
--

CREATE FUNCTION mappers.to_transaction_type_update_dto(datajson json) RETURNS dto.transaction_type_update_dto
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.transaction_type_update_dto;
begin
    dto.old_code = dataJson ->> 'old_code';
    dto.new_code = dataJson ->> 'new_code';
    dto.name = dataJson ->> 'name';
    return dto;
end;
$$;


ALTER FUNCTION mappers.to_transaction_type_update_dto(datajson json) OWNER TO postgres;

--
-- Name: basket_create(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.basket_create(data text, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id   integer;
    dataJson json;
    dto      dto.basket_create_dto;
begin
    call utils.check_data(data);
    dataJson := (data::json);
    call auth.is_active(p_user_id);
    dto = mappers.to_basket_create_dto(dataJson);
    call checks.check_basket_create_dto(dto);
    call auth.has_permission('CREATE_BASKET', p_user_id);

    insert into project.basket (user_id, order_id, product_id, product_count, total_price, created_by)
    values (dto.user_id, dto.order_id, dto.product_id, dto.product_count, dto.total_price, p_user_id)
    returning id into new_id;

    update project."order"
    set product_count = (product_count + dto.product_count),
        total_price   = ((total_price::decimal) + (dto.total_price::decimal)),
        updated_at    = now(),
        updated_by    = p_user_id
    where not is_deleted
      and id = dto.order_id;

    update project.product
    set count      = (count - dto.product_count),
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = dto.product_id;

    call settings.log_insert('project.basket_create(data text, p_user_id integer)');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION project.basket_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: basket_delete(integer, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.basket_delete(p_basket_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_basket project.basket%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_BASKET', p_user_id);

    select * into t_basket from project.basket where not is_deleted and id = p_basket_id;
    if not FOUND then
        raise exception '%', settings.translate('BASKET_NOT_FOUND', 'UZ');
    end if;

    update project.basket
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_basket.id;

    call settings.log_insert('project.basket_delete(p_basket_id integer, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.basket_delete(p_basket_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: basket_get(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.basket_get(p_basket_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_basket    jsonb;
    v_order     jsonb;
    t_basket    project.basket%rowtype;
    t_order     project."order"%rowtype;
    t_product   project.product%rowtype;
    t_auth_user auth.auth_user%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('GET_BASKET', p_user_id);
    select * into t_basket from project.basket where not is_deleted and id = p_basket_id;

    if not FOUND then
        raise exception '%', settings.translate('BASKET_NOT_FOUND', 'UZ');
    end if;

    select * into t_auth_user from auth.auth_user where not is_deleted and id = t_basket.user_id;
    if FOUND then
        v_basket = jsonb_build_object('user', (auth.auth_user_get(t_auth_user.code)::jsonb));
    else
        v_basket = jsonb_build_object('user_id', t_basket.user_id);
    end if;

    select * into t_order from project."order" where not is_deleted and id = t_basket.order_id;
    if FOUND then
        v_order = jsonb_build_object('type', t_order.type);
        v_order = v_order || jsonb_build_object('status', t_order.status);
        v_order = v_order || jsonb_build_object('created_at', t_order.created_at);
        v_order = v_order || jsonb_build_object('product_count', t_order.product_count);
        v_order = v_order || jsonb_build_object('total_price', t_order.total_price);
        v_basket = v_basket || jsonb_build_object('order', v_order);
    else
        v_basket = v_basket || jsonb_build_object('order_id', t_basket.order_id);
    end if;

    select * into t_product from project.product where not is_deleted and id = t_basket.product_id;
    if FOUND then
        v_basket = v_basket ||
                   jsonb_build_object('product', (project.product_detail(t_product.id, p_user_id)::jsonb));
    else
        v_basket = v_basket || jsonb_build_object('product_id', t_basket.product_id);
    end if;

    v_basket = v_basket || jsonb_build_object('product_count', t_basket.product_count);
    v_basket = v_basket || jsonb_build_object('total_price', t_basket.total_price);
    v_basket = v_basket || jsonb_build_object('created_at', t_basket.created_at);

    call settings.log_insert('project.basket_get(p_basket_id integer, p_user_id integer) returns text');
    return (v_basket::text);
end
$$;


ALTER FUNCTION project.basket_get(p_basket_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: basket_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.basket_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_baskets jsonb default '[]';
    t_basket  project.basket%rowtype;

begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_BASKET', p_user_id);

    for t_basket in (select * from project.basket where not is_deleted)
        loop
            v_baskets = v_baskets || (project.basket_get(t_basket.id, p_user_id)::jsonb);
        end loop;

    call settings.log_insert('project.basket_list(p_user_id integer) returns text');
    return (v_baskets::text);
end;
$$;


ALTER FUNCTION project.basket_list(p_user_id integer) OWNER TO postgres;

--
-- Name: basket_my_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.basket_my_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_baskets jsonb = '[]';
    t_basket  project.basket%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('MY_LIST_BASKET', p_user_id);

    for t_basket in (select * from project.basket where not is_deleted and user_id = p_user_id)
        loop
            v_baskets = v_baskets || (project.basket_get(t_basket.id, p_user_id)::jsonb);
        end loop;

    call settings.log_insert('project.basket_my_list(p_user_id integer) returns text');
    return (v_baskets::text);
end;
$$;


ALTER FUNCTION project.basket_my_list(p_user_id integer) OWNER TO postgres;

--
-- Name: basket_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.basket_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json;
    dto      dto.basket_update_dto;
begin
    call utils.check_data(data);
    dataJson := (data::json);
    call auth.is_active(p_user_id);
    dto = mappers.to_basket_update_dto(dataJson);
    call checks.check_basket_update_dto(dto);
    call auth.has_permission('UPDATE_BASKET', p_user_id);

    update project.basket
    set product_count = dto.product_count,
        total_price   = dto.total_price,
        updated_at    = now(),
        updated_by    = p_user_id
    where not is_deleted
      and id = dto.id;

    call settings.log_insert('project.basket_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.basket_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: category_create(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.category_create(data text, p_user_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
    new_id integer;
    dto    dto.category_create_dto;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CREATE_CATEGORY', p_user_id);
    call utils.check_data(data);
    dto = mappers.to_category_create_dto(data::json);
    call checks.check_category_create_dto(dto);

    insert into project.category (title, code, category_pic, description, created_by)
    values (dto.title, dto.code, dto.pic, dto.description, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.category_create(data text, p_user_id integer) returns varchar');
    return 'id = ' || new_id;
end
$$;


ALTER FUNCTION project.category_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: category_delete(character varying, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.category_delete(category_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_category project.category%rowtype;
begin
    if category_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_CATEGORY', p_user_id);

    select * into t_category from project.category where not is_deleted and code = category_code and parent_id IS NULL;
    if not FOUND then
        raise exception '%', settings.translate('CATEGORY_NOT_FOUND', 'UZ');
    end if;

    update project.category
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_category.code;

    call settings.log_insert('project.category_delete(category_code varchar, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.category_delete(category_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: category_detail(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.category_detail(p_category_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_child_list   jsonb default '[]';
    v_product_list jsonb default '[]';
    v_child        jsonb;
    v_parent       jsonb;
    v_category     jsonb;
    t_category     project.category%rowtype;
    t_parent       project.category%rowtype;
    t_child        project.category%rowtype;
    t_product      project.product%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DETAIL_CATEGORY', p_user_id);

    select * into t_category from project.category where not is_deleted and id = p_category_id;
    if not FOUND then
        raise exception '%', settings.translate('CATEGORY_NOT_FOUND', 'UZ');
    end if;

    v_category = jsonb_build_object('title', t_category.title);
    v_category = v_category || jsonb_build_object('code', t_category.code);

    select * into t_parent from project.category where not is_deleted and id = t_category.parent_id;
    if FOUND then
        v_parent = jsonb_build_object('title', t_parent.title);
        v_parent = v_parent || jsonb_build_object('code', t_parent.code);
        v_parent = v_parent || jsonb_build_object('pic', t_parent.category_pic);
        v_parent = v_parent || jsonb_build_object('description', t_parent.description);
        v_parent = v_parent || jsonb_build_object('created_at', t_parent.created_at);
    end if;
    v_category = v_category || jsonb_build_object('parent', v_parent);
    
    for t_child in (select * from project.category where not is_deleted and parent_id = t_category.id)
        loop
            v_child = jsonb_build_object('title', t_child.title);
            v_child = v_child || jsonb_build_object('code', t_child.code);
            v_child = v_child || jsonb_build_object('pic', t_child.category_pic);
            v_child = v_child || jsonb_build_object('description', t_child.description);
            v_child = v_child || jsonb_build_object('created_at', t_child.created_at);
            v_child_list = v_child_list || v_child;
        end loop;

    v_category = v_category || jsonb_build_object('child', v_child_list);

    for t_product in (select * from project.product where not is_deleted and product.category_id = t_category.id)
        loop
            v_product_list = v_product_list || (project.product_get(t_product.id, p_user_id)::jsonb);
        end loop;

    v_category = v_category || jsonb_build_object('product', v_product_list);
    v_category = v_category || jsonb_build_object('pic', t_category.category_pic);
    v_category = v_category || jsonb_build_object('description', t_category.description);
    v_category = v_category || jsonb_build_object('created_at', t_category.created_at);

    call settings.log_insert('project.category_get(p_category_id integer, p_user_id integer) returns text');
    return (v_category::text);
end;
$$;


ALTER FUNCTION project.category_detail(p_category_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: category_get(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.category_get(p_category_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_category jsonb;
    t_category project.category%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('GET_CATEGORY', p_user_id);

    select * into t_category from project.category where not is_deleted and id = p_category_id;
    if not FOUND then
        raise exception '%', settings.translate('CATEGORY_NOT_FOUND', 'UZ');
    end if;
    
    v_category = jsonb_build_object('title', t_category.title);
    v_category = v_category || jsonb_build_object('code', t_category.code);
    v_category = v_category || jsonb_build_object('pic', t_category.category_pic);
    v_category = v_category || jsonb_build_object('description', t_category.description);
    v_category = v_category || jsonb_build_object('created_at', t_category.created_at);

    call settings.log_insert('project.category_get(p_category_id integer, p_user_id integer) returns text');
    return (v_category::text);
end;
$$;


ALTER FUNCTION project.category_get(p_category_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: category_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.category_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_category jsonb;
    v_result   jsonb = '[]';
    t_category project.category%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_CATEGORY', p_user_id);

    for t_category in (select * from project.category where not is_deleted and parent_id is null)
        loop
            v_category = jsonb_build_object('title', t_category.title);
            v_category = v_category || jsonb_build_object('code', t_category.code);
            v_category = v_category || jsonb_build_object('category_pic', t_category.category_pic);
            v_category = v_category || jsonb_build_object('description', t_category.description);
            v_category = v_category || jsonb_build_object('created_at', t_category.created_at);
            v_result = v_result || v_category;
        end loop;

    call settings.log_insert('project.category_list(p_user_id integer) returns text');
    return v_result::text;
end
$$;


ALTER FUNCTION project.category_list(p_user_id integer) OWNER TO postgres;

--
-- Name: category_sub_create(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.category_sub_create(data text, p_user_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
    new_id integer;
    dto    dto.category_sub_create_dto;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('CREATE_CATEGORY_SUB', p_user_id);
    call utils.check_data(data);
    dto = mappers.to_category_sub_create_dto(data::json);
    call checks.check_category_sub_create_dto(dto);

    insert into project.category (parent_id, title, code, category_pic, description, created_by)
    values (dto.parent_id, dto.title, dto.code, dto.pic, dto.description, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.category_sub_create(data text, p_user_id integer) returns varchar');
    return 'id = ' || new_id;
end
$$;


ALTER FUNCTION project.category_sub_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: category_sub_delete(integer, character varying, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.category_sub_delete(p_parent_id integer, category_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_category project.category%rowtype;
begin
    if (category_code is null or p_parent_id is null) then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_CATEGORY_SUB', p_user_id);

    select *
    into t_category
    from project.category
    where not is_deleted
      and code = category_code
      and parent_id = p_parent_id;
    if not FOUND then
        raise exception '%', settings.translate('SUB_CATEGORY_NOT_FOUND', 'UZ');
    end if;

    update project.category
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_category.id;

    call settings.log_insert('project.category_sub_delete(p_parent_id integer, category_code varchar, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.category_sub_delete(p_parent_id integer, category_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: category_sub_list(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.category_sub_list(p_category_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_category jsonb;
    v_result   jsonb = '[]';
    t_category project.category%rowtype;
begin
    if p_category_id is null then
        raise exception '%',settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_CATEGORY_SUB', p_user_id);

    for t_category in (select * from project.category where not is_deleted and parent_id = p_category_id)
        loop
            v_category = jsonb_build_object('title', t_category.title);
            v_category = v_category || jsonb_build_object('code', t_category.code);
            v_category = v_category || jsonb_build_object('category_pic', t_category.category_pic);
            v_category = v_category || jsonb_build_object('description', t_category.description);
            v_category = v_category || jsonb_build_object('created_at', t_category.created_at);
            v_result = v_result || v_category;
        end loop;

    call settings.log_insert('project.category_sub_list(p_category_id integer, p_user_id integer) returns text');
    return v_result::text;
end
$$;


ALTER FUNCTION project.category_sub_list(p_category_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: category_sub_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.category_sub_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json;
    dto      dto.category_sub_update_dto;
begin
    call utils.check_data(data);
    dataJson := (data::json);
    call auth.is_active(p_user_id);
    dto = mappers.to_category_sub_update_dto(dataJson);
    call checks.check_category_sub_update_dto(dto);
    call auth.has_permission('UPDATE_CATEGORY_SUB', p_user_id);

    update project.category
    set parent_id    = dto.parent_id,
        title        = dto.title,
        description  = dto.description,
        code         = dto.code,
        category_pic = dto.pic
    where not is_deleted
      and id = dto.id;

    call settings.log_insert('project.category_sub_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.category_sub_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: category_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.category_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json;
    dto      dto.category_update_dto;
begin
    call utils.check_data(data);
    dataJson := (data::json);
    call auth.is_active(p_user_id);
    dto = mappers.to_category_update_dto(dataJson);
    call checks.check_category_update_dto(dto);
    call auth.has_permission('UPDATE_CATEGORY', p_user_id);

    update project.category
    set title        = dto.title,
        description  = dto.description,
        code         = dto.code,
        category_pic = dto.pic
    where not is_deleted
      and id = dto.id;

    call settings.log_insert('project.category_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.category_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: like_dislike(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.like_dislike(data text, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id integer;
    dto    dto.like_dislike_dto;
    t_like project.like%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIKE_DISLIKE', p_user_id);
    call utils.check_data(data);
    dto = mappers.to_like_dislike_dto(data::json);
    call checks.check_like_dislike_dto(dto);

    select *
    into t_like
    from project.like
    where not is_deleted
      and user_id = dto.user_id
      and product_id = dto.product_id;

    if FOUND then
        update project.like
        set is_deleted = true,
            updated_at = now(),
            updated_by = p_user_id
        where not is_deleted
          and id = t_like.id;
        new_id = t_like.id;
    else
        insert into project.like (user_id, product_id, created_by)
        values (dto.user_id, dto.product_id, p_user_id)
        returning id into new_id;
    end if;

    call settings.log_insert('project.like_add(data text, p_user_id integer) returns text');
    return 'id = ' || new_id;
end
$$;


ALTER FUNCTION project.like_dislike(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: like_product(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.like_product(p_product_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_like       jsonb;
    v_like_count integer;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIKE_PRODUCT', p_user_id);

    v_like_count = (select count(*) from project.like where not is_deleted and product_id = p_product_id);
    v_like = jsonb_build_object('count', v_like_count);

    call settings.log_insert('project.like_product(p_product_id integer, p_user_id integer) returns text');
    return (v_like::text);
end
$$;


ALTER FUNCTION project.like_product(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: like_user(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.like_user(p_like_user_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_like  jsonb;
    v_likes jsonb default '[]';
    t_like  project.like%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIKE_USER', p_user_id);

    for t_like in (select * from project.like where not is_deleted and user_id = p_like_user_id)
        loop
            v_like = jsonb_build_object('created_at', t_like.created_at);
            v_like = v_like || jsonb_build_object('product', project.product_get(t_like.product_id, p_user_id)::jsonb);
            v_likes = v_likes || v_like;
        end loop;

    call settings.log_insert('project.like_user(p_like_user_id integer, p_user_id integer) returns text');
    return (v_likes::text);
end
$$;


ALTER FUNCTION project.like_user(p_like_user_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: order_create(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.order_create(data text, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json;
    new_id   integer;
    dto      dto.order_create_dto;
begin
    call utils.check_data(data);
    dataJson := (data::json);
    call auth.is_active(p_user_id);
    dto = mappers.to_order_create_dto(dataJson);
    call checks.check_order_create_dto(dto);
    call auth.has_permission('CREATE_ORDER', p_user_id);

    insert into project.order (user_id, type, status, product_count, total_price, created_by, card_id)
    values (dto.user_id, dto.type, dto.status, dto.product_count, dto.total_price, p_user_id, dto.card_id)
    returning id into new_id;

    call settings.log_insert('project.order_create(data text, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION project.order_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: order_delete(integer, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.order_delete(p_order_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_order project.order%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_ORDER', p_user_id);

    select * into t_order from project.order where not is_deleted and id = p_order_id;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_NOT_FOUND', 'UZ');
    end if;

    update project.order
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_order.id;

    update project.basket
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and order_id = t_order.id;

    call settings.log_insert('project.order_delete(p_order_id integer, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.order_delete(p_order_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: order_detail(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.order_detail(p_order_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_baskets jsonb default '[]';
    v_order   jsonb;
    t_order   project.order%rowtype;
    t_basket  project.basket%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DETAIL_ORDER', p_user_id);

    select * into t_order from project.order where not is_deleted and id = p_order_id;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_NOT_FOUND', 'UZ');
    end if;

    v_order = jsonb_build_object('user', (select auth.auth_user_get(auth.user_id_by_code(t_order.user_id)))::jsonb);
    if t_order.card_id is not null then
        v_order = v_order || jsonb_build_object('card_id', (select auth.card_get(t_order.card_id, p_user_id))::jsonb);
    end if;
    v_order = v_order || jsonb_build_object('type', t_order.type);
    v_order = v_order || jsonb_build_object('status', t_order.status);

    for t_basket in (select * from project.basket where not is_deleted and order_id = t_order.id)
        loop
            v_baskets = v_baskets || (project.basket_get(t_basket.id, p_user_id))::jsonb;
        end loop;

    v_order = v_order || jsonb_build_object('basket', v_baskets);
    v_order = v_order || jsonb_build_object('product_count', t_order.product_count);
    v_order = v_order || jsonb_build_object('total_price', t_order.total_price);
    v_order = v_order || jsonb_build_object('created_at', t_order.created_at);

    call settings.log_insert('project.order_detail(p_order_id integer, p_user_id integer) returns text');
    return (v_order::text);
end;
$$;


ALTER FUNCTION project.order_detail(p_order_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: order_get(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.order_get(p_order_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_user_code uuid;
    v_order     jsonb;
    t_order     project.order%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('GET_ORDER', p_user_id);

    select * into t_order from project.order where not is_deleted and id = p_order_id;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_NOT_FOUND', 'UZ');
    end if;
    v_user_code = auth.user_code_by_id(t_order.user_id);
    v_order = jsonb_build_object('user', (select auth.auth_user_get(v_user_code))::jsonb);
    if t_order.card_id is not null then
        v_order = v_order || jsonb_build_object('card_id', (select auth.card_get(t_order.card_id, p_user_id))::jsonb);
    end if;
    v_order = v_order || jsonb_build_object('type', t_order.type);
    v_order = v_order || jsonb_build_object('status', t_order.status);
    v_order = v_order || jsonb_build_object('product_count', t_order.product_count);
    v_order = v_order || jsonb_build_object('total_price', t_order.total_price);
    v_order = v_order || jsonb_build_object('created_at', t_order.created_at);

    call settings.log_insert('project.order_get(p_order_id integer, p_user_id integer) returns text');
    return (v_order::text);
end;
$$;


ALTER FUNCTION project.order_get(p_order_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: order_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.order_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_orders jsonb default '[]';
    t_order  project.order%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_ORDER', p_user_id);

    for t_order in (select * from project.order where not is_deleted)
        loop
            v_orders = v_orders || (project.order_get(t_order.id, p_user_id)::jsonb);
        end loop;

    call settings.log_insert('project.order_list(p_user_id integer) returns text');
    return (v_orders::text);
end;
$$;


ALTER FUNCTION project.order_list(p_user_id integer) OWNER TO postgres;

--
-- Name: order_status_create(character varying, character varying, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.order_status_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id   integer;
    t_status project.order_status%rowtype;
begin
    if p_name is null or p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_ORDER_STATUS', p_user_id);

    select * into t_status from project.order_status where not is_deleted and code = p_code;
    if FOUND then
        raise exception '%', settings.translate('ORDER_STATUS_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into project.order_status (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.order_status_create(p_name character varying, p_code character varying, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION project.order_status_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: order_status_delete(character varying, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.order_status_delete(p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_status project.order_status%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_ORDER_STATUS', p_user_id);

    select * into t_status from project.order_status where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_STATUS_NOT_FOUND', 'UZ');
    end if;

    update project.order_status
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_status.code;

    call settings.log_insert('project.order_status_delete(p_code character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.order_status_delete(p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: order_status_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.order_status_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_status   jsonb;
    v_status_l jsonb = '[]';
    t_status   project.order_status%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_ORDER_STATUS', p_user_id);

    for t_status in (select * from project.order_status where not is_deleted)
        loop
            v_status = jsonb_build_object('name', t_status.name);
            v_status = v_status || jsonb_build_object('code', t_status.code);
            v_status = v_status || jsonb_build_object('created_at', t_status.created_at);
            v_status_l = v_status_l || v_status;
        end loop;

    call settings.log_insert('project.order_status_list(p_user_id integer) returns text');
    return (v_status_l::text);
end;
$$;


ALTER FUNCTION project.order_status_list(p_user_id integer) OWNER TO postgres;

--
-- Name: order_status_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.order_status_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json;
    t_status project.order_status%rowtype;
    dto      dto.order_status_update_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_order_status_update_dto(dataJson);
    call checks.check_order_status_update_dto(dto);
    call auth.has_permission('UPDATE_ORDER_STATUS', p_user_id);

    select * into t_status from project.order_status where not is_deleted and code = dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_STATUS_NOT_FOUND', 'UZ');
    end if;

    update project.order_status
    set name       = dto.name,
        code       = dto.new_code,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_status.code;

    call settings.log_insert('project.order_status_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.order_status_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: order_type_create(character varying, character varying, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.order_type_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id integer;
    t_type project.order_type%rowtype;
begin
    if p_name is null or p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_ORDER_TYPE', p_user_id);

    select * into t_type from project.order_type where not is_deleted and code = p_code;
    if FOUND then
        raise exception '%', settings.translate('ORDER_TYPE_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into project.order_type (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.order_type_create(p_name character varying, p_code character varying, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION project.order_type_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: order_type_delete(character varying, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.order_type_delete(p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_type project.order_type%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_ORDER_TYPE', p_user_id);

    select * into t_type from project.order_type where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_TYPE_NOT_FOUND', 'UZ');
    end if;

    update project.order_type
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_type.code;

    call settings.log_insert('project.order_type_delete(p_code character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.order_type_delete(p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: order_type_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.order_type_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_type   jsonb;
    v_type_l jsonb = '[]';
    t_type   project.order_type%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_ORDER_TYPE', p_user_id);

    for t_type in (select * from project.order_type where not is_deleted)
        loop
            v_type = jsonb_build_object('name', t_type.name);
            v_type = v_type || jsonb_build_object('code', t_type.code);
            v_type = v_type || jsonb_build_object('created_at', t_type.created_at);
            v_type_l = v_type_l || v_type;
        end loop;

    call settings.log_insert('project.order_type_list(p_user_id integer) returns text');
    return (v_type_l::text);
end;
$$;


ALTER FUNCTION project.order_type_list(p_user_id integer) OWNER TO postgres;

--
-- Name: order_type_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.order_type_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json;
    t_type   project.order_type%rowtype;
    dto      dto.order_type_update_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dataJson := (data::json);
    dto = mappers.to_order_type_update_dto(dataJson);
    call checks.check_order_type_update_dto(dto);
    call auth.has_permission('UPDATE_ORDER_TYPE', p_user_id);

    select * into t_type from project.order_type where not is_deleted and code = dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('ORDER_TYPE_NOT_FOUND', 'UZ');
    end if;

    update project.order_type
    set name       = dto.name,
        code       = dto.new_code,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_type.code;

    call settings.log_insert('project.order_type_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.order_type_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: order_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.order_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dataJson json;
    dto      dto.order_update_dto;
begin
    call utils.check_data(data);
    dataJson := (data::json);
    call auth.is_active(p_user_id);
    dto = mappers.to_order_update_dto(dataJson);
    call checks.check_order_update_dto(dto);
    call auth.has_permission('UPDATE_ORDER', p_user_id);

    update project.order
    set card_id       = dto.card_id,
        status        = dto.status,
        type          = dto.type,
        total_price   = dto.total_price,
        product_count = dto.product_count,
        updated_at    = now(),
        updated_by    = p_user_id
    where not is_deleted
      and id = dto.id;

    call settings.log_insert('project.order_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.order_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: product_comment_create(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_comment_create(data text, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id integer;
    dto    dto.product_comment_create_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_product_comment_create_dto((data::json));
    call checks.check_product_comment_create_dto(dto);
    call auth.has_permission('CREATE_PRODUCT_COMMENT', p_user_id);

    insert into project.product_comment (product_id, user_id, message, created_by)
    values (dto.product_id, dto.user_id, dto.message, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.product_price_update(data text, p_user_id integer)');
    return 'id = ' || new_id;
end
$$;


ALTER FUNCTION project.product_comment_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: product_comment_delete(integer, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_comment_delete(p_comment_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_product_comment project.product_comment%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT_COMMENT', p_user_id);

    select * into t_product_comment from project.product_comment where not is_deleted and id = p_comment_id;
    if not FOUND then
        raise exception '%', settings.translate('COMMENT_NOT_FOUND', 'UZ');
    end if;

    update project.product_comment
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_product_comment.id;

    call settings.log_insert('project.product_comment_delete(p_comment_id integer, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.product_comment_delete(p_comment_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_comment_get(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_comment_get(p_comment_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_user_code       uuid;
    v_comment         jsonb;
    t_product_comment project.product_comment%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('GET_PRODUCT_COMMENT', p_user_id);

    select * into t_product_comment from project.product_comment where not is_deleted and id = p_comment_id;
    if not FOUND then
        raise exception '%', settings.translate('COMMENT_NOT_FOUND', 'UZ');
    end if;

    v_user_code = (select auth.user_code_by_id(t_product_comment.user_id));
    v_comment = jsonb_build_object('message', t_product_comment.message);
    v_comment = v_comment || jsonb_build_object('user', auth.auth_user_get(v_user_code));
    v_comment = v_comment || jsonb_build_object('created_at', t_product_comment.created_at);
    v_comment = v_comment || jsonb_build_object('product',
                                                (select project.product_get(t_product_comment.product_id, p_user_id))::jsonb);

    call settings.log_insert('project.product_comment_get(p_comment_id integer, p_user_id integer) returns text');
    return (v_comment::text);
end
$$;


ALTER FUNCTION project.product_comment_get(p_comment_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_comment_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_comment_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_comment  jsonb;
    v_comments jsonb default '[]';
    t_comment  project.product_comment%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_PRODUCT_COMMENT', p_user_id);

    for t_comment in (select * from project.product_comment where not is_deleted)
        loop
            v_comment = (project.product_comment_get(t_comment.id, p_user_id));
            v_comments = v_comments || v_comment;
        end loop;

    call settings.log_insert('project.product_comment_list(p_user_id integer) returns text');
    return (v_comments::text);
end
$$;


ALTER FUNCTION project.product_comment_list(p_user_id integer) OWNER TO postgres;

--
-- Name: product_create(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_create(data text, p_user_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
    new_id  bigint;
    counter integer default 0;
    dto     dto.product_create_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_product_create_dto((data::json));
    call checks.check_product_create_dto(dto);
    call auth.has_permission('CREATE_PRODUCT', p_user_id);

    insert into project.product (category_id, title, code, count, color, width, height, country, date_of_manufacture,
                                 description, extra, created_by)
    values (dto.category_id, dto.title, dto.code, dto.count, dto.color, dto.width, dto.height, dto.country,
            (dto.date_of_manufacture)::timestamptz, dto.description, dto.extra, p_user_id)
    returning id into new_id;

    for counter in counter..json_array_length(dto.image) - 1
        loop
            insert into project.product_image (product_id, product_pic, created_by)
            values (new_id, json_array_element_text(dto.image, counter), p_user_id);
        end loop;

    insert into project.product_rating (product_id, views, purchased, created_by)
    values (new_id, 0, 0, p_user_id);

    insert into project.product_price (product_id, price, created_by) values (new_id, dto.price, p_user_id);

    call settings.log_insert('project.product_create(data text, p_user_id integer) returns varchar');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION project.product_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: product_delete(integer, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_delete(p_product_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_product project.product%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT', p_user_id);

    select * into t_product from project.product where not is_deleted and id = p_product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;

    update project.product
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_product.id;

    update project.product_price
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and product_id = t_product.id;

    update project.product_rating
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and product_id = t_product.id;

    update project.product_image
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and product_id = t_product.id;

    call settings.log_insert('project.project_delete(p_product_id integer, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.product_delete(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_detail(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_detail(p_product_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare

    v_product  jsonb;
    v_comment  jsonb;
    v_image    jsonb;
    v_images   jsonb default '[]';
    v_comments jsonb default '[]';
    t_rating   project.product_rating%rowtype;
    t_price    project.product_price%rowtype;
    t_product  project.product%rowtype;
    t_category project.category%rowtype;
    t_image    project.product_image%rowtype;
    t_comment  project.product_comment%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DETAIL_PRODUCT', p_user_id);

    select * into t_product from project.product where not is_deleted and id = p_product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;

    select * into t_category from project.category where not is_deleted and id = t_product.id;
    if FOUND then
        v_product = jsonb_build_object('category', (project.category_get(t_category.id, p_user_id)::json));
    else
        v_product = jsonb_build_object('category_id', t_product.category_id);
    end if;

    v_product = v_product || jsonb_build_object('title', t_product.title);
    v_product = v_product || jsonb_build_object('code', t_product.code);
    v_product = v_product || jsonb_build_object('count', t_product.count);
    v_product = v_product || jsonb_build_object('color', t_product.color);

    select *
    into t_price
    from project.product_price
    where not is_deleted
      and product_id = t_product.id
    limit 1;

    v_product = v_product || jsonb_build_object('price', t_price.price);
    v_product = v_product || jsonb_build_object('discount_percent', t_price.discount_percent);
    for t_comment in (select *
                      from project.product_comment
                      where not is_deleted
                        and product_id = t_product.id)
        loop
            v_comment = jsonb_build_object('user_id', t_comment.user_id);
            v_comment = v_comment || jsonb_build_object('message', t_comment.message);
            v_comment = v_comment || jsonb_build_object('created_at', t_comment.created_at);
            v_comments = v_comments || v_comment;
        end loop;
    v_product = v_product || jsonb_build_object('comments', v_comments);

    for t_image in (select * from project.product_image where not is_deleted and product_id = t_product.id)
        loop
            v_image = jsonb_build_object('pic', t_image.product_pic);
            v_image = v_image || jsonb_build_object('created_at', t_image.created_at);
            v_images = v_images || v_image;
        end loop;
    v_product = v_product || jsonb_build_object('images', v_images);

    select *
    into t_rating
    from project.product_rating
    where not is_deleted
      and product_id = t_product.id
    limit 1;

    v_product = v_product || jsonb_build_object('views', t_rating.views);
    v_product = v_product || jsonb_build_object('purchased', t_rating.purchased);
    v_product = v_product || jsonb_build_object('width', t_product.width);
    v_product = v_product || jsonb_build_object('height', t_product.height);
    v_product = v_product || jsonb_build_object('country', t_product.country);
    v_product = v_product || jsonb_build_object('date_of_manufacture', t_product.date_of_manufacture);
    v_product = v_product || jsonb_build_object('description', t_product.description);
    v_product = v_product || jsonb_build_object('extra', t_product.extra);
    v_product = v_product || jsonb_build_object('created_at', t_product.created_at);
    
    call settings.log_insert('product_detail(p_product_id integer, p_user_id integer) returns text');
    return (v_product::text);
end
$$;


ALTER FUNCTION project.product_detail(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_get(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_get(p_product_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_product  jsonb;
    v_image    jsonb;
    v_images   jsonb default '[]';
    t_rating   project.product_rating%rowtype;
    t_price    project.product_price%rowtype;
    t_product  project.product%rowtype;
    t_image    project.product_image%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('GET_PRODUCT', p_user_id);

    select * into t_product from project.product where not is_deleted and id = p_product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_NOT_FOUND', 'UZ');
    end if;

    v_product = jsonb_build_object('title', t_product.title);
    v_product = v_product || jsonb_build_object('code', t_product.code);
    v_product = v_product || jsonb_build_object('count', t_product.count);
    v_product = v_product || jsonb_build_object('color', t_product.color);

    select *
    into t_price
    from project.product_price
    where not is_deleted
      and product_id = t_product.id
    limit 1;

    v_product = v_product || jsonb_build_object('price', t_price.price);
    v_product = v_product || jsonb_build_object('discount_percent', t_price.discount_percent);

    for t_image in (select * from project.product_image where not is_deleted and product_id = t_product.id)
        loop
            v_image = jsonb_build_object('pic', t_image.product_pic);
            v_image = v_image || jsonb_build_object('created_at', t_image.created_at);
            v_images = v_images || v_image;
        end loop;
    v_product = v_product || jsonb_build_object('images', v_images);

    select *
    into t_rating
    from project.product_rating
    where not is_deleted
      and product_id = t_product.id
    limit 1;

    v_product = v_product || jsonb_build_object('views', t_rating.views);
    v_product = v_product || jsonb_build_object('purchased', t_rating.purchased);
    v_product = v_product || jsonb_build_object('width', t_product.width);
    v_product = v_product || jsonb_build_object('height', t_product.height);
    v_product = v_product || jsonb_build_object('country', t_product.country);
    v_product = v_product || jsonb_build_object('date_of_manufacture', t_product.date_of_manufacture);
    v_product = v_product || jsonb_build_object('description', t_product.description);
    v_product = v_product || jsonb_build_object('extra', t_product.extra);
    v_product = v_product || jsonb_build_object('created_at', t_product.created_at);
    
    call settings.log_insert('product_detail(p_product_id integer, p_user_id integer) returns text');
    return (v_product::text);
end
$$;


ALTER FUNCTION project.product_get(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_image_create(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_image_create(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    counter integer default 0;
    dto     dto.product_image_create_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_product_image_create_dto((data::json));
    call checks.check_product_image_create_dto(dto);
    call auth.has_permission('CREATE_PRODUCT_IMAGE', p_user_id);

    for counter in counter..json_array_length(dto.product_pic) - 1
        loop
            insert into project.product_image (product_id, product_pic, created_by)
            values (dto.product_id, json_array_element_text(dto.product_pic, counter), p_user_id);
        end loop;

    call settings.log_insert('project.product_image_create(data text, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.product_image_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: product_image_delete(integer, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_image_delete(p_image_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_image project.product_image%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT_IMAGE', p_user_id);

    select * into t_image from project.product_image where not is_deleted and id = p_image_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_IMAGE_NOT_FOUND', 'UZ');
    end if;

    update project.product_image
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_image.id;

    call settings.log_insert('project.product_image_delete(p_image_id integer, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.product_image_delete(p_image_id integer, p_user_id integer) OWNER TO postgres;

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
-- Name: product_image_get(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_image_get(p_product_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_product  jsonb;
    v_products jsonb;
    t_image    project.product_image%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('GET_PRODUCT_IMAGE', p_user_id);

    for t_image in (select * from project.product_image where not is_deleted and product_id = p_product_id)
        loop
            v_product = jsonb_build_object('product_pic', t_image.product_pic);
            v_product = v_product || jsonb_build_object('created_at', t_image.created_at);
            v_products = v_products || v_product;
        end loop;

    call settings.log_insert('project.product_image_get(p_product_id integer, p_user_id integer) returns text');
    return (v_products::text);
end
$$;


ALTER FUNCTION project.product_image_get(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_image_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_image_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_product  jsonb;
    v_products jsonb;
    t_image    project.product_image%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_PRODUCT_IMAGE', p_user_id);

    for t_image in (select * from project.product_image where not is_deleted)
        loop
            v_product = jsonb_build_object('product_id', t_image.product_id);
            v_product = v_product || jsonb_build_object('product_pic', t_image.product_pic);
            v_product = v_product || jsonb_build_object('created_at', t_image.created_at);
            v_products = v_products || v_product;
        end loop;

    call settings.log_insert('project.product_image_list(p_user_id integer) returns text');
    return (v_products::text);
end
$$;


ALTER FUNCTION project.product_image_list(p_user_id integer) OWNER TO postgres;

--
-- Name: product_image_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_image_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_image_update_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_product_image_update_dto((data::json));
    call checks.check_product_image_update_dto(dto);
    call auth.has_permission('UPDATE_PRODUCT_IMAGE', p_user_id);

    update project.product_image
    set product_pic = dto.product_pic,
        updated_at  = now(),
        updated_by  = p_user_id
    where not is_deleted
      and id = dto.id;

    call settings.log_insert('project.product_image_update(data text, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.product_image_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: product_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_product  jsonb;
    v_products jsonb default '[]';
    t_product  project.product%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_PRODUCT', p_user_id);

    for t_product in (select * from project.product where not is_deleted)
        loop
            v_product = project.product_get(t_product.id, p_user_id);
            v_products = v_products || v_product;
        end loop;

    call settings.log_insert('project.product_list(p_user_id integer) returns text');
    return (v_products::text);
end
$$;


ALTER FUNCTION project.product_list(p_user_id integer) OWNER TO postgres;

--
-- Name: product_price_create(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_price_create(data text, p_user_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
    new_id  integer;
    t_price project.product_price%rowtype;
    dto     dto.product_price_create_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_product_price_create_dto((data::json));
    call checks.check_product_price_create_dto(dto);
    call auth.has_permission('CREATE_PRODUCT_PRICE', p_user_id);

    select * into t_price from project.product_price where not is_deleted and product_id = dto.product_id;
    if FOUND then
        raise exception '%', settings.translate('PRODUCT_ID_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into project.product_price (product_id, price, discount_percent, created_by)
    values (dto.product_id, dto.price, dto.discount_percent, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.product_price_create(data text, p_user_id integer) returns varchar');
    return 'id = ' || new_id;
end
$$;


ALTER FUNCTION project.product_price_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: product_price_delete(integer, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_price_delete(p_product_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_price project.product_price%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT_PRICE', p_user_id);

    select * into t_price from project.product_price where not is_deleted and product_id = p_product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_PRICE_NOT_FOUND', 'UZ');
    end if;

    update project.product_price
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_price.id;

    call settings.log_insert('project.product_price_delete(p_product_id integer, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.product_price_delete(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_price_get(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_price_get(p_product_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_price jsonb;
    t_price project.product_price%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('GET_PRODUCT_PRICE', p_user_id);

    select * into t_price from project.product_price where not is_deleted and product_id = p_product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_PRICE_NOT_FOUND', 'UZ');
    end if;

    v_price = jsonb_build_object('price', t_price.price);
    v_price = v_price || jsonb_build_object('discount_percent', t_price.discount_percent);
    v_price = v_price || jsonb_build_object('product_id', p_product_id);
    v_price = v_price || jsonb_build_object('created_at', t_price.created_at);

    call settings.log_insert('project.product_price_get(p_product_id integer, p_user_id integer) returns text');
    return (v_price::text);
end
$$;


ALTER FUNCTION project.product_price_get(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_price_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_price_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_price   jsonb;
    v_price_l jsonb default '[]';
    t_price   project.product_price%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_PRODUCT_PRICE', p_user_id);

    for t_price in (select * from project.product_price where not is_deleted)
        loop
            v_price = (project.product_price_get(t_price.product_id, p_user_id))::jsonb;
            v_price_l = v_price_l || v_price;
        end loop;

    call settings.log_insert('project.product_price_list(p_user_id integer) returns text');
    return (v_price_l::text);
end
$$;


ALTER FUNCTION project.product_price_list(p_user_id integer) OWNER TO postgres;

--
-- Name: product_price_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_price_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_price_update_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_product_price_update_dto((data::json));
    call checks.check_product_price_update_dto(dto);
    call auth.has_permission('UPDATE_PRODUCT_PRICE', p_user_id);

    update project.product_price
    set price            = dto.price,
        discount_percent = dto.discount_percent,
        updated_at       = now(),
        updated_by       = p_user_id
    where not is_deleted
      and product_id = dto.product_id;

    call settings.log_insert('project.product_price_update(data text, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.product_price_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: product_rating_create(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_rating_create(data text, p_user_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
    new_id           integer;
    dto              dto.product_rating_create_dto;
    t_product_rating project.product_rating%rowtype;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_product_rating_create_dto((data::json));
    call checks.check_product_rating_create_dto(dto);
    call auth.has_permission('CREATE_PRODUCT_RATING', p_user_id);

    select * into t_product_rating from project.product_rating where not is_deleted and product_id = dto.product_id;
    if FOUND then
        raise exception '%', settings.translate('PRODUCT_ID_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into project.product_rating (product_id, views, purchased, created_by)
    values (dto.product_id, dto.views, dto.purchased, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.product_rating_create(data text, p_user_id integer) returns varchar');
    return 'id = ' || new_id;
end
$$;


ALTER FUNCTION project.product_rating_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: product_rating_delete(integer, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_rating_delete(p_product_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_rating project.product_rating%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_PRODUCT_RATING', p_user_id);

    select * into t_rating from project.product_rating where not is_deleted and product_id = p_product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_RATING_NOT_FOUND', 'UZ');
    end if;

    update project.product_rating
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_rating.id;

    call settings.log_insert('project.product_rating_delete(p_product_id integer, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.product_rating_delete(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_rating_get(integer, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_rating_get(p_product_id integer, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_rating jsonb;
    t_rating project.product_rating%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('GET_PRODUCT_RATING', p_user_id);

    select * into t_rating from project.product_rating where not is_deleted and product_id = p_product_id;
    if not FOUND then
        raise exception '%', settings.translate('PRODUCT_RATING_NOT_FOUND', 'UZ');
    end if;

    v_rating = jsonb_build_object('views', t_rating.views);
    v_rating = v_rating || jsonb_build_object('purchased', t_rating.purchased);
    v_rating = v_rating || jsonb_build_object('product_id', p_product_id);
    v_rating = v_rating || jsonb_build_object('created_at', t_rating.created_at);

    call settings.log_insert('project.product_rating_get(p_product_id integer, p_user_id integer) returns text');
    return (v_rating::text);
end
$$;


ALTER FUNCTION project.product_rating_get(p_product_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: product_rating_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.product_rating_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_rating   jsonb;
    v_rating_l jsonb default '[]';
    t_rating   project.product_rating%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_PRODUCT_RATING', p_user_id);

    for t_rating in (select * from project.product_rating where not is_deleted)
        loop
            v_rating = (project.product_rating_get(t_rating.product_id, p_user_id))::jsonb;
            v_rating_l = v_rating_l || v_rating;
        end loop;

    call settings.log_insert('project.product_rating_list(p_user_id integer) returns text');
    return (v_rating_l::text);
end
$$;


ALTER FUNCTION project.product_rating_list(p_user_id integer) OWNER TO postgres;

--
-- Name: product_rating_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_rating_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.product_rating_update_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_product_rating_update_dto((data::json));
    call checks.check_product_rating_update_dto(dto);
    call auth.has_permission('UPDATE_PRODUCT_RATING', p_user_id);

    update project.product_rating
    set views      = dto.views,
        purchased  = dto.purchased,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and product_id = dto.product_id;

    call settings.log_insert('project.product_rating_update(data text, p_user_id integer)');
end
$$;


ALTER PROCEDURE project.product_rating_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: product_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.product_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto      dto.product_update_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_product_update_dto((data::json));
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
        extra               = dto.extra
    where not is_deleted
      and id = dto.id;

    update project.product_price
    set price            = dto.price,
        discount_percent = dto.discount_percent,
        updated_at       = now(),
        updated_by       = p_user_id
    where not is_deleted
      and product_id = dto.id;

    call settings.log_insert('project.product_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.product_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_create(text, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.transaction_create(data text, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id integer;
    dto    dto.transaction_create_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_transaction_create_dto((data::json));
    call checks.check_transaction_create_dto(dto);
    call auth.has_permission('CREATE_TRANSACTION', p_user_id);

    insert into project.transaction (user_id, order_id, type, status, quantity, created_by)
    values (dto.user_id, dto.order_id, dto.type, dto.status, dto.quantity, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.transaction_create(data text, p_user_id integer) returns text');
    return 'id = ' || new_id;
end
$$;


ALTER FUNCTION project.transaction_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.transaction_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_user_code    uuid;
    v_transaction  jsonb;
    v_transactions jsonb default '[]';
    t_transaction  project.transaction%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_TRANSACTION', p_user_id);

    for t_transaction in (select * from project.transaction where not is_deleted)
        loop
            v_user_code = auth.user_code_by_id(t_transaction.user_id);
            v_transaction = jsonb_build_object('type', t_transaction.type);

            v_transaction = v_transaction ||
                            jsonb_build_object('user', (select auth.auth_user_get(v_user_code))::jsonb);

            v_transaction = v_transaction ||
                            jsonb_build_object('order',
                                               (select project.order_get(t_transaction.order_id, p_user_id))::jsonb);
            v_transaction = v_transaction || jsonb_build_object('status', t_transaction.status);
            v_transaction = v_transaction || jsonb_build_object('quantity', t_transaction.quantity);
            v_transaction = v_transaction || jsonb_build_object('created_at', t_transaction.created_at);
            v_transactions = v_transactions || v_transaction;
        end loop;

    call settings.log_insert('project.transaction_list(p_user_id integer) returns text');
    return (v_transactions::text);
end
$$;


ALTER FUNCTION project.transaction_list(p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_status_create(character varying, character varying, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.transaction_status_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id   integer;
    t_status project.transaction_status%rowtype;
begin
    if p_name is null or p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_TRANSACTION_STATUS', p_user_id);

    select * into t_status from project.transaction_status where not is_deleted and code = p_code;
    if FOUND then
        raise exception '%', settings.translate('TRANSACTION_STATUS_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into project.transaction_status (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.transaction_status_create(p_name character varying, p_code character varying, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION project.transaction_status_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_status_delete(character varying, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.transaction_status_delete(p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_status project.transaction_status%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_TRANSACTION_STATUS', p_user_id);

    select * into t_status from project.transaction_status where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('TRANSACTION_STATUS_NOT_FOUND', 'UZ');
    end if;

    update project.transaction_status
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_status.code;

    call settings.log_insert('project.transaction_status_delete(p_code character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.transaction_status_delete(p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_status_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.transaction_status_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_status   jsonb;
    v_status_l jsonb = '[]';
    t_status   project.transaction_status%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_TRANSACTION_STATUS', p_user_id);

    for t_status in (select * from project.transaction_status where not is_deleted)
        loop
            v_status = jsonb_build_object('name', t_status.name);
            v_status = v_status || jsonb_build_object('code', t_status.code);
            v_status = v_status || jsonb_build_object('created_at', t_status.created_at);
            v_status_l = v_status_l || v_status;
        end loop;

    call settings.log_insert('project.transaction_status_list(p_user_id integer) returns text');
    return (v_status_l::text);
end;
$$;


ALTER FUNCTION project.transaction_status_list(p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_status_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.transaction_status_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto      dto.transaction_status_update_dto;
    t_status project.transaction_status%rowtype;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_transaction_status_update_dto((data::json));
    call checks.check_transaction_status_update_dto(dto);
    call auth.has_permission('UPDATE_TRANSACTION_STATUS', p_user_id);

    select * into t_status from project.transaction_status where not is_deleted and code = dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('TRANSACTION_STATUS_NOT_FOUND', 'UZ');
    end if;

    update project.transaction_status
    set name       = dto.name,
        code       = dto.new_code,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_status.code;

    call settings.log_insert('project.transaction_status_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.transaction_status_update(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_type_create(character varying, character varying, integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.transaction_type_create(p_name character varying, p_code character varying, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id   integer;
    t_type project.transaction_type%rowtype;
begin
    if p_name is null or p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('ADD_TRANSACTION_TYPE', p_user_id);

    select * into t_type from project.transaction_type where not is_deleted and code = p_code;
    if FOUND then
        raise exception '%', settings.translate('TRANSACTION_TYPE_CODE_IS_ALREADY_TAKEN', 'UZ');
    end if;

    insert into project.transaction_type (name, code, created_by)
    values (p_name, p_code, p_user_id)
    returning id into new_id;

    call settings.log_insert('project.transaction_type_create(p_name character varying, p_code character varying, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION project.transaction_type_create(p_name character varying, p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_type_delete(character varying, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.transaction_type_delete(p_code character varying, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_type project.transaction_type%rowtype;
begin
    if p_code is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_TRANSACTION_TYPE', p_user_id);

    select * into t_type from project.transaction_type where not is_deleted and code = p_code;
    if not FOUND then
        raise exception '%', settings.translate('TRANSACTION_TYPE_NOT_FOUND', 'UZ');
    end if;

    update project.transaction_type
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_type.code;

    call settings.log_insert('project.transaction_type_delete(p_code character varying, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.transaction_type_delete(p_code character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_type_list(integer); Type: FUNCTION; Schema: project; Owner: postgres
--

CREATE FUNCTION project.transaction_type_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_type   jsonb;
    v_type_l jsonb = '[]';
    t_type   project.transaction_type%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_TRANSACTION_TYPE', p_user_id);

    for t_type in (select * from project.transaction_type where not is_deleted)
        loop
            v_type = jsonb_build_object('name', t_type.name);
            v_type = v_type || jsonb_build_object('code', t_type.code);
            v_type = v_type || jsonb_build_object('created_at', t_type.created_at);
            v_type_l = v_type_l || v_type;
        end loop;

    call settings.log_insert('project.transaction_type_list(p_user_id integer) returns text');
    return (v_type_l::text);
end;
$$;


ALTER FUNCTION project.transaction_type_list(p_user_id integer) OWNER TO postgres;

--
-- Name: transaction_type_update(text, integer); Type: PROCEDURE; Schema: project; Owner: postgres
--

CREATE PROCEDURE project.transaction_type_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto    dto.transaction_type_update_dto;
    t_type project.transaction_type%rowtype;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    dto = mappers.to_transaction_type_update_dto((data::json));
    call checks.check_transaction_type_update_dto(dto);
    call auth.has_permission('UPDATE_TRANSACTION_TYPE', p_user_id);

    select * into t_type from project.transaction_type where not is_deleted and code = dto.old_code;
    if not FOUND then
        raise exception '%', settings.translate('TRANSACTION_TYPE_NOT_FOUND', 'UZ');
    end if;

    update project.transaction_type
    set name       = dto.name,
        code       = dto.new_code,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and code = t_type.code;

    call settings.log_insert('project.transaction_type_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE project.transaction_type_update(data text, p_user_id integer) OWNER TO postgres;

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
    new_id integer;
begin
    call auth.is_active(p_user_id);
    if p_message is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    insert into system.comment (user_id, message, created_by)
    values (p_user_id, p_message, p_user_id)
    returning id into new_id;

    call settings.log_insert('system.comment_create(p_message varchar, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION system.comment_create(p_message character varying, p_user_id integer) OWNER TO postgres;

--
-- Name: comment_delete(integer, integer); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.comment_delete(comment_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_comment system.comment%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_COMMENT_SYSTEM', p_user_id);

    if comment_id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_comment from system.comment where not is_deleted and id = comment_id;
    if not FOUND then
        raise exception '%', settings.translate('SYSTEM_COMMENT_NOT_FOUND', 'UZ');
    end if;

    update system.comment
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_comment.id;
    call settings.log_insert('system.comment_delete(comment_id integer, p_user_id integer)');
end;
$$;


ALTER PROCEDURE system.comment_delete(comment_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: comment_list(integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.comment_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_comment  jsonb;
    v_comments jsonb default '[]';
    t_comment   system.comment%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_COMMENT_SYSTEM', p_user_id);

    for t_comment in (select * from system.comment where not is_deleted)
        loop
            v_comment = jsonb_build_object('user_id', t_comment.user_id);
            v_comment = v_comment || jsonb_build_object('message', t_comment.message);
            v_comment = v_comment || jsonb_build_object('created_at', t_comment.created_at);
            v_comments = v_comments || v_comment;
        end loop;

    call settings.log_insert('system.comment_list(p_user_id integer) returns text');
    return (v_comments::text);
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
-- Name: sponsor_create(text, integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.sponsor_create(data text, p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    new_id integer;
    dto    dto.sponsor_create_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    call auth.has_permission('CREATE_SPONSOR', p_user_id);
    dto = mappers.to_sponsor_create_dto((data::json));
    call checks.check_sponsor_create_dto(dto);

    insert into system.sponsors (name, phone, email, logo, location, created_by)
    values (dto.name, dto.phone, dto.email, dto.logo, dto.location, p_user_id)
    returning id into new_id;

    call settings.log_insert('system.sponsor_create(data text, p_user_id integer) returns text');
    return 'id = ' || new_id;
end;
$$;


ALTER FUNCTION system.sponsor_create(data text, p_user_id integer) OWNER TO postgres;

--
-- Name: sponsor_delete(integer, integer); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.sponsor_delete(p_sponsor_id integer, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    t_sponsor system.sponsors%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('DELETE_SPONSOR', p_user_id);

    if p_sponsor_id is null then
        raise exception '%', settings.translate('INVALID_PARAMETER', 'UZ');
    end if;

    select * into t_sponsor from system.sponsors where not is_deleted and id = p_sponsor_id;
    if not FOUND then
        raise exception '%', settings.translate('SPONSOR_NOT_FOUND', 'UZ');
    end if;

    update system.sponsors
    set is_deleted = true,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = t_sponsor.id;
    call settings.log_insert('system.sponsor_delete(p_sponsor_id integer, p_user_id integer)');
end;
$$;


ALTER PROCEDURE system.sponsor_delete(p_sponsor_id integer, p_user_id integer) OWNER TO postgres;

--
-- Name: sponsor_list(integer); Type: FUNCTION; Schema: system; Owner: postgres
--

CREATE FUNCTION system.sponsor_list(p_user_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    v_sponsor  jsonb;
    v_sponsors jsonb default '[]';
    t_sponsor  system.sponsors%rowtype;
begin
    call auth.is_active(p_user_id);
    call auth.has_permission('LIST_SPONSOR', p_user_id);

    for t_sponsor in (select * from system.sponsors where not is_deleted)
        loop
            v_sponsor = json_build_object('name', t_sponsor.name);
            v_sponsor = v_sponsor || json_build_object('phone', t_sponsor.phone);
            v_sponsor = v_sponsor || json_build_object('email', t_sponsor.email);
            v_sponsor = v_sponsor || json_build_object('logo', t_sponsor.logo);
            v_sponsor = v_sponsor || json_build_object('location', t_sponsor.location);
            v_sponsors = v_sponsors || v_sponsor;
        end loop;

    call settings.log_insert('system.sponsor_list(p_user_id integer)');
    return (v_sponsors::text);
end;
$$;


ALTER FUNCTION system.sponsor_list(p_user_id integer) OWNER TO postgres;

--
-- Name: sponsor_update(text, integer); Type: PROCEDURE; Schema: system; Owner: postgres
--

CREATE PROCEDURE system.sponsor_update(data text, p_user_id integer)
    LANGUAGE plpgsql
    AS $$
declare
    dto dto.sponsor_update_dto;
begin
    call utils.check_data(data);
    call auth.is_active(p_user_id);
    call auth.has_permission('UPDATE_SPONSOR', p_user_id);
    dto = mappers.to_sponsor_update_dto((data::json));
    call checks.check_sponsor_update_dto(dto);

    update system.sponsors
    set name       = dto.name,
        phone      = dto.phone,
        email      = dto.email,
        logo       = dto.logo,
        location   = dto.location,
        updated_at = now(),
        updated_by = p_user_id
    where not is_deleted
      and id = dto.id;

    call settings.log_insert('system.sponsor_update(data text, p_user_id integer)');
end;
$$;


ALTER PROCEDURE system.sponsor_update(data text, p_user_id integer) OWNER TO postgres;

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
    location point NOT NULL,
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
\.


--
-- Data for Name: auth_card_type; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_card_type (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: auth_language; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_language (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	Uzbek	UZ	f	2022-01-12 04:26:19.585544	-1	\N	\N
2	Russian	RU	f	2022-01-12 04:26:37.271006	-1	\N	\N
3	English	EN	f	2022-01-12 04:26:56.078972	-1	\N	\N
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
95	my list basket 	MY_LIST_BASKET	f	2022-01-17 10:02:50.521684	-1	\N	\N
79	ali	ALI	f	2022-01-14 12:53:40.276735	28	2022-01-14 12:57:38.973712	28
80	create category sub	CREATE_CATEGORY_SUB	f	2022-01-15 19:08:10.137935	-1	\N	\N
81	delete category sub	DELETE_CATEGORY_SUB	f	2022-01-15 19:08:10.137935	-1	\N	\N
82	list category sub	LIST_CATEGORY_SUB	f	2022-01-15 19:08:10.137935	-1	\N	\N
83	update category sub	UPDATE_CATEGORY_SUB	f	2022-01-15 19:08:10.137935	-1	\N	\N
84	create basket	CREATE_BASKET	f	2022-01-17 09:03:00.225398	-1	\N	\N
85	delete basket	DELETE_BASKET	f	2022-01-17 09:03:00.225398	-1	\N	\N
86	update basket	UPDATE_BASKET	f	2022-01-17 09:03:00.225398	-1	\N	\N
87	list basket	LIST_BASKET	f	2022-01-17 09:03:00.225398	-1	\N	\N
88	get basket	GET_BASKET	f	2022-01-17 09:03:00.225398	-1	\N	\N
89	create order	CREATE_ORDER	f	2022-01-17 09:03:00.225398	-1	\N	\N
90	delete order	DELETE_ORDER	f	2022-01-17 09:03:00.225398	-1	\N	\N
91	update order	UPDATE_ORDER	f	2022-01-17 09:03:00.225398	-1	\N	\N
92	list order	LIST_ORDER	f	2022-01-17 09:03:00.225398	-1	\N	\N
93	get order	GET_ORDER	f	2022-01-17 09:03:00.225398	-1	\N	\N
94	history order	HISTORY_ORDER	f	2022-01-17 09:03:00.225398	-1	\N	\N
97	detail product	DETAIL_PRODUCT	f	2022-01-17 14:28:53.046512	-1	\N	\N
100	detail category	DETAIL_CATEGORY	f	2022-01-17 18:24:44.455307	-1	\N	\N
102	like dislike	LIKE_DISLIKE	f	2022-01-18 13:37:01.244724	-1	\N	\N
103	like user	LIKE_USER	f	2022-01-18 14:09:19.106557	-1	\N	\N
104	like product	LIKE_PRODUCT	f	2022-01-18 14:09:19.106557	-1	\N	\N
106	create transaction	CREATE_TRANSACTION	f	2022-01-18 15:55:30.904435	-1	\N	\N
107	delete transaction	LIST_TRANSACTION	f	2022-01-18 15:55:30.904435	-1	\N	\N
108	list transaction status	LIST_TRANSACTION_STATUS	f	2022-01-19 03:31:03.256582	-1	\N	\N
109	list transaction type	LIST_TRANSACTION_TYPE	f	2022-01-19 05:05:07.674523	-1	\N	\N
110	create product image	CREATE_PRODUCT_IMAGE	f	2022-01-19 10:43:05.215444	-1	\N	\N
\.


--
-- Data for Name: auth_role; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_role (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	User	USER	f	2022-01-12 04:23:08.202523	-1	\N	\N
3	Manager	MANAGER	f	2022-01-12 04:23:33.753706	-1	\N	\N
4	Employee	EMPLOYEE	f	2022-01-12 04:23:49.983606	-1	\N	\N
2	Admin	ADMIN	f	2022-01-12 04:23:20.929839	-1	2022-01-22 08:51:20.434543	30
\.


--
-- Data for Name: auth_role_permission; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_role_permission (id, auth_user_role_id, permission_id, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
198	35	4	f	2022-01-20 08:52:09.089482	30	\N	\N
199	35	8	f	2022-01-20 08:52:09.089482	30	\N	\N
200	35	9	f	2022-01-20 08:52:09.089482	30	\N	\N
201	35	10	f	2022-01-20 08:52:09.089482	30	\N	\N
202	35	17	f	2022-01-20 08:52:09.089482	30	\N	\N
203	35	18	f	2022-01-20 08:52:09.089482	30	\N	\N
204	35	19	f	2022-01-20 08:52:09.089482	30	\N	\N
205	35	41	f	2022-01-20 08:52:09.089482	30	\N	\N
206	35	42	f	2022-01-20 08:52:09.089482	30	\N	\N
207	35	43	f	2022-01-20 08:52:09.089482	30	\N	\N
208	35	44	f	2022-01-20 08:52:09.089482	30	\N	\N
209	35	63	f	2022-01-20 08:52:09.089482	30	\N	\N
210	35	21	f	2022-01-22 03:40:58.231778	30	\N	\N
211	35	24	f	2022-01-22 03:44:53.561127	30	\N	\N
\.


--
-- Data for Name: auth_session; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_session (id, token_id, user_code, username, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
16	16	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 08:53:42.635505	30	\N	\N
17	17	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 08:56:38.525913	30	\N	\N
18	18	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:19:38.583585	30	\N	\N
19	19	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:22:51.167426	30	\N	\N
20	20	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:24:24.829546	30	\N	\N
21	21	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:24:57.142183	30	\N	\N
22	22	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:27:57.102692	30	\N	\N
23	23	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:30:02.98656	30	\N	\N
24	24	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:36:01.712347	30	\N	\N
25	25	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:36:48.905398	30	\N	\N
26	26	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:37:21.831729	30	\N	\N
27	27	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	f	2022-01-20 09:49:07.293751	30	\N	\N
\.


--
-- Data for Name: auth_status; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_status (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
1	Active	ACTIVE	f	2022-01-12 04:22:00.381542	-1	\N	\N
2	No active	NO_ACTIVE	f	2022-01-12 04:22:52.556305	-1	\N	\N
\.


--
-- Data for Name: auth_token; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_token (id, user_id, token, duration, is_deleted, created_at) FROM stdin;
16	30	42635.5054f69c2c7-b1be-4b3f-a16f-468e880d9bd042635.505	2022-01-20 09:03:42.635505	f	2022-01-20 08:53:42.635505
17	30	38525.913f0a6bac6-4ebe-4a46-9cd1-5cd94e127f3d38525.913	2022-01-20 09:06:38.525913	f	2022-01-20 08:56:38.525913
18	30	38583.585fee78ae8-01ce-4d6b-bf7f-06e81a949edd38583.585	2022-01-20 09:29:38.583585	f	2022-01-20 09:19:38.583585
19	30	51167.426b4fc02fb-11b7-4482-8eb4-519273949a4e51167.426	2022-01-20 09:32:51.167426	f	2022-01-20 09:22:51.167426
20	30	24829.54618861b2d-853e-42d2-a880-cb0f34c5b7bd24829.546	2022-01-20 09:34:24.829546	f	2022-01-20 09:24:24.829546
21	30	57142.183c5c28c98-dfbc-4cf5-a181-c4fec416554157142.183	2022-01-20 09:34:57.142183	f	2022-01-20 09:24:57.142183
22	30	57102.692ac2cbd4c-590e-4cae-9c26-67daf2e8531457102.692	2022-01-20 09:37:57.102692	f	2022-01-20 09:27:57.102692
23	30	2986.56b90e3cba-d8da-4131-bf2f-081eb25c144c2986.56	2022-01-20 09:40:02.98656	f	2022-01-20 09:30:02.98656
24	30	1712.3477c6ccbf9-ea73-4152-86bd-c9be014bc12d1712.347	2022-01-20 09:46:01.712347	f	2022-01-20 09:36:01.712347
25	30	48905.39883bd41b4-8aa6-47ec-8a75-e05b6a303d7248905.398	2022-01-20 09:46:48.905398	f	2022-01-20 09:36:48.905398
26	30	21831.729654add37-5979-42d0-89cb-b447da51f13f21831.729	2022-01-20 09:47:21.831729	f	2022-01-20 09:37:21.831729
27	30	7293.751b4f9f9ba-d44a-4788-a61c-3414b00dc80e7293.751	2022-01-20 09:59:07.293751	f	2022-01-20 09:49:07.293751
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_user (id, code, username, password, email, phone, chat_id, last_login_at, language, status, login_try_count, is_deleted, created_at, created_by, updated_at, updated_by, profile_pic, location) FROM stdin;
30	b693dc7c-d751-4597-9a01-5abdbbf76e18	admin	$2a$04$NYH5cof/cpWWYUrqNziTjOuXE0nyOw6KDqVBljeS19P0WYICSrmZa	admin@gmail.com	998901234567 	\N	2022-01-20 09:49:07.293751	RU	ACTIVE	0	f	2022-01-20 08:52:09.021519	-1	\N	\N	\N	(1,2)
\.


--
-- Data for Name: auth_user_role; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth.auth_user_role (id, user_id, role_id, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
35	30	USER	f	2022-01-20 08:52:09.082207	30	\N	\N
37	30	ADMIN	f	2022-01-21 17:06:43.508436	30	\N	\N
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
\.


--
-- Data for Name: product_comment; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.product_comment (id, product_id, user_id, message, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: product_image; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.product_image (id, product_id, product_pic, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: product_price; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.product_price (id, product_id, price, discount_percent, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: product_rating; Type: TABLE DATA; Schema: project; Owner: postgres
--

COPY project.product_rating (id, product_id, views, purchased, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
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
154	auth.user_role_list(p_user_id integer) returns text	2022-01-15 18:08:08.890604	-1
155	project.product_create(data character varying, p_user_id integer) returns varchar	2022-01-15 19:51:52.297512	-1
156	project.product_create(data character varying, p_user_id integer) returns varchar	2022-01-15 19:55:29.92891	-1
157	project.basket_list(p_user_id integer) returns text	2022-01-17 13:20:07.678968	-1
159	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:29:11.675733	-1
160	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 14:29:11.675733	-1
161	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 14:29:11.675733	-1
162	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 14:29:11.675733	-1
163	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:29:11.675733	-1
164	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 14:29:11.675733	-1
165	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 14:29:11.675733	-1
166	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 14:29:11.675733	-1
167	project.basket_list(p_user_id integer) returns text	2022-01-17 14:29:11.675733	-1
168	auth.auth_get(p_user_id integer) returns text	2022-01-17 14:34:19.187762	-1
169	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:34:57.541459	-1
170	auth.user_role_create(p_create_user_id integer, p_code character varying, p_user_id integer) returns text	2022-01-17 14:36:08.027493	-1
171	auth.user_role_list(p_user_id integer) returns text	2022-01-17 14:36:30.972544	-1
172	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:44:13.817543	-1
173	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:44:13.817543	-1
174	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:44:13.817543	-1
175	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:44:13.817543	-1
176	auth.user_role_list(p_user_id integer) returns text	2022-01-17 14:44:13.817543	-1
177	auth.user_code_by_id(p_user_id integer) returns uuid	2022-01-17 14:46:17.804888	-1
178	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:46:17.804888	-1
179	auth.user_code_by_id(p_user_id integer) returns uuid	2022-01-17 14:46:17.804888	-1
180	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:46:17.804888	-1
181	auth.user_code_by_id(p_user_id integer) returns uuid	2022-01-17 14:46:17.804888	-1
182	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:46:17.804888	-1
183	auth.user_code_by_id(p_user_id integer) returns uuid	2022-01-17 14:46:17.804888	-1
184	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 14:46:17.804888	-1
185	auth.user_role_list(p_user_id integer) returns text	2022-01-17 14:46:17.804888	-1
186	project.basket_create(data text, p_user_id integer)	2022-01-17 16:20:01.76004	-1
187	project.basket_create(data text, p_user_id integer)	2022-01-17 16:24:52.553279	-1
188	project.basket_create(data text, p_user_id integer)	2022-01-17 16:30:32.847847	-1
189	project.basket_create(data text, p_user_id integer)	2022-01-17 16:31:36.07073	-1
190	project.basket_create(data text, p_user_id integer)	2022-01-17 16:31:53.128584	-1
191	project.basket_create(data text, p_user_id integer)	2022-01-17 16:41:35.096819	-1
192	project.basket_create(data text, p_user_id integer)	2022-01-17 16:50:35.758696	-1
193	project.basket_delete(p_basket_id integer, p_user_id integer)	2022-01-17 16:54:06.191891	-1
194	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 16:55:19.667378	-1
195	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 16:57:48.472983	-1
196	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 16:57:48.472983	-1
197	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 16:57:48.472983	-1
198	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 16:57:48.472983	-1
199	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 16:59:50.703616	-1
200	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
201	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
202	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
203	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 16:59:50.703616	-1
204	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
205	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
206	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
207	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 16:59:50.703616	-1
208	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
209	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
210	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
211	project.basket_list(p_user_id integer) returns text	2022-01-17 16:59:50.703616	-1
212	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:04:01.168614	-1
213	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
214	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
215	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
216	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:04:01.168614	-1
217	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
218	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
219	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
220	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:04:01.168614	-1
221	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
222	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
223	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
224	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:04:01.168614	-1
225	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
226	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
227	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
228	project.basket_list(p_user_id integer) returns text	2022-01-17 17:04:01.168614	-1
229	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:12:27.242064	-1
230	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:12:30.259168	-1
231	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:12:59.135306	-1
232	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:13:23.903366	-1
233	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:13:48.22255	-1
234	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:13:49.861941	-1
235	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:17:35.220927	-1
236	project.basket_list(p_user_id integer) returns text	2022-01-17 17:17:57.28925	-1
237	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:18:52.742005	-1
238	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
239	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
240	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
241	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:18:52.742005	-1
242	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
243	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
244	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
245	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:18:52.742005	-1
246	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
247	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
248	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
249	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:18:52.742005	-1
250	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
251	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
252	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
253	project.basket_list(p_user_id integer) returns text	2022-01-17 17:18:52.742005	-1
254	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:20:48.680942	-1
258	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:24:46.305118	-1
259	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
260	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
261	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
262	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:24:46.305118	-1
263	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
264	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
265	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
266	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:24:46.305118	-1
267	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
268	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
269	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
270	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:24:46.305118	-1
271	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
272	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
273	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
274	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:24:46.305118	-1
275	project.basket_create(data text, p_user_id integer)	2022-01-17 17:25:23.445369	-1
276	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:25:29.271342	-1
277	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
278	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
279	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
280	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:25:29.271342	-1
281	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
282	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
283	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
284	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:25:29.271342	-1
285	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
286	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
287	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
288	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:25:29.271342	-1
289	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
290	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
291	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
292	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:25:29.271342	-1
293	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:25:32.553136	-1
294	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
295	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
296	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
297	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:25:32.553136	-1
298	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
299	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
300	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
301	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:25:32.553136	-1
302	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
303	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
304	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
305	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:25:32.553136	-1
306	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
307	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
308	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
309	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:25:32.553136	-1
310	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
311	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
312	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
313	project.basket_list(p_user_id integer) returns text	2022-01-17 17:25:32.553136	-1
314	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:26:51.158272	-1
315	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
316	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
317	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
318	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:26:51.158272	-1
319	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
320	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
321	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
322	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:26:51.158272	-1
323	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
324	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
325	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
326	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:26:51.158272	-1
327	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
328	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
329	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
330	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:26:51.158272	-1
331	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:27:45.952615	-1
332	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:27:45.952615	-1
333	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:27:45.952615	-1
334	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:27:45.952615	-1
335	auth.auth_user_get(p_user_code uuid) returns text	2022-01-17 17:28:04.762679	-1
336	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 17:28:04.762679	-1
337	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 17:28:04.762679	-1
338	project.basket_get(p_basket_id integer, p_user_id integer) returns text	2022-01-17 17:28:04.762679	-1
339	project.basket_my_list(p_user_id integer) returns text	2022-01-17 17:28:04.762679	-1
340	project.basket_update(data text, p_user_id integer)	2022-01-17 17:30:57.21856	-1
341	project.basket_update(data text, p_user_id integer)	2022-01-17 17:31:47.245946	-1
345	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 18:30:38.044349	-1
346	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 18:30:38.044349	-1
347	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 18:30:38.044349	-1
348	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 18:35:30.511532	-1
349	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 18:37:13.669526	-1
350	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 18:38:19.324201	-1
351	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 18:38:58.853723	-1
352	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 18:39:26.169852	-1
353	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 18:39:53.340042	-1
354	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 18:39:53.340042	-1
355	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 18:39:53.340042	-1
356	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 18:40:45.301637	-1
357	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-17 18:40:45.301637	-1
358	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 18:40:45.301637	-1
359	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-17 18:41:01.9744	-1
360	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:38:44.246968	-1
361	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:38:57.452365	-1
362	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:39:02.302439	-1
363	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:39:08.54244	-1
364	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:39:12.567509	-1
365	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:39:14.171775	-1
366	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:39:25.870391	-1
367	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:39:28.208136	-1
368	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:39:34.980106	-1
369	project.like_add(data text, p_user_id integer) returns text	2022-01-18 13:39:40.555662	-1
370	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:10:53.901469	-1
371	project.like_user(p_like_user_id integer, p_user_id integer) returns text	2022-01-18 14:10:53.901469	-1
372	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-18 14:51:41.970468	-1
373	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:51:41.970468	-1
374	project.like_user(p_like_user_id integer, p_user_id integer) returns text	2022-01-18 14:51:41.970468	-1
375	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-18 14:52:55.092262	-1
376	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:52:55.092262	-1
377	project.like_user(p_like_user_id integer, p_user_id integer) returns text	2022-01-18 14:52:55.092262	-1
378	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:53:36.828816	-1
379	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:53:42.090394	-1
380	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:53:54.709489	-1
381	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:54:00.036633	-1
382	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:54:01.752197	-1
383	project.like_add(data text, p_user_id integer) returns text	2022-01-18 14:55:03.034274	-1
384	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-18 14:55:09.821829	-1
385	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:55:09.821829	-1
386	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-18 14:55:09.821829	-1
387	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:55:09.821829	-1
388	project.like_user(p_like_user_id integer, p_user_id integer) returns text	2022-01-18 14:55:09.821829	-1
389	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:55:34.498529	-1
390	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:55:37.896969	-1
391	project.like_add(data text, p_user_id integer) returns text	2022-01-18 14:55:42.003802	-1
392	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:55:45.670405	-1
393	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:55:46.695321	-1
394	project.like_product(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:55:49.360199	-1
395	project.category_get(p_category_id integer, p_user_id integer) returns text	2022-01-18 14:55:51.018515	-1
396	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 14:55:51.018515	-1
397	project.like_user(p_like_user_id integer, p_user_id integer) returns text	2022-01-18 14:55:51.018515	-1
398	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 16:06:13.878302	-1
399	project.like_user(p_like_user_id integer, p_user_id integer) returns text	2022-01-18 16:06:13.878302	-1
400	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 16:16:27.440693	-1
401	project.like_user(p_like_user_id integer, p_user_id integer) returns text	2022-01-18 16:16:27.440693	-1
402	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 16:17:05.565969	-1
403	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 16:17:05.565969	-1
404	project.like_user(p_like_user_id integer, p_user_id integer) returns text	2022-01-18 16:17:05.565969	-1
405	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-18 16:17:37.119262	-1
406	project.like_user(p_like_user_id integer, p_user_id integer) returns text	2022-01-18 16:17:37.119262	-1
407	checks.check_transaction_create_dto(INOUT create_dto dto.transaction_create_dto)	2022-01-18 16:24:22.221525	-1
408	project.transaction_create(data text, p_user_id integer) returns text	2022-01-18 16:24:22.221525	-1
445	auth.user_code_by_id(p_user_id integer) returns uuid	2022-01-18 17:26:39.582583	-1
446	auth.auth_user_get(p_user_code uuid) returns text	2022-01-18 17:26:39.582583	-1
447	auth.user_code_by_id(p_user_id integer) returns uuid	2022-01-18 17:26:39.582583	-1
448	auth.auth_user_get(p_user_code uuid) returns text	2022-01-18 17:26:39.582583	-1
449	project.order_get(p_order_id integer, p_user_id integer) returns text	2022-01-18 17:26:39.582583	-1
450	project.transaction_list(p_user_id integer) returns text	2022-01-18 17:26:39.582583	-1
451	project.transaction_status_list(p_user_id integer) returns text	2022-01-19 03:31:30.26254	-1
452	project.transaction_type_list(p_user_id integer) returns text	2022-01-19 05:05:49.351546	-1
453	project.product_image_create(data text, p_user_id integer)	2022-01-19 10:56:12.477665	-1
454	project.product_image_create(data text, p_user_id integer)	2022-01-19 10:56:33.619002	-1
455	project.product_image_create(data text, p_user_id integer)	2022-01-19 10:57:52.398553	-1
456	project.product_image_create(data text, p_user_id integer)	2022-01-19 10:58:32.893477	-1
457	project.product_image_create(data text, p_user_id integer)	2022-01-19 10:58:42.742677	-1
458	project.product_image_create(data text, p_user_id integer)	2022-01-19 10:58:50.86153	-1
459	project.product_image_create(data text, p_user_id integer)	2022-01-19 10:58:58.069841	-1
460	project.product_image_create(data text, p_user_id integer)	2022-01-19 10:59:09.862663	-1
461	project.product_image_create(data text, p_user_id integer)	2022-01-19 11:00:42.261867	-1
462	project.product_image_create(data text, p_user_id integer)	2022-01-19 11:01:03.334977	-1
463	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-19 13:32:07.654461	-1
464	product_detail(p_product_id integer, p_user_id integer) returns text	2022-01-19 13:32:07.654461	-1
465	project.product_list(p_user_id integer) returns text	2022-01-19 13:32:07.654461	-1
466	auth_register(data text, INOUT p_result character varying DEFAULT ''::character varying)	2022-01-20 08:52:09.089482	-1
467	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 08:53:42.635505	-1
468	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 08:56:38.525913	-1
469	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:19:38.583585	-1
470	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:22:51.167426	-1
471	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:24:24.829546	-1
472	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:24:57.142183	-1
473	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:27:57.102692	-1
474	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:30:02.98656	-1
475	auth.auth_get(p_user_id integer) returns text	2022-01-20 09:30:03.117694	-1
476	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:36:01.712347	-1
477	auth.auth_get(p_user_id integer) returns text	2022-01-20 09:36:01.87656	-1
478	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:36:48.905398	-1
479	auth.auth_get(p_user_id integer) returns text	2022-01-20 09:36:49.020627	-1
480	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:37:21.831729	-1
481	auth.auth_get(p_user_id integer) returns text	2022-01-20 09:37:21.935168	-1
482	auth_login(p_username_or_email character varying, p_password character varying, INOUT p_result text DEFAULT ''::text)	2022-01-20 09:49:07.293751	-1
483	auth.auth_get(p_user_id integer) returns text	2022-01-20 09:49:07.398705	-1
484	auth.auth_list(p_user_id integer) returns text	2022-01-21 17:06:58.421494	-1
485	auth.role_delete(p_code character varying, p_user_id integer)	2022-01-22 03:44:58.583646	-1
486	auth.role_delete(p_code character varying, p_user_id integer)	2022-01-22 08:50:25.620776	-1
487	auth.role_delete(p_code character varying, p_user_id integer)	2022-01-22 08:51:20.434543	-1
488	...............................	2022-01-22 08:54:35.157852	-1
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
91	category not found	CATEGORY_NOT_FOUND	EN	f	2022-01-15 18:44:42.675781	-1	\N	\N
92	категория не найдена	CATEGORY_NOT_FOUND	RU	f	2022-01-15 18:44:42.675781	-1	\N	\N
93	kategoriya topilmadi	CATEGORY_NOT_FOUND	UZ	f	2022-01-15 18:44:42.675781	-1	\N	\N
94	category code is already taken	CATEGORY_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-15 18:44:42.675781	-1	\N	\N
95	код категории уже занят	CATEGORY_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-15 18:44:42.675781	-1	\N	\N
96	toifa kodi allaqachon olingan	CATEGORY_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-15 18:44:42.675781	-1	\N	\N
97	sub category not found	SUB_CATEGORY_NOT_FOUND	EN	f	2022-01-15 18:44:42.675781	-1	\N	\N
98	pastki kategoriya topilmadi	SUB_CATEGORY_NOT_FOUND	RU	f	2022-01-15 18:44:42.675781	-1	\N	\N
99	подкатегория не найдена	SUB_CATEGORY_NOT_FOUND	UZ	f	2022-01-15 18:44:42.675781	-1	\N	\N
100	sub category is already taken	SUB_CATEGORY_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-15 18:44:42.675781	-1	\N	\N
101	подкатегория уже занята	SUB_CATEGORY_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-15 18:44:42.675781	-1	\N	\N
102	pastki kategoriya allaqachon olingan	SUB_CATEGORY_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-15 18:44:42.675781	-1	\N	\N
103	product code is already taken	PRODUCT_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-15 19:44:03.713443	-1	\N	\N
104	код товара уже занят	PRODUCT_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-15 19:44:03.713443	-1	\N	\N
105	mahsulot kodi allaqachon olingan	PRODUCT_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-15 19:44:03.713443	-1	\N	\N
106	parent id not found	PARENT_ID_NOT_FOUND	EN	f	2022-01-17 07:25:51.733668	-1	\N	\N
107	родительский идентификатор не найден	PARENT_ID_NOT_FOUND	RU	f	2022-01-17 07:25:51.733668	-1	\N	\N
108	ota-ona identifikatori topilmadi	PARENT_ID_NOT_FOUND	UZ	f	2022-01-17 07:25:51.733668	-1	\N	\N
109	parent not found	PARENT_NOT_FOUND	EN	f	2022-01-17 08:09:39.703949	-1	\N	\N
110	родитель не найден	PARENT_NOT_FOUND	RU	f	2022-01-17 08:09:39.703949	-1	\N	\N
111	ota-ona topilmadi	PARENT_NOT_FOUND	UZ	f	2022-01-17 08:09:39.703949	-1	\N	\N
112	is required to create basket	IS_REQUIRED_TO_CREATE_BASKET	EN	f	2022-01-17 08:51:20.441918	-1	\N	\N
113	требуется для создания корзины	IS_REQUIRED_TO_CREATE_BASKET	RU	f	2022-01-17 08:51:20.441918	-1	\N	\N
114	savat yaratish uchun talab qilinadi	IS_REQUIRED_TO_CREATE_BASKET	UZ	f	2022-01-17 08:51:20.441918	-1	\N	\N
115	basket not found	BASKET_NOT_FOUND	EN	f	2022-01-17 09:20:59.935461	-1	\N	\N
116	корзина не найдена	BASKET_NOT_FOUND	RU	f	2022-01-17 09:20:59.935461	-1	\N	\N
117	savat topilmadi	BASKET_NOT_FOUND	UZ	f	2022-01-17 09:20:59.935461	-1	\N	\N
118	product not found	PRODUCT_NOT_FOUND	EN	f	2022-01-17 13:54:31.698541	-1	\N	\N
119	продукт не найден	PRODUCT_NOT_FOUND	RU	f	2022-01-17 13:54:31.698541	-1	\N	\N
120	mahsulot topilmadi	PRODUCT_NOT_FOUND	UZ	f	2022-01-17 13:54:31.698541	-1	\N	\N
121	order not found	ORDER_NOT_FOUND	EN	f	2022-01-17 23:36:55.052734	-1	\N	\N
122	order not found	ORDER_NOT_FOUND	RU	f	2022-01-17 23:36:55.052734	-1	\N	\N
123	order not found	ORDER_NOT_FOUND	UZ	f	2022-01-17 23:36:55.052734	-1	\N	\N
124	order status not found	ORDER_STATUS_NOT_FOUND	EN	f	2022-01-18 00:39:25.301532	-1	\N	\N
125	order status not found	ORDER_STATUS_NOT_FOUND	RU	f	2022-01-18 00:39:25.301532	-1	\N	\N
126	order status not found	ORDER_STATUS_NOT_FOUND	UZ	f	2022-01-18 00:39:25.301532	-1	\N	\N
127	order type not found	ORDER_TYPE_NOT_FOUND	EN	f	2022-01-18 00:39:25.301532	-1	\N	\N
128	order type not found	ORDER_TYPE_NOT_FOUND	RU	f	2022-01-18 00:39:25.301532	-1	\N	\N
129	order type not found	ORDER_TYPE_NOT_FOUND	UZ	f	2022-01-18 00:39:25.301532	-1	\N	\N
130	order status code is already taken	ORDER_STATUS_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-18 00:39:25.301532	-1	\N	\N
131	order status code is already taken	ORDER_STATUS_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-18 00:39:25.301532	-1	\N	\N
132	order status code is already taken	ORDER_STATUS_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-18 00:39:25.301532	-1	\N	\N
133	order type code is already taken	ORDER_TYPE_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-18 00:39:25.301532	-1	\N	\N
134	order type code is already taken	ORDER_TYPE_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-18 00:39:25.301532	-1	\N	\N
135	order type code is already taken	ORDER_TYPE_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-18 00:39:25.301532	-1	\N	\N
136	is required to create order status	IS_REQUIRED_TO_CREATE_ORDER_STATUS	EN	f	2022-01-18 00:41:42.106899	-1	\N	\N
137	is required to create order status	IS_REQUIRED_TO_CREATE_ORDER_STATUS	RU	f	2022-01-18 00:41:42.106899	-1	\N	\N
138	is required to create order status	IS_REQUIRED_TO_CREATE_ORDER_STATUS	UZ	f	2022-01-18 00:41:42.106899	-1	\N	\N
139	is required to create order type	IS_REQUIRED_TO_CREATE_ORDER_TYPE	EN	f	2022-01-18 00:41:42.106899	-1	\N	\N
140	is required to create order type	IS_REQUIRED_TO_CREATE_ORDER_TYPE	RU	f	2022-01-18 00:41:42.106899	-1	\N	\N
141	is required to create order type	IS_REQUIRED_TO_CREATE_ORDER_TYPE	UZ	f	2022-01-18 00:41:42.106899	-1	\N	\N
146	is required to create transaction	IS_REQUIRED_TO_CREATE_TRANSACTION	EN	f	2022-01-18 15:20:45.1839	-1	\N	\N
147	требуется для создания транзакции	IS_REQUIRED_TO_CREATE_TRANSACTION	RU	f	2022-01-18 15:20:45.1839	-1	\N	\N
148	tranzaktsiyani yaratish uchun talab qilinadi	IS_REQUIRED_TO_CREATE_TRANSACTION	UZ	f	2022-01-18 15:20:45.1839	-1	\N	\N
149	transaction not found	TRANSACTION_NOT_FOUND	EN	f	2022-01-18 15:27:56.600101	-1	\N	\N
150	транзакция не найдена	TRANSACTION_NOT_FOUND	RU	f	2022-01-18 15:27:56.600101	-1	\N	\N
151	tranzaksiya topilmadi	TRANSACTION_NOT_FOUND	UZ	f	2022-01-18 15:27:56.600101	-1	\N	\N
152	transaction type not found	TRANSACTION_TYPE_NOT_FOUND	EN	f	2022-01-18 15:27:56.600101	-1	\N	\N
153	тип транзакции не найден	TRANSACTION_TYPE_NOT_FOUND	RU	f	2022-01-18 15:27:56.600101	-1	\N	\N
154	tranzaktsiya turi topilmadi	TRANSACTION_TYPE_NOT_FOUND	UZ	f	2022-01-18 15:27:56.600101	-1	\N	\N
155	transaction status not found	TRANSACTION_STATUS_NOT_FOUND	EN	f	2022-01-18 15:27:56.600101	-1	\N	\N
156	статус транзакции не найден	TRANSACTION_STATUS_NOT_FOUND	RU	f	2022-01-18 15:27:56.600101	-1	\N	\N
157	tranzaksiya holati topilmadi	TRANSACTION_STATUS_NOT_FOUND	UZ	f	2022-01-18 15:27:56.600101	-1	\N	\N
158	transaction status code is already taken	TRANSACTION_STATUS_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-18 17:48:43.922161	-1	\N	\N
159	код статуса транзакции уже занят	TRANSACTION_STATUS_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-18 17:48:43.922161	-1	\N	\N
160	tranzaksiya holati kodi allaqachon olingan	TRANSACTION_STATUS_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-18 17:48:43.922161	-1	\N	\N
161	transaction type code is already taken 	TRANSACTION_TYPE_CODE_IS_ALREADY_TAKEN	EN	f	2022-01-18 17:48:43.922161	-1	\N	\N
162	код типа транзакции уже занят	TRANSACTION_TYPE_CODE_IS_ALREADY_TAKEN	RU	f	2022-01-18 17:48:43.922161	-1	\N	\N
163	tranzaksiya turi kodi allaqachon olingan	TRANSACTION_TYPE_CODE_IS_ALREADY_TAKEN	UZ	f	2022-01-18 17:48:43.922161	-1	\N	\N
164	is required to create product rating	IS_REQUIRED_TO_CREATE_PRODUCT_RATING	EN	f	2022-01-19 06:00:58.692693	-1	\N	\N
165	требуется для создания рейтинга товаров	IS_REQUIRED_TO_CREATE_PRODUCT_RATING	RU	f	2022-01-19 06:00:58.692693	-1	\N	\N
166	mahsulot reytingini yaratish uchun talab qilinadi	IS_REQUIRED_TO_CREATE_PRODUCT_RATING	UZ	f	2022-01-19 06:00:58.692693	-1	\N	\N
167	product id is already taken	PRODUCT_ID_IS_ALREADY_TAKEN	EN	f	2022-01-19 06:30:46.153996	-1	\N	\N
168	идентификатор продукта уже занят	PRODUCT_ID_IS_ALREADY_TAKEN	RU	f	2022-01-19 06:30:46.153996	-1	\N	\N
169	mahsulot identifikatori allaqachon olingan	PRODUCT_ID_IS_ALREADY_TAKEN	UZ	f	2022-01-19 06:30:46.153996	-1	\N	\N
170	product rating not found	PRODUCT_RATING_NOT_FOUND	EN	f	2022-01-19 06:34:44.282074	-1	\N	\N
171	рейтинг продукта не найден	PRODUCT_RATING_NOT_FOUND	RU	f	2022-01-19 06:34:44.282074	-1	\N	\N
172	mahsulot reytingi topilmadi	PRODUCT_RATING_NOT_FOUND	UZ	f	2022-01-19 06:34:44.282074	-1	\N	\N
173	is required to update product rating	IS_REQUIRED_TO_UPDATE_PRODUCT_RATING	EN	f	2022-01-19 06:59:29.200025	-1	\N	\N
174	требуется для обновления рейтинга продукта	IS_REQUIRED_TO_UPDATE_PRODUCT_RATING	RU	f	2022-01-19 06:59:29.200025	-1	\N	\N
175	mahsulot reytingini yangilash uchun talab qilinadi	IS_REQUIRED_TO_UPDATE_PRODUCT_RATING	UZ	f	2022-01-19 06:59:29.200025	-1	\N	\N
176	is required to create product price	IS_REQUIRED_TO_CREATE_PRODUCT_PRICE	EN	f	2022-01-19 07:24:17.85156	-1	\N	\N
177	требуется для создания цены продукта	IS_REQUIRED_TO_CREATE_PRODUCT_PRICE	RU	f	2022-01-19 07:24:17.85156	-1	\N	\N
178	mahsulot narxini yaratish uchun talab qilinadi	IS_REQUIRED_TO_CREATE_PRODUCT_PRICE	UZ	f	2022-01-19 07:24:17.85156	-1	\N	\N
179	is required to update product price	IS_REQUIRED_TO_UPDATE_PRODUCT_PRICE	EN	f	2022-01-19 07:25:25.936941	-1	\N	\N
180	необходимо обновить цену товара	IS_REQUIRED_TO_UPDATE_PRODUCT_PRICE	RU	f	2022-01-19 07:25:25.936941	-1	\N	\N
181	mahsulot narxini yangilash uchun talab qilinadi	IS_REQUIRED_TO_UPDATE_PRODUCT_PRICE	UZ	f	2022-01-19 07:25:25.936941	-1	\N	\N
182	product price not found	PRODUCT_PRICE_NOT_FOUND	EN	f	2022-01-19 07:33:04.225727	-1	\N	\N
183	цена товара не найдена	PRODUCT_PRICE_NOT_FOUND	RU	f	2022-01-19 07:33:04.225727	-1	\N	\N
184	mahsulot narxi topilmadi	PRODUCT_PRICE_NOT_FOUND	UZ	f	2022-01-19 07:33:04.225727	-1	\N	\N
185	is required to create product comment	IS_REQUIRED_TO_CREATE_PRODUCT_COMMENT	EN	f	2022-01-19 09:23:55.859401	-1	\N	\N
186	требуется для создания комментария к продукту	IS_REQUIRED_TO_CREATE_PRODUCT_COMMENT	RU	f	2022-01-19 09:23:55.859401	-1	\N	\N
187	mahsulot sharhini yaratish uchun talab qilinadi	IS_REQUIRED_TO_CREATE_PRODUCT_COMMENT	UZ	f	2022-01-19 09:23:55.859401	-1	\N	\N
188	comment not found	COMMENT_NOT_FOUND	EN	f	2022-01-19 09:40:44.531769	-1	\N	\N
189	комментарий не найден	COMMENT_NOT_FOUND	RU	f	2022-01-19 09:40:44.531769	-1	\N	\N
190	izoh topilmadi	COMMENT_NOT_FOUND	UZ	f	2022-01-19 09:40:44.531769	-1	\N	\N
191	is required to create product image	IS_REQUIRED_TO_CREATE_PRODUCT_IMAGE	EN	f	2022-01-19 10:32:41.406118	-1	\N	\N
192	требуется для создания имиджа продукта	IS_REQUIRED_TO_CREATE_PRODUCT_IMAGE	RU	f	2022-01-19 10:32:41.406118	-1	\N	\N
193	mahsulot tasvirini yaratish uchun talab qilinadi	IS_REQUIRED_TO_CREATE_PRODUCT_IMAGE	UZ	f	2022-01-19 10:32:41.406118	-1	\N	\N
194	is required to update product image	IS_REQUIRED_TO_UPDATE_PRODUCT_IMAGE	EN	f	2022-01-19 11:07:48.765486	-1	\N	\N
195	требуется для обновления изображения продукта	IS_REQUIRED_TO_UPDATE_PRODUCT_IMAGE	RU	f	2022-01-19 11:07:48.765486	-1	\N	\N
196	mahsulot tasvirini yangilash uchun talab qilinadi	IS_REQUIRED_TO_UPDATE_PRODUCT_IMAGE	UZ	f	2022-01-19 11:07:48.765486	-1	\N	\N
197	product image not found	PRODUCT_IMAGE_NOT_FOUND	EN	f	2022-01-19 11:09:08.496284	-1	\N	\N
198	изображение товара не найдено	PRODUCT_IMAGE_NOT_FOUND	RU	f	2022-01-19 11:09:08.496284	-1	\N	\N
199	mahsulot tasviri topilmadi	PRODUCT_IMAGE_NOT_FOUND	UZ	f	2022-01-19 11:09:08.496284	-1	\N	\N
200	is required to create product	IS_REQUIRED_TO_CREATE_PRODUCT	EN	f	2022-01-19 12:12:34.156217	-1	\N	\N
201	требуется для создания продукта	IS_REQUIRED_TO_CREATE_PRODUCT	RU	f	2022-01-19 12:12:34.156217	-1	\N	\N
202	mahsulot yaratish uchun talab qilinadi	IS_REQUIRED_TO_CREATE_PRODUCT	UZ	f	2022-01-19 12:12:34.156217	-1	\N	\N
203	is required to update product	IS_REQUIRED_TO_UPDATE_PRODUCT	EN	f	2022-01-19 13:09:17.37177	-1	\N	\N
204	требуется для обновления продукта	IS_REQUIRED_TO_UPDATE_PRODUCT	RU	f	2022-01-19 13:09:17.37177	-1	\N	\N
205	mahsulotni yangilash uchun talab qilinadi	IS_REQUIRED_TO_UPDATE_PRODUCT	UZ	f	2022-01-19 13:09:17.37177	-1	\N	\N
206	system comment not found	SYSTEM_COMMENT_NOT_FOUND	EN	f	2022-01-19 13:45:47.991535	-1	\N	\N
207	системный комментарий не найден	SYSTEM_COMMENT_NOT_FOUND	RU	f	2022-01-19 13:45:47.991535	-1	\N	\N
208	tizim sharhi topilmadi	SYSTEM_COMMENT_NOT_FOUND	UZ	f	2022-01-19 13:45:47.991535	-1	\N	\N
209	sponsor not found	SPONSOR_NOT_FOUND	EN	f	2022-01-19 14:40:15.741303	-1	\N	\N
210	спонсор не найден	SPONSOR_NOT_FOUND	RU	f	2022-01-19 14:40:15.741303	-1	\N	\N
211	homiy topilmadi	SPONSOR_NOT_FOUND	UZ	f	2022-01-19 14:40:15.741303	-1	\N	\N
212	sponsor name is available	SPONSOR_NAME_IS_AVAILABLE	EN	f	2022-01-19 14:44:29.210597	-1	\N	\N
213	имя спонсора доступно	SPONSOR_NAME_IS_AVAILABLE	RU	f	2022-01-19 14:44:29.210597	-1	\N	\N
214	homiy nomi mavjud	SPONSOR_NAME_IS_AVAILABLE	UZ	f	2022-01-19 14:44:29.210597	-1	\N	\N
215	rule type already created	RULE_TYPE_FOUND	EN	f	2022-01-20 06:21:51.279742	-1	\N	\N
216	тип правила уже создан	RULE_TYPE_FOUND	RU	f	2022-01-20 06:21:51.279742	-1	\N	\N
217	qoida turi allaqachon yaratilgan	RULE_TYPE_FOUND	UZ	f	2022-01-20 06:21:51.279742	-1	\N	\N
218	rule found	RULE_FOUND	EN	f	2022-01-20 06:21:51.279742	-1	\N	\N
219	правило найдено	RULE_FOUND	RU	f	2022-01-20 06:21:51.279742	-1	\N	\N
220	qoida topildi	RULE_FOUND	UZ	f	2022-01-20 06:21:51.279742	-1	\N	\N
221	rule not found	RULE_NOT_FOUND	EN	f	2022-01-20 06:21:51.279742	-1	\N	\N
222	правило не найдено	RULE_NOT_FOUND	RU	f	2022-01-20 06:21:51.279742	-1	\N	\N
223	qoida topilmadi	RULE_NOT_FOUND	UZ	f	2022-01-20 06:21:51.279742	-1	\N	\N
224	rule type not found	RULE_TYPE_NOT_FOUND	EN	f	2022-01-20 06:21:51.279742	-1	\N	\N
225	тип правила не найден	RULE_TYPE_NOT_FOUND	RU	f	2022-01-20 06:21:51.279742	-1	\N	\N
226	qoida turi topilmadi	RULE_TYPE_NOT_FOUND	UZ	f	2022-01-20 06:21:51.279742	-1	\N	\N
227	help found	HELP_FOUND	EN	f	2022-01-20 06:21:51.279742	-1	\N	\N
228	помощь найдена	HELP_FOUND	RU	f	2022-01-20 06:21:51.279742	-1	\N	\N
229	yordam topildi	HELP_FOUND	UZ	f	2022-01-20 06:21:51.279742	-1	\N	\N
230	help not found	HELP_NOT_FOUND	EN	f	2022-01-20 06:21:51.279742	-1	\N	\N
231	помощь не найдена	HELP_NOT_FOUND	RU	f	2022-01-20 06:21:51.279742	-1	\N	\N
232	yordam topilmadi	HELP_NOT_FOUND	UZ	f	2022-01-20 06:21:51.279742	-1	\N	\N
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.comment (id, user_id, message, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: help; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.help (id, body, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: rule; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.rule (id, type, body, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: rule_type; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.rule_type (id, name, code, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: sponsors; Type: TABLE DATA; Schema: system; Owner: postgres
--

COPY system.sponsors (id, name, phone, email, logo, location, is_deleted, created_at, created_by, updated_at, updated_by) FROM stdin;
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

SELECT pg_catalog.setval('auth.auth_permission_id_seq', 110, true);


--
-- Name: auth_role_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_role_id_seq', 5, true);


--
-- Name: auth_role_permission_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_role_permission_id_seq', 211, true);


--
-- Name: auth_session_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_session_id_seq', 27, true);


--
-- Name: auth_status_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_status_id_seq', 3, true);


--
-- Name: auth_token_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_token_id_seq', 27, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_user_id_seq', 30, true);


--
-- Name: auth_user_role_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: postgres
--

SELECT pg_catalog.setval('auth.auth_user_role_id_seq', 37, true);


--
-- Name: basket_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.basket_id_seq', 10, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.category_id_seq', 6, true);


--
-- Name: like_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.like_id_seq', 7, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.order_id_seq', 1, true);


--
-- Name: order_status_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.order_status_id_seq', 3, true);


--
-- Name: order_type_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.order_type_id_seq', 2, true);


--
-- Name: product_comment_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_comment_id_seq', 2, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_id_seq', 2, true);


--
-- Name: product_image_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_image_id_seq', 17, true);


--
-- Name: product_price_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_price_id_seq', 2, true);


--
-- Name: product_rating_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.product_rating_id_seq', 3, true);


--
-- Name: transaction_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.transaction_id_seq', 1, true);


--
-- Name: transaction_status_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.transaction_status_id_seq', 3, true);


--
-- Name: transaction_type_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('project.transaction_type_id_seq', 2, true);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: settings; Owner: postgres
--

SELECT pg_catalog.setval('settings.log_id_seq', 488, true);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: settings; Owner: postgres
--

SELECT pg_catalog.setval('settings.message_id_seq', 232, true);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.comment_id_seq', 1, false);


--
-- Name: help_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.help_id_seq', 1, false);


--
-- Name: rule_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.rule_id_seq', 1, false);


--
-- Name: rule_type_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.rule_type_id_seq', 1, false);


--
-- Name: sponsors_id_seq; Type: SEQUENCE SET; Schema: system; Owner: postgres
--

SELECT pg_catalog.setval('system.sponsors_id_seq', 1, false);


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

