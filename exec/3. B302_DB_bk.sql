--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dumped by pg_dump version 14.5 (Debian 14.5-1.pgdg110+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    name character varying(10) NOT NULL,
    phone_number character varying(13) NOT NULL,
    department character varying(20) NOT NULL,
    is_admin boolean NOT NULL,
    activation integer NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: cctvs_cctv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cctvs_cctv (
    id bigint NOT NULL,
    name character varying(20) NOT NULL,
    video character varying(20) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.cctvs_cctv OWNER TO postgres;

--
-- Name: cctvs_cctv_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cctvs_cctv_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cctvs_cctv_id_seq OWNER TO postgres;

--
-- Name: cctvs_cctv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cctvs_cctv_id_seq OWNED BY public.cctvs_cctv.id;


--
-- Name: cctvs_upload; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cctvs_upload (
    id bigint NOT NULL,
    video_file character varying(100) NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.cctvs_upload OWNER TO postgres;

--
-- Name: cctvs_upload_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cctvs_upload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cctvs_upload_id_seq OWNER TO postgres;

--
-- Name: cctvs_upload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cctvs_upload_id_seq OWNED BY public.cctvs_upload.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: missingchilds_child; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.missingchilds_child (
    id bigint NOT NULL,
    child_img character varying(100),
    missing_time timestamp with time zone NOT NULL,
    age integer NOT NULL,
    name character varying(10) NOT NULL,
    find boolean NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.missingchilds_child OWNER TO postgres;

--
-- Name: missingchilds_child_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.missingchilds_child_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.missingchilds_child_id_seq OWNER TO postgres;

--
-- Name: missingchilds_child_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.missingchilds_child_id_seq OWNED BY public.missingchilds_child.id;


--
-- Name: token_blacklist_blacklistedtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_blacklist_blacklistedtoken (
    id bigint NOT NULL,
    blacklisted_at timestamp with time zone NOT NULL,
    token_id bigint NOT NULL
);


ALTER TABLE public.token_blacklist_blacklistedtoken OWNER TO postgres;

--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.token_blacklist_blacklistedtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.token_blacklist_blacklistedtoken_id_seq OWNER TO postgres;

--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.token_blacklist_blacklistedtoken_id_seq OWNED BY public.token_blacklist_blacklistedtoken.id;


--
-- Name: token_blacklist_outstandingtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_blacklist_outstandingtoken (
    id bigint NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone,
    expires_at timestamp with time zone NOT NULL,
    user_id bigint,
    jti character varying(255) NOT NULL
);


ALTER TABLE public.token_blacklist_outstandingtoken OWNER TO postgres;

--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.token_blacklist_outstandingtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.token_blacklist_outstandingtoken_id_seq OWNER TO postgres;

--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.token_blacklist_outstandingtoken_id_seq OWNED BY public.token_blacklist_outstandingtoken.id;


--
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: cctvs_cctv id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cctvs_cctv ALTER COLUMN id SET DEFAULT nextval('public.cctvs_cctv_id_seq'::regclass);


--
-- Name: cctvs_upload id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cctvs_upload ALTER COLUMN id SET DEFAULT nextval('public.cctvs_upload_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: missingchilds_child id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missingchilds_child ALTER COLUMN id SET DEFAULT nextval('public.missingchilds_child_id_seq'::regclass);


--
-- Name: token_blacklist_blacklistedtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken ALTER COLUMN id SET DEFAULT nextval('public.token_blacklist_blacklistedtoken_id_seq'::regclass);


--
-- Name: token_blacklist_outstandingtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken ALTER COLUMN id SET DEFAULT nextval('public.token_blacklist_outstandingtoken_id_seq'::regclass);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, name, phone_number, department, is_admin, activation) FROM stdin;
2	pbkdf2_sha256$260000$5D6DNJGOeAhFIeWf64WPsQ$nelj6uopuf5u4XY7cHUhlU1knyt3W23QpPap5r1ACfM=	\N	f	admin			admin@j7b302.com	f	t	2022-09-28 09:36:06.577777+00	관리자	010-0000-0000	admin	t	1
6	pbkdf2_sha256$260000$4G1b8ZqE5l7vPF2qguVGln$KKK+vV5zkommVN04smqzfXIUoRL81/YSBbx3dio8ydk=	\N	f	sj2			sjp@j7b302.com	f	t	2022-09-28 09:40:41.127163+00	전승준2	010-0000-0000	승주운	f	0
7	pbkdf2_sha256$260000$ox3nHKzrzVAeZd6fDARalL$RSgPZcQ5Ul5yNQI53ygbkE8qlPV2t3TVUFMiHg/Z6ZU=	\N	f	sj3			sjp@j7b302.com	f	t	2022-09-28 09:40:44.138973+00	전승준3	010-0000-0000	승주운	f	0
8	pbkdf2_sha256$260000$tOHxhxa9q67MpuJaobrDMm$h5QOJ1Ap0YfOQjv3YNzoY3FcEzCjUNO2rhYylIFI3v0=	\N	f	sj4			sjp@j7b302.com	f	t	2022-09-28 09:40:47.664202+00	전승준4	010-0000-0000	승주운	f	0
10	pbkdf2_sha256$260000$0TzMpBVHbVcgxqztwhwYhZ$V4bKJp0dFtHY9nBrJ/u7+3e43ejy2juvPcXfmBsJbRY=	\N	f	sj5			sjp@j7b302.com	f	t	2022-09-28 09:41:44.855953+00	이성훈	010-0000-0000	흡연	f	0
1	pbkdf2_sha256$260000$KMz8uC7JgJZflVzNbTSgdw$XnxU/fqghBeU+MVqoIz2TSos6V6vGNrPuDM6pK7yt+4=	\N	f	sj9			jsznawa@j7b302.com	f	t	2022-09-28 09:31:02.624312+00	zl존승준lz	010-0000-0000	승준	f	1
3	pbkdf2_sha256$260000$C9Vf6SU8hARfAI3ypoTFQA$2Izg0+vdsfovNa2MHifQD+WO+1u4JA177R3ab4MuP9g=	\N	f	u1			jsznawa@j7b302.com	f	t	2022-09-28 09:39:51.420095+00	박승주	010-0000-0000	승준	f	1
4	pbkdf2_sha256$260000$rnYvgvV3nHFlNOicxmdmyd$VGESLZEazfnxG0luI5/hbHVQE8SGvFpfU/YrLkEMbFA=	\N	f	u2			sjp@j7b302.com	f	t	2022-09-28 09:40:16.894011+00	박승주박	010-0000-0000	승주팤	f	1
9	pbkdf2_sha256$260000$EC9cBqj8Tig6muDAu0Gh9V$T3a+lb8V8HtajJI67mv6RfNopcdlMQ7ae8smz3JwKH4=	\N	f	lsh			sjp@j7b302.com	f	t	2022-09-28 09:41:36.446149+00	이성훈	010-0000-0000	흡연	f	1
5	pbkdf2_sha256$260000$hd9OiieRnq0SyxFWquhRkZ$ReOC37Sp28TkCJdgVSQjcCWWyGfgE5MWoaTfk6X9uWs=	\N	f	sj			sjp@j7b302.com	f	t	2022-09-28 09:40:33.904242+00	전승준	010-0000-0000	승주팤	f	1
11	pbkdf2_sha256$260000$nbhAmHDBv0Reaabte7tAmc$bxj6YMPut5QQ53PH7b0aFpt+USFBjoGjuWPWYh/QtoQ=	\N	f	jangjh98			jangjr98@naver.com	f	t	2022-09-29 04:44:53.99722+00	장종훈	010-4444-4444	ssafy	f	1
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add user	1	add_user
2	Can change user	1	change_user
3	Can delete user	1	delete_user
4	Can view user	1	view_user
5	Can add upload	2	add_upload
6	Can change upload	2	change_upload
7	Can delete upload	2	delete_upload
8	Can view upload	2	view_upload
9	Can add cctv	3	add_cctv
10	Can change cctv	3	change_cctv
11	Can delete cctv	3	delete_cctv
12	Can view cctv	3	view_cctv
13	Can add child	4	add_child
14	Can change child	4	change_child
15	Can delete child	4	delete_child
16	Can view child	4	view_child
17	Can add blacklisted token	5	add_blacklistedtoken
18	Can change blacklisted token	5	change_blacklistedtoken
19	Can delete blacklisted token	5	delete_blacklistedtoken
20	Can view blacklisted token	5	view_blacklistedtoken
21	Can add outstanding token	6	add_outstandingtoken
22	Can change outstanding token	6	change_outstandingtoken
23	Can delete outstanding token	6	delete_outstandingtoken
24	Can view outstanding token	6	view_outstandingtoken
25	Can add log entry	7	add_logentry
26	Can change log entry	7	change_logentry
27	Can delete log entry	7	delete_logentry
28	Can view log entry	7	view_logentry
29	Can add permission	8	add_permission
30	Can change permission	8	change_permission
31	Can delete permission	8	delete_permission
32	Can view permission	8	view_permission
33	Can add group	9	add_group
34	Can change group	9	change_group
35	Can delete group	9	delete_group
36	Can view group	9	view_group
37	Can add content type	10	add_contenttype
38	Can change content type	10	change_contenttype
39	Can delete content type	10	delete_contenttype
40	Can view content type	10	view_contenttype
41	Can add session	11	add_session
42	Can change session	11	change_session
43	Can delete session	11	delete_session
44	Can view session	11	view_session
\.


--
-- Data for Name: cctvs_cctv; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cctvs_cctv (id, name, video, latitude, longitude, user_id) FROM stdin;
3	agag	asdf	33.44701070721948	126.58046643029785	3
7	agagh	asdf	33.46303071359415	126.57212792659405	3
8	djdj	asdf	33.44846172979917	126.5938388777881	3
2	ag	asdf	33.45953534808106	126.59443264146574	3
9	kakaosj	asdf	33.4524611614357	126.57131938799078	5
11	sdfg	asdf	33.45752422501501	126.565012805882	3
12	ㄴㅇㅀ	asdf	33.46056731716612	126.60126907955627	3
13	ㄶㄶ	asdf	33.45426937017684	126.59424203986552	3
16	dfsgf	asdf	33.44649769676006	126.56760601338058	2
5	sj	asdf	33.45703509038292	126.56129789358195	3
14	노노	asdf	33.46467092723819	126.57718003795446	3
15	agag	asdf	33.449058316650564	126.602096129673	2
18	ag	asdf	33.45720600486819	126.57727651117453	2
19	af	asdf	33.44340624520953	126.58104301783084	3
20	adsf	asdf	33.43849235349514	126.56786080452642	3
22	asdf	asdf	33.452894963550946	126.57161841344289	3
23	shshs	asdf	33.452594037740894	126.55780961370996	3
24	AGA	asdf	33.462797660501586	126.5571123983281	3
25	SHSHSH	asdf	33.46392558325641	126.55990349926155	3
6	gag	asdf	33.477809117596415	126.60226599520598	3
27	FDGHDFGH	asdf	33.45644308442918	126.58631538268553	3
26	SDFGSDFG	asdf	33.47094044565865	126.58620348058767	3
17	af	asdf	33.46296118433767	126.5781478601192	2
\.


--
-- Data for Name: cctvs_upload; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cctvs_upload (id, video_file, user_id) FROM stdin;
1	video/20220929/a1abe46e6d4e401284befeeab4ebdb48.mkv	3
2	video/20220929/18cc6e5e5c014be59308719795c645b0.mkv	3
3	video/20220929/94d3e3660782466cad26f3683b4e4a72.mkv	2
4	video/20220929/fff85fe455f7486d8e59119431c962cf.mkv	2
5	video/20220929/91d7ce50454c4b7d9d35442fd38cc714.mkv	2
6	video/20220929/006d6c9da65f421da227ae02da80cf3e.mp4	3
7	video/20220929/a2b912d161464f65b3b1de3bbc89072e.mkv	3
8	video/20220929/f747566d1bde45d2978978a23341d507.mkv	3
9	video/20220929/652df030a9914e64ad40250f025b674a.mkv	3
10	video/20220929/13f9466ef8454e9899acc74c0af767ad.mp4	3
11	video/20220929/e38bec48a5c34273ae4fd7b655fdce4a.mp4	3
12	video/20220929/ac32577dda6e4e9288b194a570a3b572.mp4	3
13	video/20220929/e492c3864351431e9f1555fb346b41d7.mp4	3
14	video/20220929/34dee4a461574d62b3a02a7c95323849.mp4	3
15	video/20220929/c6e7cd486c154431b9fc587eeec77700.mp4	3
16	video/20220929/037b9a1df1e84f41acc3018bb9ec6ec4.mp4	3
17	video/20220929/a5853840a7b946f8a621e4e957c55cba.mp4	3
18	video/20220929/c8eb7e9170994ef683854b999a5ae002.mp4	3
19	video/20220929/be21f535ee074c839dfbbf8f4afd1564.mp4	3
20	video/20220929/eca944b5a9fe46b281315cfd2e833bfa.mp4	3
21	video/20220929/4c7644fa8e734b47833a46a93657e559.mp4	2
22	video/20220929/465ce29cebe24f0d8d09ed5ad3b8639c.mkv	2
23	video/20220929/7341dc1b275e4cd39af634b2d8f3ba1a.mp4	2
24	video/20220929/871d58143b944e5fb73e6f51b463ec04.mp4	2
25	video/20220929/bb984290b5b94d75907d5c8a0e4e8aba.mp4	2
26	video/20220929/c245e558c2324b1c963c8029b11ee1bb.mp4	2
27	video/20220929/1453c4289a1b4fbd8e5f938cd5ef857d.mp4	2
28	video/20220929/4b988934264a42f3afa35e26b63d9a1f.mp4	2
29	video/20220929/1dd2eef8202d41a7aacbf68d91b20048.mp4	2
30	video/20220929/95745b886353421d96b52adbe807a602.mp4	2
31	video/20220929/3abe5791033441b1be6f4f2a565437f3.mp4	2
32	video/20220929/c616cdc4a21b4f3781fb268cef609e17.mp4	2
33	video/20220929/9b50bbd908564c9181f486fc63b7eebf.mp4	2
34	video/20220929/06b64a71028a4a1a8d2c1db6e9a428f0.mp4	2
35	video/20220930/8c3425c638d34c63aab6e5291c023933.mp4	2
36	video/20220930/bdbf5f66f8204335a12cd9c9f7d4aeeb.mp4	2
37	video/20220930/b140067ce99e4f3b87a7609871bc5154.mp4	2
38	video/20220930/77bbf86e2e90403d83457259568d8f40.mp4	2
39	video/20221001/82ff791352af4a2e9cd3a56da14e65f9.mp4	2
40	video/20221001/099e44748e0b4517b526e077efedabf0.mp4	2
41	video/20221001/a4aaade0791b4fbe996306265e51628b.mp4	2
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	accounts	user
2	cctvs	upload
3	cctvs	cctv
4	missingchilds	child
5	token_blacklist	blacklistedtoken
6	token_blacklist	outstandingtoken
7	admin	logentry
8	auth	permission
9	auth	group
10	contenttypes	contenttype
11	sessions	session
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-09-28 09:30:32.658487+00
2	contenttypes	0002_remove_content_type_name	2022-09-28 09:30:32.668105+00
3	auth	0001_initial	2022-09-28 09:30:32.736082+00
4	auth	0002_alter_permission_name_max_length	2022-09-28 09:30:32.742823+00
5	auth	0003_alter_user_email_max_length	2022-09-28 09:30:32.749746+00
6	auth	0004_alter_user_username_opts	2022-09-28 09:30:32.756961+00
7	auth	0005_alter_user_last_login_null	2022-09-28 09:30:32.76361+00
8	auth	0006_require_contenttypes_0002	2022-09-28 09:30:32.766522+00
9	auth	0007_alter_validators_add_error_messages	2022-09-28 09:30:32.77368+00
10	auth	0008_alter_user_username_max_length	2022-09-28 09:30:32.780722+00
11	auth	0009_alter_user_last_name_max_length	2022-09-28 09:30:32.789133+00
12	auth	0010_alter_group_name_max_length	2022-09-28 09:30:32.79723+00
13	auth	0011_update_proxy_permissions	2022-09-28 09:30:32.80418+00
14	auth	0012_alter_user_first_name_max_length	2022-09-28 09:30:32.810799+00
15	accounts	0001_initial	2022-09-28 09:30:32.878798+00
16	admin	0001_initial	2022-09-28 09:30:32.907738+00
17	admin	0002_logentry_remove_auto_add	2022-09-28 09:30:32.918434+00
18	admin	0003_logentry_add_action_flag_choices	2022-09-28 09:30:32.928804+00
19	cctvs	0001_initial	2022-09-28 09:30:32.970729+00
20	missingchilds	0001_initial	2022-09-28 09:30:32.994277+00
21	sessions	0001_initial	2022-09-28 09:30:33.013415+00
22	token_blacklist	0001_initial	2022-09-28 09:30:33.066018+00
23	token_blacklist	0002_outstandingtoken_jti_hex	2022-09-28 09:30:33.080444+00
24	token_blacklist	0003_auto_20171017_2007	2022-09-28 09:30:33.130268+00
25	token_blacklist	0004_auto_20171017_2013	2022-09-28 09:30:33.152038+00
26	token_blacklist	0005_remove_outstandingtoken_jti	2022-09-28 09:30:33.166269+00
27	token_blacklist	0006_auto_20171017_2113	2022-09-28 09:30:33.18052+00
28	token_blacklist	0007_auto_20171017_2214	2022-09-28 09:30:33.212659+00
29	token_blacklist	0008_migrate_to_bigautofield	2022-09-28 09:30:33.272264+00
30	token_blacklist	0010_fix_migrate_to_bigautofield	2022-09-28 09:30:33.292082+00
31	token_blacklist	0011_linearizes_history	2022-09-28 09:30:33.295018+00
32	token_blacklist	0012_alter_outstandingtoken_user	2022-09-28 09:30:33.308504+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: missingchilds_child; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.missingchilds_child (id, child_img, missing_time, age, name, find, user_id) FROM stdin;
16	image/20220929/48bb1e383a174b3292671dee4142ec8a.jpg	2022-09-29 05:12:54.723223+00	12	잼민	f	5
18	image/20220929/d206b21a50884622b3f7cf6555a7143e.jpg	2022-09-29 06:07:55.425316+00	12	잼민	f	5
19	image/20220929/1b5883560fba4cc28ae9c33809174828.png	2022-09-29 07:04:32.216225+00	1	u1	f	2
\.


--
-- Data for Name: token_blacklist_blacklistedtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_blacklist_blacklistedtoken (id, blacklisted_at, token_id) FROM stdin;
\.


--
-- Data for Name: token_blacklist_outstandingtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_blacklist_outstandingtoken (id, token, created_at, expires_at, user_id, jti) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU2NzU1MiwiaWF0IjoxNjY0MzU3OTUyLCJqdGkiOiJhNTEzNmQ3OWQxNjE0NWVjYTRjMjRiODdiZWMzY2I2NSIsInVzZXJfaWQiOjJ9.Y21nXuxprCLaBJrld-lZKXI0Fovbv0VMwtNO9bKD6kU	2022-09-28 09:39:12.773176+00	2022-10-12 09:39:12+00	2	a5136d79d16145eca4c24b87bec3cb65
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU3MzcwMiwiaWF0IjoxNjY0MzY0MTAyLCJqdGkiOiJjZDk3MmUwZDBkZWM0NmFiYjI3MzRiMTUyNGM3ZDBmMyIsInVzZXJfaWQiOjV9.WNaJcYzSDCy2WyQu1Bd2_SNWHrvI5aP0eDEZBtstNHM	2022-09-28 11:21:42.353585+00	2022-10-12 11:21:42+00	5	cd972e0d0dec46abb2734b1524c7d0f3
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU3ODAxMCwiaWF0IjoxNjY0MzY4NDEwLCJqdGkiOiI2ODJmYmVhN2NhMWQ0M2NjOWVlOTY3MzJiZjhjMTY0ZSIsInVzZXJfaWQiOjN9.c1GRs6RwIejScm5XDBuP47BX9Rio8kDgeaajSU22O-k	2022-09-28 12:33:30.799716+00	2022-10-12 12:33:30+00	3	682fbea7ca1d43cc9ee96732bf8c164e
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU4MTE5OCwiaWF0IjoxNjY0MzcxNTk4LCJqdGkiOiJhYzNjZDhkNTVmYTQ0MGJhYWQ5NWYwMjJiNWUyMGU2YyIsInVzZXJfaWQiOjJ9.pX1v40TjuHi8AKxHrCHJ1mmao5zWtMLsqIXQi8WRPIs	2022-09-28 13:26:38.386616+00	2022-10-12 13:26:38+00	2	ac3cd8d55fa440baad95f022b5e20e6c
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU4MjE3NCwiaWF0IjoxNjY0MzcyNTc0LCJqdGkiOiIxNGYzMzFhMGU5NDM0YzgxODgxMjMyNDE2YjljMjRhMCIsInVzZXJfaWQiOjJ9.UTFPv_1LtybCKIQ3ZHIa9A3d2y1UWLMJbSQahhJbtpc	2022-09-28 13:42:54.232661+00	2022-10-12 13:42:54+00	2	14f331a0e9434c81881232416b9c24a0
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU4MjI1OCwiaWF0IjoxNjY0MzcyNjU4LCJqdGkiOiIzNmU2OTVhM2NmMDc0MTQxOTc5OGFhMWNmMDU2ZTdhNyIsInVzZXJfaWQiOjJ9.5lSUvDG-tiv6knotXRuqnfW-VUd-WbRsiipupQaEsL8	2022-09-28 13:44:18.035852+00	2022-10-12 13:44:18+00	2	36e695a3cf0741419798aa1cf056e7a7
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU4NDE3MCwiaWF0IjoxNjY0Mzc0NTcwLCJqdGkiOiI2NWM0MTIxZmZmNTA0YjBjODAwN2NmZTZjODQyZDc1ZiIsInVzZXJfaWQiOjJ9.0gp72eHoUkZxcn20BEBkRlnKwFhKWuspizeeF8Z1IFo	2022-09-28 14:16:10.149553+00	2022-10-12 14:16:10+00	2	65c4121fff504b0c8007cfe6c842d75f
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU4NTY3MSwiaWF0IjoxNjY0Mzc2MDcxLCJqdGkiOiIyNGZkYjVmOWQzZjM0N2U4YmE0MTVmYzI2MWZiMzQ2NiIsInVzZXJfaWQiOjJ9.p_m4zbcIYMCyV-4OP40Oiz-OywEn9jYtkQOh_cV-7I8	2022-09-28 14:41:11.531737+00	2022-10-12 14:41:11+00	2	24fdb5f9d3f347e8ba415fc261fb3466
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU4ODU5MCwiaWF0IjoxNjY0Mzc4OTkwLCJqdGkiOiI1MDk4MTRhYzFiMDE0YmJhOTExMThjMWVhNmVhYmMyZSIsInVzZXJfaWQiOjJ9.gYzRxptBfm9v8blyt0MBm4OpP0KIcpY1KowqtOgnm9A	2022-09-28 15:29:50.95905+00	2022-10-12 15:29:50+00	2	509814ac1b014bba91118c1ea6eabc2e
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTU5NDYyMywiaWF0IjoxNjY0Mzg1MDIzLCJqdGkiOiI2MjQ2YTk1N2Q5NWM0ZTQ3YjQ3YTExMjk5OGE5M2U3YyIsInVzZXJfaWQiOjJ9.WWTQItlQ4rVGzzJtUbhetSzKmisuG7k2fu2cwust5GY	2022-09-28 17:10:23.100186+00	2022-10-12 17:10:23+00	2	6246a957d95c4e47b47a112998a93e7c
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYwOTE4MSwiaWF0IjoxNjY0Mzk5NTgxLCJqdGkiOiIxZGZlZTFiNGRhY2Y0NjNlODJmYTVmZTZjZDdlZjgzMyIsInVzZXJfaWQiOjN9.A_UOeJvRbqX2N4Du08Hppsq6KGPJY6zfFRkTx_TurxI	2022-09-28 21:13:01.179732+00	2022-10-12 21:13:01+00	3	1dfee1b4dacf463e82fa5fe6cd7ef833
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYxOTExNywiaWF0IjoxNjY0NDA5NTE3LCJqdGkiOiJiM2EyOTMyMzFmMzQ0MDFkYTlhN2U5M2ZmNjlkMWQ0MCIsInVzZXJfaWQiOjJ9.v5iaXPNueQKF22wsO9MLAYxY18XL8E4RXgqgWhwLc_s	2022-09-28 23:58:37.107018+00	2022-10-12 23:58:37+00	2	b3a293231f34401da9a7e93ff69d1d40
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYxOTExNywiaWF0IjoxNjY0NDA5NTE3LCJqdGkiOiIwNTc3MjUyZTJmMTI0YWM5YWI2ODYyOGQ3Y2M2MDJiOCIsInVzZXJfaWQiOjJ9.-ag1ap8W6IXXMlWEyHXlszHyYfi7ny0YPSPozkJihew	2022-09-28 23:58:37.327096+00	2022-10-12 23:58:37+00	2	0577252e2f124ac9ab68628d7cc602b8
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYxOTEzOCwiaWF0IjoxNjY0NDA5NTM4LCJqdGkiOiIxZDRmYjgxNTI3N2Y0NDdiYjVlMTk4Zjk5YTc4NWU5NiIsInVzZXJfaWQiOjN9._MY0KJ6ISEoX9LANJ-ZpbTHqRHpVBW5XXuLesy7fcwk	2022-09-28 23:58:58.816807+00	2022-10-12 23:58:58+00	3	1d4fb815277f447bb5e198f99a785e96
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYyNDQxMiwiaWF0IjoxNjY0NDE0ODEyLCJqdGkiOiJjNWEwMDM0NmIxN2U0OTdlOTFkNjkyYjVhNDhiNjcxNCIsInVzZXJfaWQiOjJ9.Ocl3-jgwjmN9s4AOONqOZVT-5Py69rVzT0DBXuve1AQ	2022-09-29 01:26:52.635634+00	2022-10-13 01:26:52+00	2	c5a00346b17e497e91d692b5a48b6714
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYyNTU5MCwiaWF0IjoxNjY0NDE1OTkwLCJqdGkiOiI4OTIzZWY2NjM4NmI0YjRiOTYxOTRhYWZiYzY3MjNjZCIsInVzZXJfaWQiOjJ9.HkRn53tGae_OHz7dl-nybxsW5X8KTr5JhG-ZF74qXzU	2022-09-29 01:46:30.707441+00	2022-10-13 01:46:30+00	2	8923ef66386b4b4b96194aafbc6723cd
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYyNTU5OCwiaWF0IjoxNjY0NDE1OTk4LCJqdGkiOiI0NWJiMmFlZWJlOTY0ZDUxYmVmYjBkNGFmMzdjZGI5OCIsInVzZXJfaWQiOjN9.eynPdAV4HK4h7wHKIyiAwgZZQS4YqKTzsCdeqfG-Qos	2022-09-29 01:46:38.218936+00	2022-10-13 01:46:38+00	3	45bb2aeebe964d51befb0d4af37cdb98
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYyNjAzMywiaWF0IjoxNjY0NDE2NDMzLCJqdGkiOiJjZWZjYTI4OGFiZGU0ZmM3ODA1ODJlOTYwODc1NDVhZiIsInVzZXJfaWQiOjJ9.jEfqlc-jrOrl9MkaEkkMWeMUfXyqVzN8DIzmWODcE_k	2022-09-29 01:53:53.026426+00	2022-10-13 01:53:53+00	2	cefca288abde4fc780582e96087545af
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYyNjA3MSwiaWF0IjoxNjY0NDE2NDcxLCJqdGkiOiJkZTJjNGE4NWFjYjY0MDlhYTAwNTM1YzM3MjY1NWU2YSIsInVzZXJfaWQiOjJ9.7hV00RXQKBQNb3VowbWuHnmgsSeusiHUfu_3m3PEWLs	2022-09-29 01:54:31.272895+00	2022-10-13 01:54:31+00	2	de2c4a85acb6409aa00535c372655e6a
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYyNjIwNCwiaWF0IjoxNjY0NDE2NjA0LCJqdGkiOiJlODRkYzNiNmZjMTU0ZGJjOWRmNGNhNTg5YThkMjg0YSIsInVzZXJfaWQiOjJ9.cxGhYHB25cKgZ_ZKs2Vbp60-XpQeaIbKn7rwNL_IhmM	2022-09-29 01:56:44.419154+00	2022-10-13 01:56:44+00	2	e84dc3b6fc154dbc9df4ca589a8d284a
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYyNjM3NywiaWF0IjoxNjY0NDE2Nzc3LCJqdGkiOiJmOTlhNzIxODhhMTI0YTg3YWY2NWUxM2Y0YzczZGE5YiIsInVzZXJfaWQiOjJ9.fJ-A7wh8ziN4eKox3Tmo_npIgfi_lm3JW_P1u3Uxi4U	2022-09-29 01:59:37.889467+00	2022-10-13 01:59:37+00	2	f99a72188a124a87af65e13f4c73da9b
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYyNjc0OCwiaWF0IjoxNjY0NDE3MTQ4LCJqdGkiOiI5ZGVjNzBmOTA0ZmQ0NjI5YjI5N2ZlY2RkMDViYTIyNyIsInVzZXJfaWQiOjJ9.auvMkYa2q6cO8ojCxqe4NMXTAHrHzzMXD376IKdDsFk	2022-09-29 02:05:48.455308+00	2022-10-13 02:05:48+00	2	9dec70f904fd4629b297fecdd05ba227
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzMTE1NCwiaWF0IjoxNjY0NDIxNTU0LCJqdGkiOiJmYmU3YmZhYTc1NDU0MWQ0OGY5OTQ1MWQ2MzBmNGIwOCIsInVzZXJfaWQiOjN9.-B5vcMHOAkWesRN1jaMo4zWtrpi_rCTlvzPPQHEguI0	2022-09-29 03:19:14.539258+00	2022-10-13 03:19:14+00	3	fbe7bfaa754541d48f99451d630f4b08
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzMjAzMiwiaWF0IjoxNjY0NDIyNDMyLCJqdGkiOiI2ZjViNTM2YzAzYTI0YTU4YTgwMmNjNGFhMWI4MzdhMyIsInVzZXJfaWQiOjN9.5Y5VWs-gjeIMUsj7R6xjRmTi-3dG1XU8J0SHykW7G2k	2022-09-29 03:33:52.294768+00	2022-10-13 03:33:52+00	3	6f5b536c03a24a58a802cc4aa1b837a3
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzMjM1MCwiaWF0IjoxNjY0NDIyNzUwLCJqdGkiOiJiY2E1ODI1NjU3ZTk0MzZkYmYzZWQzNDZmN2I5N2NlMCIsInVzZXJfaWQiOjJ9.rgkEGFqneJULf9B8-crFHxdUwoMAHf9o-ycAlzOumL8	2022-09-29 03:39:10.32937+00	2022-10-13 03:39:10+00	2	bca5825657e9436dbf3ed346f7b97ce0
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzMzI4MCwiaWF0IjoxNjY0NDIzNjgwLCJqdGkiOiI1YmZiYzg0ZjRkMTg0ODRhYmFjZWZhYTAxZDNiMzZmOSIsInVzZXJfaWQiOjJ9.yi6e9bvuQPEoZSFI3Y3nP4Jhx_Pg5uJveYw_Or-vD3Y	2022-09-29 03:54:40.82168+00	2022-10-13 03:54:40+00	2	5bfbc84f4d18484abacefaa01d3b36f9
27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzNDA1OCwiaWF0IjoxNjY0NDI0NDU4LCJqdGkiOiJjMjhiYjczNzhjODE0MTJlODM1ZjFjYjJjMDAzZDZkNiIsInVzZXJfaWQiOjV9.YlvFrRRFCcnfrNB0s97QUihv12F-fnM8wqRLb7fV0UY	2022-09-29 04:07:38.26706+00	2022-10-13 04:07:38+00	5	c28bb7378c81412e835f1cb2c003d6d6
28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzNTE0NCwiaWF0IjoxNjY0NDI1NTQ0LCJqdGkiOiI1YTJiNzY1ZGRkZTI0YTE0ODJjZjUwOTQ1ODI1MjRlZCIsInVzZXJfaWQiOjV9.yXzrrEzYEd89w4RGEti0PIjuHi7xOCGOhw1mTXbdaTE	2022-09-29 04:25:44.324636+00	2022-10-13 04:25:44+00	5	5a2b765ddde24a1482cf5094582524ed
29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzNTM2MiwiaWF0IjoxNjY0NDI1NzYyLCJqdGkiOiJjMmJhMzA1NGJhZjY0MDM4OTdlMWEwNjYxY2M5MDAxZSIsInVzZXJfaWQiOjN9.EBv__yXw8a9_LBj3rwygho5AqqHzlOU1AtPTK8sUcgM	2022-09-29 04:29:22.865493+00	2022-10-13 04:29:22+00	3	c2ba3054baf6403897e1a0661cc9001e
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzNjI2MSwiaWF0IjoxNjY0NDI2NjYxLCJqdGkiOiI1YjNkNGIwZTdiZDY0ZmM2OGVjOGIzYTJlNjkyNzBhMSIsInVzZXJfaWQiOjV9.acrVjmffbHZAk4Vyb9Csb5-QKzmyAMn6E_k_dW5Bwqw	2022-09-29 04:44:21.017605+00	2022-10-13 04:44:21+00	5	5b3d4b0e7bd64fc68ec8b3a2e69270a1
31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzNjMxNiwiaWF0IjoxNjY0NDI2NzE2LCJqdGkiOiI1N2U1MjRiZjAxNGI0YTkzOWVmNzFmNTI5MjQwNWJlYiIsInVzZXJfaWQiOjJ9.DaaJ_VKxffYNhY3l741tt9UjJ_yIa0J0ZBQBH8stw-Q	2022-09-29 04:45:16.96709+00	2022-10-13 04:45:16+00	2	57e524bf014b4a939ef71f5292405beb
32	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzNzczMSwiaWF0IjoxNjY0NDI4MTMxLCJqdGkiOiI0MzhmZjFkNDBlZDk0OTk3YmU5ODI4M2MyNDhkZWY3MCIsInVzZXJfaWQiOjV9.rdrAmxLa87SOc3QUFvjW4Lscldk0rIATGneoOCpADsI	2022-09-29 05:08:51.168619+00	2022-10-13 05:08:51+00	5	438ff1d40ed94997be98283c248def70
33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTYzNzk2MiwiaWF0IjoxNjY0NDI4MzYyLCJqdGkiOiJlNjU5YThjNDM3OGY0ODZlODM1MGRmNjcwMzU3YTA1NSIsInVzZXJfaWQiOjN9.3MF2nt3ZNyLowLmP4sRkBHNRVl01uSpabzfs3WrAf0Y	2022-09-29 05:12:42.333822+00	2022-10-13 05:12:42+00	3	e659a8c4378f486e8350df670357a055
34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY0MTI0NiwiaWF0IjoxNjY0NDMxNjQ2LCJqdGkiOiIzM2UxOWM3YzIxODc0NGE4OWRlZDNiYjE0Y2U4MjU3MyIsInVzZXJfaWQiOjV9.hYy3-KV1wkM0wj8yPfbdPF5d1HMItHntLQm6VC9FDGg	2022-09-29 06:07:26.659102+00	2022-10-13 06:07:26+00	5	33e19c7c218744a89ded3bb14ce82573
35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY0MTk3MywiaWF0IjoxNjY0NDMyMzczLCJqdGkiOiJlMTk1ZTlkMmE2NmY0NDUwYjdlNmRhMDAzMmZiZWJjZCIsInVzZXJfaWQiOjJ9._te0JCL4s8i14vI1wIw4USdxAOm_OrKu5pWJZ6-Yl7Q	2022-09-29 06:19:33.568306+00	2022-10-13 06:19:33+00	2	e195e9d2a66f4450b7e6da0032fbebcd
36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY0MjE4MiwiaWF0IjoxNjY0NDMyNTgyLCJqdGkiOiI2MmI5MGI0MzVjM2M0OTk1YmIwZDhhYzlhYTMxMjFkNyIsInVzZXJfaWQiOjJ9.g1CAd7bhYub3BuAgvTgEDpw2avAKxAAtjV9nbq9GIz4	2022-09-29 06:23:02.002415+00	2022-10-13 06:23:02+00	2	62b90b435c3c4995bb0d8ac9aa3121d7
37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY0NDk3NSwiaWF0IjoxNjY0NDM1Mzc1LCJqdGkiOiI3YzdhNGFhMTFmOGE0ZDRiYTY3MzU3ZTUxMDJjNzlmNSIsInVzZXJfaWQiOjJ9.DNONXkY3YNLRG0T7Zy6j18l9xt6sY1qlrKeXZlJyHy0	2022-09-29 07:09:35.406288+00	2022-10-13 07:09:35+00	2	7c7a4aa11f8a4d4ba67357e5102c79f5
38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY0Njk2NywiaWF0IjoxNjY0NDM3MzY3LCJqdGkiOiI5M2ZiNjY1NTJhNGQ0MTFmYWM1ZTFkNDhmYmI3OTYwNCIsInVzZXJfaWQiOjN9.DuXvcSDqw3GcBLvOPROpYLohmUQD0sZJ291fLyKW03Y	2022-09-29 07:42:47.295348+00	2022-10-13 07:42:47+00	3	93fb66552a4d411fac5e1d48fbb79604
39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY0Nzg4NSwiaWF0IjoxNjY0NDM4Mjg1LCJqdGkiOiIyNmRmMGIwYTNjZjA0ZmE0YjY3NGQ0ODQ2MWUwNzk4MiIsInVzZXJfaWQiOjJ9.10I3fxwm2r0pMqX9QssKdqU-LrOq77BQci-G6q_Yz88	2022-09-29 07:58:05.023616+00	2022-10-13 07:58:05+00	2	26df0b0a3cf04fa4b674d48461e07982
40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY1MDc5MiwiaWF0IjoxNjY0NDQxMTkyLCJqdGkiOiIyOTNkNmIyYWU2NDk0ZTcyOTcyMzk4ODUyYzE5NDRkNCIsInVzZXJfaWQiOjJ9.NZT9rGOAGQmD5Jw_MYYag667UuKxyNoe_yK1oyFyvsw	2022-09-29 08:46:32.538985+00	2022-10-13 08:46:32+00	2	293d6b2ae6494e72972398852c1944d4
41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY1MTQyNiwiaWF0IjoxNjY0NDQxODI2LCJqdGkiOiIyZGE4M2U4ZGJhZDQ0YTIxYjMwOTEwZGE3OGE3MGZjOCIsInVzZXJfaWQiOjN9.09JbOCqI7JlbEP7buunBN8Xb7Rdc4xEah1XdIxwaUi4	2022-09-29 08:57:06.682013+00	2022-10-13 08:57:06+00	3	2da83e8dbad44a21b30910da78a70fc8
42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY1MTU2OSwiaWF0IjoxNjY0NDQxOTY5LCJqdGkiOiI0MDQ4ZTZjOGMyZGU0NDA2OTZhOTdkYzRkN2FiOTk2MyIsInVzZXJfaWQiOjJ9.qdGdTIFUOsp6M1H7iBCpPlGXpjHcv-dsWXUtDUh5zd4	2022-09-29 08:59:29.750755+00	2022-10-13 08:59:29+00	2	4048e6c8c2de440696a97dc4d7ab9963
43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTY5ODQxMiwiaWF0IjoxNjY0NDg4ODEyLCJqdGkiOiJlYTg3MGY5YjU5NzM0MjcwOTliZjVhNmIxMTBjNGEyOSIsInVzZXJfaWQiOjN9.NfYC4_68rROfaJ79p1PFXGCdzNgtD_m9JGk9ePLng08	2022-09-29 22:00:12.08701+00	2022-10-13 22:00:12+00	3	ea870f9b5973427099bf5a6b110c4a29
44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcwNzAxNywiaWF0IjoxNjY0NDk3NDE3LCJqdGkiOiI1YzBmY2YzZjhiZDA0ZDQ3OTM2YTE3ODEwYWZlOTVlZSIsInVzZXJfaWQiOjN9.cN7v5QQ-uK3RIgCTdSs_HQfTJ7OSGiUAS3Fd7rM6kQs	2022-09-30 00:23:37.307153+00	2022-10-14 00:23:37+00	3	5c0fcf3f8bd04d47936a17810afe95ee
45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcwNzU3OSwiaWF0IjoxNjY0NDk3OTc5LCJqdGkiOiI4NjQ0OWY3NjBkNDY0YzRmYmNlY2Y1ODUyYTIxZTc1MCIsInVzZXJfaWQiOjJ9.l2ZvDIpFua0ffau4aU7rhKnid0kE36dM_MLd5ekcYyk	2022-09-30 00:32:59.171876+00	2022-10-14 00:32:59+00	2	86449f760d464c4fbcecf5852a21e750
46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxMDkyNSwiaWF0IjoxNjY0NTAxMzI1LCJqdGkiOiIwZWY1Njg3NDBmMDY0NGNhOGFkYzliOWZiYmY1NmQ5MyIsInVzZXJfaWQiOjJ9.PqJ80a_q-r8_kPfwO1-QubwJvqxs_jNX2K3HG_A6Ndk	2022-09-30 01:28:45.0811+00	2022-10-14 01:28:45+00	2	0ef568740f0644ca8adc9b9fbbf56d93
47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxMTMyMSwiaWF0IjoxNjY0NTAxNzIxLCJqdGkiOiI1NGViNDYwNDE1MzE0OGEzYjEzNjU4ZDBhYzYxNmIzYSIsInVzZXJfaWQiOjV9.q91zueoT-hb6O3staTZ5ovCMKXEP36G7hjqxOuuWRQI	2022-09-30 01:35:21.888601+00	2022-10-14 01:35:21+00	5	54eb4604153148a3b13658d0ac616b3a
48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxMTY2NiwiaWF0IjoxNjY0NTAyMDY2LCJqdGkiOiI2YmQ0N2QxNTJjZTU0MmUzYTEzYzAzMzY2NTJkMjIxOCIsInVzZXJfaWQiOjJ9.svOtI-CvHr4Js6vrly31eoNKuPI1U8Q35Ez_3sS3gDk	2022-09-30 01:41:06.309404+00	2022-10-14 01:41:06+00	2	6bd47d152ce542e3a13c0336652d2218
49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxMTk0MCwiaWF0IjoxNjY0NTAyMzQwLCJqdGkiOiJlMmI5YWQwMjEwNDc0MTI3OThkN2E0Y2JlODU4NjI5ZSIsInVzZXJfaWQiOjJ9.8LbK9MfirbkAPRQ7lRqTrV0Ddw1S7oqrOB8HhXL2nYA	2022-09-30 01:45:40.805277+00	2022-10-14 01:45:40+00	2	e2b9ad021047412798d7a4cbe858629e
50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxMzQ4MCwiaWF0IjoxNjY0NTAzODgwLCJqdGkiOiIyMjI2NmM4ZTgwYjM0N2YxOWUwZjU4MDI0YzJlZTNiOCIsInVzZXJfaWQiOjJ9.8QmcUVjj_NCrnXIanXAkpWUwiLVDCPpmhRiWvvkqVs8	2022-09-30 02:11:20.428924+00	2022-10-14 02:11:20+00	2	22266c8e80b347f19e0f58024c2ee3b8
51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxMzU0MiwiaWF0IjoxNjY0NTAzOTQyLCJqdGkiOiI2OGMzZTA1Njc3ZGY0YzQxYTM5NGNmZjFmOThmNGNkNSIsInVzZXJfaWQiOjJ9.RYjjcGfV-eT4XUyWKFRm6M2xChEEWV8CEcssQfNIkAE	2022-09-30 02:12:22.880373+00	2022-10-14 02:12:22+00	2	68c3e05677df4c41a394cff1f98f4cd5
52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxNDg5NiwiaWF0IjoxNjY0NTA1Mjk2LCJqdGkiOiJjZmVjMTZhNWZkYzI0NDUyYWU1ZmJmYjQ3ODYwYmM0OSIsInVzZXJfaWQiOjJ9.WDrTqPp72wU0WHALIUrq8K1xM1F98NJ0nV6emq_eNJg	2022-09-30 02:34:56.936379+00	2022-10-14 02:34:56+00	2	cfec16a5fdc24452ae5fbfb47860bc49
53	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxNjg3NywiaWF0IjoxNjY0NTA3Mjc3LCJqdGkiOiJlMjQxMTIxYzNiMmU0YWMzOTE3YTAzMzU2NDI1YjE1YyIsInVzZXJfaWQiOjJ9.2C5GXCIT9VL8ILmXOOVvN9u0XrCuinRK5OekvXWGMxY	2022-09-30 03:07:57.931133+00	2022-10-14 03:07:57+00	2	e241121c3b2e4ac3917a03356425b15c
54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxNjg5MywiaWF0IjoxNjY0NTA3MjkzLCJqdGkiOiIwMzdhZWNhNjJlMzg0ZmNjOTljMWU1NWNmZjU5NTA0ZCIsInVzZXJfaWQiOjJ9.MDROZ8A7cztgFI6_LHFFo3OMDGtoZW7ZfC2dHLDhRpc	2022-09-30 03:08:13.158142+00	2022-10-14 03:08:13+00	2	037aeca62e384fcc99c1e55cff59504d
55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxNjk2MCwiaWF0IjoxNjY0NTA3MzYwLCJqdGkiOiI4NzU1NGIzOGQ3ZDY0M2NhODJkOTU1YmE4MWZjMTM4YSIsInVzZXJfaWQiOjJ9.71JWnAcOW57IV1eIp0Xkg3DxTdWHnyFiJ--75vVyJs8	2022-09-30 03:09:20.208945+00	2022-10-14 03:09:20+00	2	87554b38d7d643ca82d955ba81fc138a
56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcxOTcyNiwiaWF0IjoxNjY0NTEwMTI2LCJqdGkiOiJlMTY4NGE4MjA0Mjc0ODhkYWM1ZGZhOGUzMmYyNmRlNSIsInVzZXJfaWQiOjJ9.CSxLCPFUR2NublbgnYkPdb-ksW7DVEy7YSg0Ktd1VIg	2022-09-30 03:55:26.863962+00	2022-10-14 03:55:26+00	2	e1684a820427488dac5dfa8e32f26de5
57	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyMTA4NSwiaWF0IjoxNjY0NTExNDg1LCJqdGkiOiI5NTI2MTE0OGRlMzA0YzQxOTEzNTg2NWU5MTEyYmRjMiIsInVzZXJfaWQiOjJ9.dnROnDu5o1nCyTIRFkalJ05SjpAgghhsmFT4RAUcaCc	2022-09-30 04:18:05.360597+00	2022-10-14 04:18:05+00	2	95261148de304c419135865e9112bdc2
58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyMzI0MSwiaWF0IjoxNjY0NTEzNjQxLCJqdGkiOiI5MmE4MmRlYjBlNGM0Y2FjYWUxZWY0MmQ2ZGQ5ODg3YSIsInVzZXJfaWQiOjJ9.9azK9fh6wti0HtqHhj3qxlVnxZe-N6tAL74iuK3gzJM	2022-09-30 04:54:01.699976+00	2022-10-14 04:54:01+00	2	92a82deb0e4c4cacae1ef42d6dd9887a
59	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNTQzNiwiaWF0IjoxNjY0NTE1ODM2LCJqdGkiOiIyOTg4N2VhYzIwNDc0YjFiOTg5NWZhNDk1OTRmN2EzNSIsInVzZXJfaWQiOjJ9.ErOTBTkq6t8re6PRMX1MAivHEr9s3OidfOwJ28SeZ64	2022-09-30 05:30:36.540633+00	2022-10-14 05:30:36+00	2	29887eac20474b1b9895fa49594f7a35
60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNTU3MywiaWF0IjoxNjY0NTE1OTczLCJqdGkiOiJlNmQ1NzlmMjk5OTI0NDE5OTI4Yzk0OGY2NzMyNmZmOSIsInVzZXJfaWQiOjJ9.yqRmSJxD63DAyFNnClM4KkII01G9dKWjWgxpK7iMDiM	2022-09-30 05:32:53.388048+00	2022-10-14 05:32:53+00	2	e6d579f299924419928c948f67326ff9
61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNTcwOSwiaWF0IjoxNjY0NTE2MTA5LCJqdGkiOiJhNDcwNDY1MTQ2MTA0ZGQ2OTQyNGJiYTJiZGZlM2U1MSIsInVzZXJfaWQiOjJ9.C9_jzSwPpZ7k91NCxFPyxSBmkwJq0feYyPg5UjaKO9I	2022-09-30 05:35:09.087317+00	2022-10-14 05:35:09+00	2	a470465146104dd69424bba2bdfe3e51
62	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNjE1OSwiaWF0IjoxNjY0NTE2NTU5LCJqdGkiOiJlMDNiY2UwODZmNGM0ZGFjODIzZDFjZjUwYzZjMTUyMiIsInVzZXJfaWQiOjJ9.GW-uZbElsMTC0eZOo3ZGPKBHL6trXWlnu-YA-rlsUjc	2022-09-30 05:42:39.453047+00	2022-10-14 05:42:39+00	2	e03bce086f4c4dac823d1cf50c6c1522
63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNjE4MSwiaWF0IjoxNjY0NTE2NTgxLCJqdGkiOiIxMzNmMjE3MzAwODk0MWFkOTU4YjdmMTQyODU5Mzg5NiIsInVzZXJfaWQiOjJ9.t1lnN_-6ZR48Hb1MCGkbQZHYOHNLDUk4vzONpv3-AaE	2022-09-30 05:43:01.992495+00	2022-10-14 05:43:01+00	2	133f2173008941ad958b7f1428593896
64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNjI1NSwiaWF0IjoxNjY0NTE2NjU1LCJqdGkiOiIyNDM1NmI1NDhmMzc0MmU4YTk0YTFiMTgxYzRmNDk5MyIsInVzZXJfaWQiOjJ9.OYD7GGHG2AMKpDn9jAKg7riTCBCkebvgegXOveJr8TA	2022-09-30 05:44:15.790237+00	2022-10-14 05:44:15+00	2	24356b548f3742e8a94a1b181c4f4993
65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNzUzOSwiaWF0IjoxNjY0NTE3OTM5LCJqdGkiOiI5NzYwNzAxYTI5Y2E0ODM2OTc5MWQyODYwOWE4NWI3YiIsInVzZXJfaWQiOjJ9.4yfkc6zp5FBqJ_du42bJm80Qmwc-OpMlQjQUpLRVhNA	2022-09-30 06:05:39.953726+00	2022-10-14 06:05:39+00	2	9760701a29ca48369791d28609a85b7b
66	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNzU2NiwiaWF0IjoxNjY0NTE3OTY2LCJqdGkiOiIwM2YzYjJjY2NkZGI0M2NjYjU1NWJiZjQ1NDQ5MjhjNyIsInVzZXJfaWQiOjJ9.Ky2fS2wSd2Sndbt56zVBQ5bLqIXN3SfvQAqZsOLhz-k	2022-09-30 06:06:06.1632+00	2022-10-14 06:06:06+00	2	03f3b2cccddb43ccb555bbf4544928c7
67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNzkxMSwiaWF0IjoxNjY0NTE4MzExLCJqdGkiOiIzZjU1ZmFhOTkxN2Y0ZjQ5OTgyOThhMWFmNzc4YTQ2NiIsInVzZXJfaWQiOjJ9.Q4A3DMw9TShLuK0FlxJ18e6otW906Hlsp1jOXp-Dz3U	2022-09-30 06:11:51.519569+00	2022-10-14 06:11:51+00	2	3f55faa9917f4f4998298a1af778a466
68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNzkxMywiaWF0IjoxNjY0NTE4MzEzLCJqdGkiOiJhNTQyNjM0NWM0ZTA0MmZjYmM0NWJjOWFhYzAwODRjOCIsInVzZXJfaWQiOjJ9.xmhgBRDAWfy506UB5DjPGOL-BzPezatmsM1cfwKQwNA	2022-09-30 06:11:53.006053+00	2022-10-14 06:11:53+00	2	a5426345c4e042fcbc45bc9aac0084c8
69	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNzkxMywiaWF0IjoxNjY0NTE4MzEzLCJqdGkiOiI2ZTlmY2UwNWI0Yzg0MDBjOTMyNWMyMzgwODFkZjMxYSIsInVzZXJfaWQiOjJ9.6pr7mFuck3QuGDnAL6Gccr8sMVJk4JtOJ3IVl7QTyzM	2022-09-30 06:11:53.172374+00	2022-10-14 06:11:53+00	2	6e9fce05b4c8400c9325c238081df31a
70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNzkxMywiaWF0IjoxNjY0NTE4MzEzLCJqdGkiOiIzOTRhM2FmZmQ2NWM0YTk4OWM1OGI2NmQ3NzgyMDczZiIsInVzZXJfaWQiOjJ9.NrVn5ZTvmgis9TvbQ4EDEMctGxUjZL1AZ1sH6TNRt8Y	2022-09-30 06:11:53.306608+00	2022-10-14 06:11:53+00	2	394a3affd65c4a989c58b66d7782073f
71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyNzkxMywiaWF0IjoxNjY0NTE4MzEzLCJqdGkiOiJjMjc0NWJhM2Y4NjU0MTc1YjY0NzFhNTc1NTk5NjU2NCIsInVzZXJfaWQiOjJ9.OptX5umZR__9GuO8zJRAj9WYnNUBoYPyeLi3GnZTM-o	2022-09-30 06:11:53.475212+00	2022-10-14 06:11:53+00	2	c2745ba3f8654175b6471a5755996564
72	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyOTIzMiwiaWF0IjoxNjY0NTE5NjMyLCJqdGkiOiI0OWVjZjgwOGI2YTc0YjNmOWU0NThmNmIxMjJkZjZjOCIsInVzZXJfaWQiOjJ9.XWi0QzbeCAJBZVOOrvgbzRAwIln4kpPuOILK1QnwIX0	2022-09-30 06:33:52.925372+00	2022-10-14 06:33:52+00	2	49ecf808b6a74b3f9e458f6b122df6c8
73	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyOTI2NiwiaWF0IjoxNjY0NTE5NjY2LCJqdGkiOiI0Y2EwMGE1YWMzNDM0ZDY4ODc0NWM1OTUyNjQ3YmVjZSIsInVzZXJfaWQiOjJ9.2LBZvKgT_gSBvgDSRzUfOqGoyuOc4Nrk5EQ7bY-f-SY	2022-09-30 06:34:26.31644+00	2022-10-14 06:34:26+00	2	4ca00a5ac3434d688745c5952647bece
74	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTcyOTk2NiwiaWF0IjoxNjY0NTIwMzY2LCJqdGkiOiJkZTRlYjIzMTcwNGE0YWZhYjQ0YWExMDUzZjRlZmMyZSIsInVzZXJfaWQiOjJ9.YyfROn9kO_fuhwru7SUza-Tq0PZGpVybQP60xI_OCEM	2022-09-30 06:46:06.971663+00	2022-10-14 06:46:06+00	2	de4eb231704a4afab44aa1053f4efc2e
75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTczMDIwNSwiaWF0IjoxNjY0NTIwNjA1LCJqdGkiOiJkOWFlOTA5Y2Y4NWU0NThjYjgxMmViZDM5NmZlMGQwZiIsInVzZXJfaWQiOjJ9.QkZRzAVWn9PDna4TllVgoJGkBDkUkN5gKKNvSRPtq90	2022-09-30 06:50:05.665411+00	2022-10-14 06:50:05+00	2	d9ae909cf85e458cb812ebd396fe0d0f
76	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTczMDI1NiwiaWF0IjoxNjY0NTIwNjU2LCJqdGkiOiJlYTYyYTE4MWMzMzU0NmJlYTRhZTFkYzQ2OWVlNTAyNyIsInVzZXJfaWQiOjJ9.h2RA3M0yfpmuf3tuvo32JdTuxL8PhVhhRtDYlzMnhks	2022-09-30 06:50:56.212323+00	2022-10-14 06:50:56+00	2	ea62a181c33546bea4ae1dc469ee5027
77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTczMDMxMiwiaWF0IjoxNjY0NTIwNzEyLCJqdGkiOiI2M2FkYjE2MWJkMzg0MTI3OWM4YzA3MGY1MTNhZmY1NCIsInVzZXJfaWQiOjJ9.yfIo9nhcMM6yzOrV-1hE7umoiN8dGuWCbYMr3YaZG6Q	2022-09-30 06:51:52.308341+00	2022-10-14 06:51:52+00	2	63adb161bd3841279c8c070f513aff54
78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTczNTU1MSwiaWF0IjoxNjY0NTI1OTUxLCJqdGkiOiIzZDQyZDAyODljZWM0NmU0OWQ2ZGY2MWQxOWQ2OTFkNyIsInVzZXJfaWQiOjJ9.3Nf8q1BwsRTABfFNUrZmBT_5_noIZzsZ1ieOYWUwm7Q	2022-09-30 08:19:11.223335+00	2022-10-14 08:19:11+00	2	3d42d0289cec46e49d6df61d19d691d7
79	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTgwNzQzMCwiaWF0IjoxNjY0NTk3ODMwLCJqdGkiOiJiYmNiYzYwODc2MTc0ZjY4YTU0YzA0ZTI1ZDI0YTg4YyIsInVzZXJfaWQiOjV9.1XBv_lFJM7xfFmFD4__wNGC3TwlNiRGIf0afjcXgooI	2022-10-01 04:17:10.50843+00	2022-10-15 04:17:10+00	5	bbcbc60876174f68a54c04e25d24a88c
80	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTgwNzY4MCwiaWF0IjoxNjY0NTk4MDgwLCJqdGkiOiIwZWU3ODdiYmIyYzA0NTUxYTA5MzlmZmI5YTM5YjEzMCIsInVzZXJfaWQiOjV9.CTQGDs3qZPdA6U2_fA0rIaaU_qKhFtOAPqsjRJlhlDo	2022-10-01 04:21:20.40306+00	2022-10-15 04:21:20+00	5	0ee787bbb2c04551a0939ffb9a39b130
81	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTgxMDE2OSwiaWF0IjoxNjY0NjAwNTY5LCJqdGkiOiJjMmEzYzYyZDZjMjY0ZTYxYTc1NDZkNzhhMDNjMzg5MiIsInVzZXJfaWQiOjJ9.cx4vXHB5p2wBGO-qBUNVGv56hjbf8BpDvq1IpSjJ8WA	2022-10-01 05:02:49.093833+00	2022-10-15 05:02:49+00	2	c2a3c62d6c264e61a7546d78a03c3892
82	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTgxMjM1MSwiaWF0IjoxNjY0NjAyNzUxLCJqdGkiOiIzMDBmNjMxODI5NzU0MzZiOTIwMjIzMzVmMTIwNjM2MCIsInVzZXJfaWQiOjJ9.Kluo_Lu1cTmKDunhe3Jb5zNAYZgOhoWN7CnHGAQ5UMU	2022-10-01 05:39:11.048365+00	2022-10-15 05:39:11+00	2	300f63182975436b92022335f1206360
83	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTgyMTMzMCwiaWF0IjoxNjY0NjExNzMwLCJqdGkiOiJjMTJmYjhhNjM3ZjY0Mjk4OGVmM2E1MmIyODU4OTc3MCIsInVzZXJfaWQiOjJ9.UfOzUdJkxfGtsQNx6BWxPy8qVw3jriAk3YQyNKI9H98	2022-10-01 08:08:50.146871+00	2022-10-15 08:08:50+00	2	c12fb8a637f642988ef3a52b28589770
84	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTgyMzA1MCwiaWF0IjoxNjY0NjEzNDUwLCJqdGkiOiIyMmMxMDA0NDFiY2M0YTQ1ODc4OWNlMTcxNzI5NjE1NSIsInVzZXJfaWQiOjJ9.G-QMhZECWlO9M7m_ZllC6oazOhiOpRlP8OCFggrVPQI	2022-10-01 08:37:30.709761+00	2022-10-15 08:37:30+00	2	22c100441bcc4a458789ce1717296155
85	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTgyODk3OCwiaWF0IjoxNjY0NjE5Mzc4LCJqdGkiOiI1YWE0MGNmZDQxYTE0YmUxODFhYzllNjQ4MjNiMmY0NiIsInVzZXJfaWQiOjV9.eD6djSg9cHj54fCApsi5o5D3qM_hh8dj_IQB4F34fHo	2022-10-01 10:16:18.523969+00	2022-10-15 10:16:18+00	5	5aa40cfd41a14be181ac9e64823b2f46
86	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTg0MDI3MSwiaWF0IjoxNjY0NjMwNjcxLCJqdGkiOiJiMjY2NzI5NWZlMzE0ZTE4YTA2M2ZjNmViYTYxMTFkZSIsInVzZXJfaWQiOjV9.bskK1lSUbRe4fDRh8EL5rA_UoK0mpiA8evxMXjaT3PE	2022-10-01 13:24:31.037003+00	2022-10-15 13:24:31+00	5	b2667295fe314e18a063fc6eba6111de
87	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY2NTg0MTQxNCwiaWF0IjoxNjY0NjMxODE0LCJqdGkiOiJkOGFiZjFiZDY1MzM0NDUyOTYwM2E0YzEzMWQ0OTM4YyIsInVzZXJfaWQiOjJ9.ZjbnoiRi3anMDdsgkpJfuEpq001vi9aUikHU2tZLGZc	2022-10-01 13:43:34.379419+00	2022-10-15 13:43:34+00	2	d8abf1bd653344529603a4c131d4938c
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 11, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 44, true);


--
-- Name: cctvs_cctv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cctvs_cctv_id_seq', 27, true);


--
-- Name: cctvs_upload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cctvs_upload_id_seq', 41, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 11, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 32, true);


--
-- Name: missingchilds_child_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.missingchilds_child_id_seq', 19, true);


--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_blacklist_blacklistedtoken_id_seq', 1, false);


--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_blacklist_outstandingtoken_id_seq', 87, true);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: cctvs_cctv cctvs_cctv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cctvs_cctv
    ADD CONSTRAINT cctvs_cctv_pkey PRIMARY KEY (id);


--
-- Name: cctvs_upload cctvs_upload_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cctvs_upload
    ADD CONSTRAINT cctvs_upload_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: missingchilds_child missingchilds_child_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missingchilds_child
    ADD CONSTRAINT missingchilds_child_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_key UNIQUE (token_id);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq UNIQUE (jti);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: cctvs_cctv_user_id_9d292465; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cctvs_cctv_user_id_9d292465 ON public.cctvs_cctv USING btree (user_id);


--
-- Name: cctvs_upload_user_id_76f8c227; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cctvs_upload_user_id_76f8c227 ON public.cctvs_upload USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: missingchilds_child_user_id_d5ee2881; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX missingchilds_child_user_id_d5ee2881 ON public.missingchilds_child USING btree (user_id);


--
-- Name: token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like ON public.token_blacklist_outstandingtoken USING btree (jti varchar_pattern_ops);


--
-- Name: token_blacklist_outstandingtoken_user_id_83bc629a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_blacklist_outstandingtoken_user_id_83bc629a ON public.token_blacklist_outstandingtoken USING btree (user_id);


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cctvs_cctv cctvs_cctv_user_id_9d292465_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cctvs_cctv
    ADD CONSTRAINT cctvs_cctv_user_id_9d292465_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cctvs_upload cctvs_upload_user_id_76f8c227_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cctvs_upload
    ADD CONSTRAINT cctvs_upload_user_id_76f8c227_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: missingchilds_child missingchilds_child_user_id_d5ee2881_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missingchilds_child
    ADD CONSTRAINT missingchilds_child_user_id_d5ee2881_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk FOREIGN KEY (token_id) REFERENCES public.token_blacklist_outstandingtoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outs_user_id_83bc629a_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outs_user_id_83bc629a_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

