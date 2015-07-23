/* acl/acl--1.0.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION acl" to load this file.\quit

-- ACL
CREATE FUNCTION ace_in(cstring)
RETURNS ace
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION ace_out(ace)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE TYPE ace (
	INTERNALLENGTH = 16,
	INPUT = ace_in,
	OUTPUT = ace_out
);

COMMENT ON TYPE ace IS 'access control list entry';

CREATE FUNCTION acl_check_access(ace[], text)
RETURNS text
AS 'MODULE_PATHNAME', 'acl_check_access_text_current_user'
LANGUAGE C STRICT IMMUTABLE;

COMMENT ON FUNCTION acl_check_access(ace[], text) IS 'determine if an ACL grants a specified set of permissions to the current user';

CREATE FUNCTION acl_check_access(ace[], int4)
RETURNS int4
AS 'MODULE_PATHNAME', 'acl_check_access_int4_current_user'
LANGUAGE C STRICT IMMUTABLE;

COMMENT ON FUNCTION acl_check_access(ace[], int4) IS 'determine if an ACL grants a specified set of permissions to the current user';

CREATE FUNCTION acl_check_access(ace[], text, oid)
RETURNS text
AS 'MODULE_PATHNAME', 'acl_check_access_text_oid'
LANGUAGE C STRICT IMMUTABLE;

COMMENT ON FUNCTION acl_check_access(ace[], text, oid) IS 'determine if an ACL grants a specified set of permissions to the role identified by oid';

CREATE FUNCTION acl_check_access(ace[], int4, oid)
RETURNS int4
AS 'MODULE_PATHNAME', 'acl_check_access_int4_oid'
LANGUAGE C STRICT IMMUTABLE;

COMMENT ON FUNCTION acl_check_access(ace[], int4, oid) IS 'determine if an ACL grants a specified set of permissions to the role identified by oid';

CREATE FUNCTION acl_check_access(ace[], text, name)
RETURNS text
AS 'MODULE_PATHNAME', 'acl_check_access_text_name'
LANGUAGE C STRICT IMMUTABLE;

COMMENT ON FUNCTION acl_check_access(ace[], text, name) IS 'determine if an ACL grants a specified set of permissions to the role identified by name';

CREATE FUNCTION acl_check_access(ace[], int4, name)
RETURNS int4
AS 'MODULE_PATHNAME', 'acl_check_access_int4_name'
LANGUAGE C STRICT IMMUTABLE;

COMMENT ON FUNCTION acl_check_access(ace[], int4, name) IS 'determine if an ACL grants a specified set of permissions to the role identified by name';