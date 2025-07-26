--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: car_gear_enum; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.car_gear_enum AS ENUM (
    'Automatic',
    'Manual'
);


ALTER TYPE public.car_gear_enum OWNER TO admin;

--
-- Name: car_image_type_enum; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.car_image_type_enum AS ENUM (
    'main',
    'secondary'
);


ALTER TYPE public.car_image_type_enum OWNER TO admin;

--
-- Name: car_offertype_enum; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.car_offertype_enum AS ENUM (
    'new',
    'used'
);


ALTER TYPE public.car_offertype_enum OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: brand; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.brand (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.brand OWNER TO admin;

--
-- Name: brand_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brand_id_seq OWNER TO admin;

--
-- Name: brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.brand_id_seq OWNED BY public.brand.id;


--
-- Name: car; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.car (
    id integer NOT NULL,
    mileage integer NOT NULL,
    model character varying NOT NULL,
    price integer NOT NULL,
    "horsePower" integer NOT NULL,
    year integer NOT NULL,
    "engineSize" double precision NOT NULL,
    doors integer NOT NULL,
    seats integer NOT NULL,
    "previousOwner" integer,
    color character varying NOT NULL,
    "averageReviewScore" double precision DEFAULT '0'::double precision NOT NULL,
    "brandId" integer,
    "fuelTypeId" integer,
    "categoryId" integer,
    "subCategoryId" integer,
    gear public.car_gear_enum DEFAULT 'Manual'::public.car_gear_enum NOT NULL,
    "offerType" public.car_offertype_enum DEFAULT 'new'::public.car_offertype_enum NOT NULL
);


ALTER TABLE public.car OWNER TO admin;

--
-- Name: car_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.car_id_seq OWNER TO admin;

--
-- Name: car_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.car_id_seq OWNED BY public.car.id;


--
-- Name: car_image; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.car_image (
    id integer NOT NULL,
    url character varying NOT NULL,
    "carId" integer,
    type public.car_image_type_enum DEFAULT 'secondary'::public.car_image_type_enum NOT NULL
);


ALTER TABLE public.car_image OWNER TO admin;

--
-- Name: car_image_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.car_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.car_image_id_seq OWNER TO admin;

--
-- Name: car_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.car_image_id_seq OWNED BY public.car_image.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.category OWNER TO admin;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_id_seq OWNER TO admin;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: fuel_type; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fuel_type (
    id integer NOT NULL,
    type character varying NOT NULL
);


ALTER TABLE public.fuel_type OWNER TO admin;

--
-- Name: fuel_type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.fuel_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fuel_type_id_seq OWNER TO admin;

--
-- Name: fuel_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.fuel_type_id_seq OWNED BY public.fuel_type.id;


--
-- Name: recommendation; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.recommendation (
    id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    "carId" integer
);


ALTER TABLE public.recommendation OWNER TO admin;

--
-- Name: recommendation_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.recommendation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommendation_id_seq OWNER TO admin;

--
-- Name: recommendation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.recommendation_id_seq OWNED BY public.recommendation.id;


--
-- Name: recommended_car; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.recommended_car (
    id integer NOT NULL,
    "recommendationId" integer,
    "carId" integer
);


ALTER TABLE public.recommended_car OWNER TO admin;

--
-- Name: recommended_car_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.recommended_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommended_car_id_seq OWNER TO admin;

--
-- Name: recommended_car_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.recommended_car_id_seq OWNED BY public.recommended_car.id;


--
-- Name: review; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.review (
    id integer NOT NULL,
    email character varying NOT NULL,
    score integer NOT NULL,
    comment character varying NOT NULL,
    "carId" integer
);


ALTER TABLE public.review OWNER TO admin;

--
-- Name: review_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_id_seq OWNER TO admin;

--
-- Name: review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.review_id_seq OWNED BY public.review.id;


--
-- Name: sub_category; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sub_category (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.sub_category OWNER TO admin;

--
-- Name: sub_category_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.sub_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sub_category_id_seq OWNER TO admin;

--
-- Name: sub_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.sub_category_id_seq OWNED BY public.sub_category.id;


--
-- Name: brand id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brand ALTER COLUMN id SET DEFAULT nextval('public.brand_id_seq'::regclass);


--
-- Name: car id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.car ALTER COLUMN id SET DEFAULT nextval('public.car_id_seq'::regclass);


--
-- Name: car_image id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.car_image ALTER COLUMN id SET DEFAULT nextval('public.car_image_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: fuel_type id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fuel_type ALTER COLUMN id SET DEFAULT nextval('public.fuel_type_id_seq'::regclass);


--
-- Name: recommendation id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.recommendation ALTER COLUMN id SET DEFAULT nextval('public.recommendation_id_seq'::regclass);


--
-- Name: recommended_car id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.recommended_car ALTER COLUMN id SET DEFAULT nextval('public.recommended_car_id_seq'::regclass);


--
-- Name: review id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.review ALTER COLUMN id SET DEFAULT nextval('public.review_id_seq'::regclass);


--
-- Name: sub_category id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sub_category ALTER COLUMN id SET DEFAULT nextval('public.sub_category_id_seq'::regclass);


--
-- Data for Name: brand; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.brand (id, name) FROM stdin;
1	Ford
2	Chevrolet
3	Honda
4	Kia
5	BMW
6	Mercedes-Benz
7	Audi
8	Hyundai
9	Toyota
10	Nissan
\.


--
-- Data for Name: car; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.car (id, mileage, model, price, "horsePower", year, "engineSize", doors, seats, "previousOwner", color, "averageReviewScore", "brandId", "fuelTypeId", "categoryId", "subCategoryId", gear, "offerType") FROM stdin;
2	159472	Malibu	64322	151	2012	3.8	4	5	2	Blue	0	2	2	2	2	Manual	new
3	95165	Focus	62432	344	2008	1.5	4	2	2	Silver	0	1	2	3	3	Manual	new
4	0	Accord	79039	189	2024	4.5	4	5	0	White	0	3	3	3	4	Manual	new
5	0	CR-V	49719	195	2025	1.7	4	5	0	Gray	0	3	1	1	4	Manual	new
6	0	Civic	32403	178	2024	4.7	4	4	0	Gray	0	3	2	4	5	Manual	new
7	152159	Optima	73358	274	2009	2.4	2	7	1	Red	0	4	2	5	1	Manual	new
8	105039	5 Series	78120	75	2007	3.7	2	5	2	Green	0	5	4	3	1	Manual	new
9	0	EQC	78172	161	2025	3	2	5	0	Green	0	6	1	1	3	Manual	new
10	144029	A6	46759	127	2010	4.7	4	4	3	Red	0	7	1	2	3	Manual	new
11	37967	Focus	76545	154	2007	2.1	4	4	3	Silver	0	1	3	2	2	Manual	new
12	36720	Tucson	19161	80	2021	3.4	2	4	2	Red	0	8	3	5	1	Manual	new
13	0	A4	33101	318	2025	1.9	2	7	0	Blue	0	7	1	4	5	Manual	new
14	0	A4	41721	97	2025	3.7	2	2	0	White	0	7	2	3	1	Manual	new
15	0	A6	26926	306	2025	2	2	7	0	Green	0	7	3	1	1	Manual	new
16	0	Corolla	46566	179	2024	4.5	2	4	0	White	0	9	3	5	5	Manual	new
17	196497	EQC	27343	181	2018	4.9	2	5	3	Red	0	6	4	5	3	Manual	new
18	0	Optima	53677	190	2024	2.6	2	2	0	Silver	0	4	3	5	5	Manual	new
19	192745	Rogue	32264	137	2011	3.7	4	7	3	Black	0	10	2	5	1	Manual	new
20	0	Rio	75661	105	2024	4.5	4	5	0	Blue	0	4	2	4	3	Manual	new
21	74328	C-Class	63257	149	2008	2.1	2	5	1	Blue	0	6	1	3	3	Manual	new
22	0	Sportage	17865	240	2024	4.1	4	4	0	Gray	0	4	4	4	3	Manual	new
23	0	Elantra	69248	368	2024	3.2	4	4	0	Red	0	8	3	3	2	Manual	new
24	0	RAV4	65707	278	2024	4.9	2	4	0	Green	0	9	1	2	4	Manual	new
25	0	Elantra	32342	125	2025	2.5	2	7	0	Blue	0	8	4	2	5	Manual	new
26	0	CR-V	40900	212	2024	4.5	4	5	0	Gray	0	3	1	1	5	Manual	new
27	0	Equinox	52738	205	2024	1.2	4	5	0	Gray	0	2	2	3	5	Manual	new
28	71773	Sentra	15109	345	2023	3.7	2	5	1	White	0	10	1	5	2	Manual	new
29	0	Rogue	36201	221	2025	3.2	2	7	0	Gray	0	10	2	4	4	Manual	new
30	84658	Rogue	42942	366	2022	3.4	4	7	1	White	0	10	2	4	4	Manual	new
31	0	Bolt	21070	190	2024	3.7	2	4	0	Blue	0	2	2	5	1	Manual	new
32	0	e-tron	61692	266	2025	3	2	4	0	Gray	0	7	4	5	1	Manual	new
33	0	Sonata	74635	132	2025	2.8	4	5	0	Green	0	8	1	4	3	Manual	new
34	129433	Bolt	63865	396	2010	2.1	4	4	3	Black	0	2	4	4	1	Manual	new
35	146597	E-Class	24803	266	2015	3.8	2	2	2	White	0	6	1	4	2	Manual	new
36	115138	Bolt	70687	364	2006	2.5	2	5	1	Black	0	2	4	4	5	Manual	new
37	119251	Malibu	40275	277	2012	3.9	4	4	2	Silver	0	2	4	1	1	Manual	new
38	0	Elantra	26812	203	2025	2.5	2	7	0	Black	0	8	3	3	5	Manual	new
39	10081	EQC	29574	105	2007	4.1	2	2	2	Blue	0	6	1	2	1	Manual	new
40	0	Altima	51658	181	2024	2.9	4	5	0	Blue	0	10	4	1	3	Manual	new
41	11731	Mustang	40782	171	2008	1.3	2	2	3	Gray	0	1	2	3	3	Manual	new
42	178413	Focus	47887	244	2022	1.1	4	7	2	Red	0	1	2	4	2	Manual	new
43	141772	Optima	45216	373	2010	2.1	2	2	3	Black	0	4	2	4	4	Manual	new
44	90200	Niro	28787	202	2005	2.4	4	2	2	Silver	0	4	3	2	1	Manual	new
45	186039	e-tron	44131	78	2022	1.4	2	7	1	Gray	0	7	4	2	2	Manual	new
46	95113	Rogue	37867	302	2022	2.1	4	4	3	Red	0	10	4	2	2	Manual	new
47	0	Mustang	62098	338	2024	3.4	2	4	0	Black	0	1	4	2	2	Manual	new
48	0	X3	78329	353	2024	2.2	2	7	0	Red	0	5	2	5	3	Manual	new
49	53329	EQC	76169	314	2019	1.5	2	7	2	White	0	6	1	5	3	Manual	new
50	0	Camry	22699	283	2025	3.4	2	7	0	White	0	9	1	4	2	Manual	new
51	20789	Leaf	55658	205	2023	3.6	2	4	3	Blue	0	10	1	1	1	Manual	new
52	160664	3 Series	17121	217	2019	3.8	4	2	3	Gray	0	5	4	2	2	Manual	new
53	63932	Altima	68731	106	2008	1.2	4	5	3	White	0	10	3	5	5	Manual	new
54	134445	EQC	53872	291	2021	3.9	4	2	3	Red	0	6	4	2	3	Manual	new
55	50925	Sentra	74544	162	2023	5	4	7	1	Red	0	10	4	4	2	Manual	new
56	91456	Tucson	33734	275	2008	4.3	2	7	1	Red	0	8	4	3	2	Manual	new
57	177401	Civic	18523	335	2021	2.4	4	7	1	Green	0	3	4	5	4	Manual	new
58	132064	E-Class	78254	381	2019	4.2	2	5	3	Silver	0	6	1	5	3	Manual	new
59	0	Elantra	57101	148	2024	3	4	5	0	White	0	8	4	4	5	Manual	new
60	0	e-tron	71161	211	2025	4.1	4	5	0	Green	0	7	3	1	2	Manual	new
61	177999	RAV4	44025	317	2023	2.4	4	7	3	Black	0	9	4	2	4	Manual	new
62	0	Leaf	63405	265	2025	2.5	2	7	0	Red	0	10	1	2	3	Manual	new
63	0	Rogue	15997	143	2025	2.6	2	2	0	White	0	10	1	3	2	Manual	new
64	0	Leaf	55741	319	2025	4.5	2	2	0	Blue	0	10	4	3	4	Manual	new
65	0	F-150	60110	84	2024	1.2	2	5	0	Black	0	1	4	3	5	Manual	new
66	52200	5 Series	20132	265	2023	3.5	2	7	3	Silver	0	5	3	2	4	Manual	new
67	7463	Sportage	59044	150	2013	1.3	4	5	3	Gray	0	4	4	4	2	Manual	new
68	0	Sportage	30418	362	2025	2.4	4	5	0	Red	0	4	4	4	2	Manual	new
69	164138	Corolla	56380	387	2014	2	2	2	1	Gray	0	9	2	5	2	Manual	new
70	82361	Rio	26416	137	2009	4.1	4	5	1	Green	0	4	2	2	2	Manual	new
71	24739	Sportage	70909	273	2008	4.9	4	2	2	Green	0	4	3	4	1	Manual	new
72	181250	C-Class	68457	260	2016	1.4	2	7	3	Red	0	6	2	1	3	Manual	new
73	0	Accord	22583	93	2025	4.8	4	7	0	Red	0	3	2	5	4	Manual	new
74	180763	Malibu	72551	120	2019	4.3	4	5	2	Red	0	2	4	3	4	Manual	new
75	0	Niro	50390	400	2025	2.4	4	5	0	Blue	0	4	1	5	5	Manual	new
76	0	Mustang	79273	359	2024	1.8	2	4	0	Green	0	1	2	2	2	Manual	new
77	146614	3 Series	22145	83	2009	1.5	4	4	1	Silver	0	5	2	3	1	Manual	new
78	0	X3	63468	313	2024	2.8	4	2	0	White	0	5	4	1	4	Manual	new
79	13165	Sentra	70074	288	2019	3.7	4	7	3	Red	0	10	1	5	2	Manual	new
80	0	Altima	39758	375	2024	3.1	4	7	0	Red	0	10	2	5	3	Manual	new
81	93848	e-tron	42039	118	2012	2.3	4	5	2	Black	0	7	4	2	5	Manual	new
82	0	Focus	63398	260	2024	4.2	2	5	0	Gray	0	1	4	5	5	Manual	new
83	0	Insight	21734	329	2025	1.9	4	4	0	Green	0	3	2	5	2	Manual	new
84	0	Equinox	69935	388	2025	3.5	2	5	0	Red	0	2	3	2	2	Manual	new
85	42552	GLC	24221	394	2005	4.9	2	4	1	White	0	6	4	4	5	Manual	new
86	90035	Accord	25112	386	2014	1.2	2	5	3	White	0	3	1	4	5	Manual	new
87	139308	Leaf	42944	215	2013	3.7	4	5	1	Red	0	10	1	2	5	Manual	new
88	0	Sentra	64877	200	2024	2.2	2	2	0	White	0	10	2	4	4	Manual	new
89	0	i3	71014	91	2025	2.7	4	2	0	Green	0	5	1	3	3	Manual	new
90	111176	Ioniq	26171	386	2014	2.8	4	2	1	White	0	8	1	5	4	Manual	new
91	0	Ioniq	29402	156	2025	1.3	2	4	0	Green	0	8	2	3	2	Manual	new
92	0	5 Series	26277	148	2024	4	2	4	0	Green	0	5	2	4	5	Manual	new
93	120281	Leaf	43743	225	2015	4.2	2	5	1	Silver	0	10	1	5	2	Manual	new
94	0	Niro	19987	116	2024	3.5	4	7	0	Silver	0	4	2	1	1	Manual	new
95	44547	Optima	21727	245	2020	4.9	2	4	3	Red	0	4	1	2	5	Manual	new
96	106558	Optima	59128	96	2016	4.2	4	2	2	Black	0	4	4	5	3	Manual	new
97	26365	Tucson	35165	270	2009	1.5	2	5	2	Silver	0	8	3	4	2	Manual	new
98	9779	3 Series	26717	179	2021	2.4	4	4	2	Blue	0	5	2	2	4	Manual	new
99	0	Explorer	53821	148	2024	1.6	2	7	0	Red	0	1	2	4	2	Manual	new
100	144987	e-tron	77763	310	2019	4.6	2	5	1	Gray	0	7	3	1	5	Manual	new
101	114749	Sportage	67081	140	2021	4.5	2	7	3	Green	0	4	3	3	3	Manual	new
102	76510	Focus	69018	116	2007	4.8	2	7	1	Black	0	1	4	5	5	Manual	new
103	26392	Prius	16832	120	2012	4.4	4	4	2	Blue	0	9	2	5	2	Manual	new
104	6376	Optima	31635	146	2019	3.2	4	2	3	Green	0	4	1	3	4	Manual	new
105	0	C-Class	19082	325	2024	3.4	2	4	0	Gray	0	6	4	2	2	Manual	new
106	114200	Elantra	49026	254	2012	1.3	2	7	3	Green	0	8	3	4	1	Manual	new
107	22710	Tucson	62641	391	2005	1.4	4	4	2	Red	0	8	2	3	3	Manual	new
108	52783	Accord	61542	304	2020	1.1	2	2	3	Green	0	3	3	2	1	Manual	new
109	71404	CR-V	33597	94	2022	4.5	4	5	2	Red	0	3	1	3	5	Manual	new
110	135076	Ioniq	75080	335	2015	2.1	2	7	1	Red	0	8	4	4	3	Manual	new
111	90962	X3	43984	288	2008	1.7	4	5	1	White	0	5	2	5	2	Manual	new
112	180946	Leaf	48350	151	2006	4.8	2	7	1	Red	0	10	4	2	1	Manual	new
113	13489	Q5	76673	260	2017	2.8	2	4	3	Silver	0	7	3	3	5	Manual	new
114	0	CR-V	47437	268	2024	4.7	2	5	0	Green	0	3	1	3	5	Manual	new
115	40580	Q5	26222	297	2011	5	4	5	1	Gray	0	7	1	5	3	Manual	new
116	191007	Equinox	48069	132	2010	4.9	2	4	3	Green	0	2	3	4	1	Manual	new
117	165418	CR-V	35103	315	2022	3.1	4	2	1	Blue	0	3	1	3	1	Manual	new
118	172718	Niro	43120	98	2009	4.3	2	5	3	Blue	0	4	3	2	2	Manual	new
119	56459	Q5	55626	384	2007	3.1	2	4	2	Blue	0	7	2	1	3	Manual	new
120	0	Civic	57323	362	2024	2.7	2	7	0	Gray	0	3	1	1	2	Manual	new
121	0	EQC	19743	100	2025	1.6	4	7	0	White	0	6	2	2	2	Manual	new
122	95536	Altima	64443	333	2015	3.2	4	4	3	White	0	10	4	5	2	Manual	new
123	0	Optima	76450	385	2024	2.7	2	5	0	Silver	0	4	1	3	4	Manual	new
124	135382	i3	76440	328	2020	2.8	2	4	2	Silver	0	5	1	3	1	Manual	new
125	145690	RAV4	43010	205	2020	3.9	4	5	2	Red	0	9	1	4	1	Manual	new
126	24275	Altima	64686	213	2022	4.3	2	4	2	Red	0	10	4	4	2	Manual	new
127	0	CR-V	17944	140	2024	3.9	4	7	0	Blue	0	3	4	1	3	Manual	new
128	166611	X3	47975	330	2010	3.1	4	7	2	Green	0	5	2	5	2	Manual	new
129	195139	Civic	32259	366	2023	3.3	2	7	2	Blue	0	3	1	1	3	Manual	new
130	0	Sonata	16230	230	2024	2.7	4	4	0	White	0	8	1	1	3	Manual	new
131	0	Rio	49156	230	2024	4.8	4	5	0	Silver	0	4	2	3	2	Manual	new
132	0	Leaf	29616	222	2024	4.1	2	7	0	Black	0	10	2	4	2	Manual	new
133	182372	Equinox	68194	144	2008	2.2	4	2	3	Black	0	2	4	4	2	Manual	new
134	0	Optima	22099	370	2025	2	2	4	0	Gray	0	4	2	2	1	Manual	new
135	183570	F-150	77693	150	2020	2.6	4	7	1	Gray	0	1	3	2	2	Manual	new
136	0	CR-V	74359	159	2024	2.7	2	2	0	Green	0	3	3	4	5	Manual	new
137	0	X3	75349	241	2024	2.1	4	4	0	Green	0	5	2	1	5	Manual	new
138	0	E-Class	57138	165	2025	1.1	4	5	0	Silver	0	6	3	2	4	Manual	new
139	27737	Leaf	27010	141	2021	2.9	2	2	2	Black	0	10	4	4	4	Manual	new
140	194499	Sportage	57489	190	2014	1.2	2	7	3	Black	0	4	1	2	5	Manual	new
141	0	Equinox	29243	138	2025	2.9	4	5	0	White	0	2	2	1	5	Manual	new
142	0	Malibu	20076	358	2024	1.4	2	4	0	Blue	0	2	4	3	3	Manual	new
143	0	Rio	67564	302	2025	1.5	4	7	0	Silver	0	4	1	5	3	Manual	new
144	0	Sportage	63477	366	2025	1.3	4	5	0	Gray	0	4	2	5	3	Manual	new
145	112182	Corolla	64778	400	2006	4.9	4	7	2	White	0	9	3	4	5	Manual	new
146	145839	Mustang	62310	184	2008	4.3	2	5	1	White	0	1	4	1	5	Manual	new
147	0	Bolt	25082	166	2024	4.7	2	2	0	Green	0	2	4	4	3	Manual	new
148	0	Camry	44018	94	2024	2	2	7	0	White	0	9	1	2	3	Manual	new
149	0	A4	52535	234	2025	1.9	2	4	0	White	0	7	3	3	2	Manual	new
150	17290	Camry	66077	233	2022	3.8	4	4	2	Black	0	9	2	4	4	Manual	new
151	0	Bolt	67375	99	2024	3.2	4	4	0	White	0	2	2	2	2	Manual	new
152	0	Q5	49816	167	2025	1.2	4	2	0	Green	0	7	2	5	4	Manual	new
153	84478	Altima	75915	130	2011	4	4	4	2	Gray	0	10	1	1	4	Manual	new
154	127224	Sonata	32001	332	2014	4.5	4	2	2	Green	0	8	2	4	2	Manual	new
155	152462	Q5	16054	353	2018	4.7	4	5	1	Blue	0	7	3	2	2	Manual	new
156	0	e-tron	64618	320	2025	4.9	4	7	0	Blue	0	7	2	3	4	Manual	new
157	0	i3	76437	94	2024	4.1	4	4	0	Green	0	5	1	2	1	Manual	new
158	0	3 Series	55159	385	2025	4.7	4	2	0	Red	0	5	2	1	3	Manual	new
159	0	Elantra	47644	290	2025	4.2	2	2	0	Red	0	8	2	1	4	Manual	new
160	109044	A6	77354	305	2016	3.3	2	5	2	Gray	0	7	1	5	1	Manual	new
161	129781	F-150	60684	112	2017	3	4	5	3	Silver	0	1	1	5	3	Manual	new
162	0	Camry	75070	213	2025	4.6	2	4	0	Green	0	9	2	3	1	Manual	new
163	47585	A6	59007	346	2007	2.3	2	2	2	Silver	0	7	3	3	1	Manual	new
164	0	F-150	77979	237	2024	1.1	4	7	0	White	0	1	2	2	2	Manual	new
165	158583	Bolt	65190	221	2010	4.2	2	2	3	Black	0	2	4	2	5	Manual	new
166	28991	i3	43907	208	2016	1.4	2	4	1	White	0	5	1	4	3	Manual	new
167	0	Bolt	51024	375	2024	3.4	4	7	0	Red	0	2	1	3	5	Manual	new
168	0	Elantra	24024	224	2024	2.1	2	2	0	Blue	0	8	4	4	2	Manual	new
169	70981	Tucson	53597	170	2007	2.8	2	5	2	Red	0	8	3	4	2	Manual	new
170	117883	Leaf	35843	172	2019	2.9	2	7	2	Black	0	10	3	3	5	Manual	new
171	108005	Altima	75584	172	2017	3.4	2	2	2	Gray	0	10	2	4	4	Manual	new
172	0	Sportage	56166	193	2025	2	2	7	0	Green	0	4	4	4	1	Manual	new
173	186327	Niro	66396	254	2022	3.8	2	2	3	Green	0	4	4	2	2	Manual	new
174	32772	3 Series	31817	331	2015	4	2	7	2	Black	0	5	1	4	5	Manual	new
175	32406	Altima	74835	113	2005	1.5	2	5	2	Black	0	10	2	3	5	Manual	new
176	119862	e-tron	19366	92	2020	4.2	2	2	1	Green	0	7	4	3	1	Manual	new
177	0	5 Series	77300	188	2024	4.2	2	4	0	Gray	0	5	2	4	5	Manual	new
178	106930	Camry	28375	102	2023	3.3	2	5	2	Black	0	9	1	2	5	Manual	new
179	87157	Explorer	53155	248	2021	2.4	4	4	3	Green	0	1	4	3	3	Manual	new
180	0	Sentra	34849	163	2025	2.5	2	7	0	White	0	10	1	1	4	Manual	new
181	171592	Leaf	46826	141	2010	1.7	4	2	2	Green	0	10	3	3	1	Manual	new
182	0	Optima	59505	282	2025	3.8	4	7	0	Blue	0	4	4	5	3	Manual	new
183	63941	Camry	65748	359	2006	4	4	2	2	Silver	0	9	2	5	2	Manual	new
184	0	Equinox	21657	196	2025	2.2	2	7	0	Black	0	2	3	3	1	Manual	new
185	0	Rio	25788	141	2024	4.1	2	2	0	Silver	0	4	2	3	3	Manual	new
186	155139	E-Class	23813	280	2014	4.7	4	4	2	Gray	0	6	2	2	4	Manual	new
187	0	X3	52532	207	2025	3.5	4	7	0	Red	0	5	4	5	5	Manual	new
188	90796	Equinox	62510	304	2019	3.5	4	2	2	Green	0	2	1	1	5	Manual	new
189	0	e-tron	68842	242	2025	3.2	2	7	0	Green	0	7	2	3	1	Manual	new
190	46414	Corolla	15043	289	2005	1.8	2	5	1	Blue	0	9	4	3	1	Manual	new
191	0	CR-V	40762	226	2025	3.9	2	7	0	Gray	0	3	3	5	1	Manual	new
192	160629	Camry	15603	245	2007	4.3	4	4	1	White	0	9	3	5	4	Manual	new
193	0	Elantra	72264	140	2024	2.5	2	4	0	Red	0	8	2	1	3	Manual	new
194	60851	Camry	55044	296	2016	4.4	2	2	3	Blue	0	9	3	5	3	Manual	new
195	69955	Tucson	31130	377	2015	3.4	4	2	1	Green	0	8	2	3	4	Manual	new
196	19304	Malibu	40082	193	2014	3	2	2	3	Black	0	2	3	3	4	Manual	new
197	50290	Ioniq	16084	104	2022	1.1	2	2	3	Red	0	8	4	4	3	Manual	new
198	172913	EQC	20433	110	2017	3	2	4	1	Silver	0	6	3	3	5	Manual	new
199	67557	Sentra	20603	292	2018	1.5	2	5	3	Gray	0	10	1	2	1	Manual	new
200	0	Camry	48995	202	2024	1.7	2	5	0	Gray	0	9	4	5	1	Manual	new
201	73930	Insight	44587	254	2021	1.2	2	5	1	Blue	0	3	1	3	1	Manual	new
202	0	Sentra	30895	311	2024	2.5	2	4	0	Green	0	10	1	5	3	Manual	new
203	193819	Sonata	68689	362	2012	2.5	2	4	2	Blue	0	8	2	1	1	Manual	new
204	90799	Elantra	15518	172	2014	2.2	4	4	2	White	0	8	1	3	3	Manual	new
205	0	Optima	16554	347	2024	2.4	2	5	0	Red	0	4	1	4	2	Manual	new
206	0	Mustang	78216	142	2025	3.8	2	2	0	Blue	0	1	4	1	5	Manual	new
207	0	Insight	19863	360	2024	1.2	2	4	0	Black	0	3	3	3	2	Manual	new
208	66239	Tucson	23847	369	2019	1.4	2	4	2	White	0	8	1	4	2	Manual	new
209	85821	Elantra	70411	116	2011	1.6	4	2	2	Blue	0	8	4	3	4	Manual	new
210	17832	Mustang	68305	159	2017	1.1	4	7	3	Silver	0	1	2	1	4	Manual	new
211	0	F-150	19008	183	2024	1.5	4	5	0	Gray	0	1	1	5	3	Manual	new
212	0	Rogue	73662	297	2024	4.2	2	5	0	Red	0	10	1	5	5	Manual	new
213	12728	Camry	26232	179	2017	4.6	4	5	2	White	0	9	4	2	1	Manual	new
214	149359	Altima	20701	266	2020	1.5	2	4	2	Gray	0	10	4	1	1	Manual	new
215	95186	Tucson	32578	83	2022	2.3	2	2	2	Green	0	8	2	3	1	Manual	new
216	0	Sportage	57696	206	2024	3.1	2	4	0	Silver	0	4	1	4	2	Manual	new
217	0	5 Series	60724	250	2025	4.8	2	4	0	Green	0	5	2	4	3	Manual	new
218	19724	E-Class	16295	314	2006	1	2	4	1	Black	0	6	3	2	2	Manual	new
219	0	Corolla	77436	261	2024	3.8	4	2	0	Black	0	9	1	3	2	Manual	new
220	88173	5 Series	29510	371	2020	4.3	4	5	3	Gray	0	5	3	3	4	Manual	new
221	52731	3 Series	56577	123	2023	4.7	2	5	1	Gray	0	5	2	5	4	Manual	new
222	0	CR-V	15740	177	2024	2	2	5	0	Black	0	3	2	5	1	Manual	new
223	113532	Prius	37830	262	2018	1.4	4	4	1	Blue	0	9	4	4	1	Manual	new
224	0	RAV4	19823	157	2025	4.6	2	2	0	Silver	0	9	2	5	2	Manual	new
225	0	Leaf	25211	121	2025	2.3	2	7	0	Gray	0	10	3	1	3	Manual	new
226	18011	GLC	24983	254	2012	1	2	5	1	Green	0	6	4	1	5	Manual	new
227	0	A4	78508	312	2024	4.4	4	7	0	White	0	7	3	4	2	Manual	new
228	0	F-150	27127	92	2025	2.1	4	5	0	Blue	0	1	4	3	3	Manual	new
229	0	Camry	78095	371	2024	1.9	2	7	0	Green	0	9	2	1	5	Manual	new
230	0	Bolt	40662	87	2025	3	2	2	0	Green	0	2	2	4	4	Manual	new
231	0	5 Series	20093	292	2024	1.8	2	5	0	Black	0	5	1	5	1	Manual	new
232	125103	Ioniq	22313	146	2013	1.6	2	2	3	Silver	0	8	1	5	2	Manual	new
233	176648	Equinox	17435	211	2013	2.6	4	2	2	White	0	2	4	3	4	Manual	new
234	93569	Prius	33222	321	2016	4.4	2	4	1	Blue	0	9	2	3	5	Manual	new
235	120793	CR-V	63161	334	2007	4.5	2	4	1	Red	0	3	3	3	3	Manual	new
236	0	Sonata	69403	197	2024	1.1	2	5	0	Gray	0	8	3	2	2	Manual	new
237	13011	Insight	46771	298	2008	1.7	4	5	3	Black	0	3	3	2	2	Manual	new
238	0	Explorer	70498	179	2025	4.4	2	4	0	Black	0	1	1	4	3	Manual	new
239	50403	Corolla	31405	226	2009	3.9	4	7	3	White	0	9	1	3	5	Manual	new
240	141482	E-Class	15477	261	2014	3.2	4	5	3	Gray	0	6	4	5	5	Manual	new
241	73458	Explorer	24745	193	2015	4.6	4	5	2	Gray	0	1	2	2	1	Manual	new
242	106783	Sportage	37305	183	2018	3.7	4	5	2	Silver	0	4	1	3	4	Manual	new
243	38539	Malibu	76550	241	2008	3.6	2	5	2	Blue	0	2	2	3	5	Manual	new
244	126572	CR-V	18489	394	2023	3.3	2	7	2	Blue	0	3	1	1	1	Manual	new
245	41009	Tucson	41597	361	2006	4.6	4	4	1	Black	0	8	3	2	1	Manual	new
246	0	Sportage	44383	177	2025	4	2	4	0	White	0	4	1	5	4	Manual	new
247	130147	Leaf	17452	172	2017	3.9	2	5	2	Green	0	10	4	1	4	Manual	new
248	0	Corolla	23380	266	2024	3	4	4	0	Red	0	9	2	5	2	Manual	new
249	40072	EQC	38351	166	2018	1.7	4	2	3	Blue	0	6	2	2	4	Manual	new
250	0	A4	39387	397	2024	2	2	2	0	Gray	0	7	2	5	1	Manual	new
251	37399	Corolla	60621	175	2019	3.8	2	5	2	White	0	9	2	5	3	Manual	new
252	193420	E-Class	22410	124	2008	3	2	5	3	Green	0	6	1	1	4	Manual	new
253	148691	Insight	59733	316	2010	2.3	2	2	1	Gray	0	3	4	5	1	Manual	new
254	0	Leaf	73810	399	2024	1.9	4	5	0	White	0	10	1	5	1	Manual	new
255	86974	3 Series	21174	93	2016	1	2	4	3	Black	0	5	4	3	5	Manual	new
256	0	Rogue	22399	274	2025	4.8	4	7	0	Gray	0	10	2	4	5	Manual	new
257	0	3 Series	42041	372	2024	2.9	4	4	0	Silver	0	5	3	4	2	Manual	new
258	0	Sentra	72693	295	2025	1.2	4	5	0	Red	0	10	4	1	3	Manual	new
259	185418	Altima	58011	197	2021	2.9	4	4	3	Green	0	10	1	1	3	Manual	new
260	0	Corolla	19866	321	2025	2.3	4	5	0	Red	0	9	4	1	4	Manual	new
261	125348	Bolt	20721	325	2012	2.8	2	7	1	Gray	0	2	4	5	1	Manual	new
262	0	Ioniq	72857	357	2024	1.8	4	5	0	Black	0	8	1	5	4	Manual	new
263	123628	Sportage	64355	183	2016	1	4	5	3	Silver	0	4	1	1	2	Manual	new
264	0	Focus	21952	382	2025	1.8	2	7	0	Blue	0	1	3	4	4	Manual	new
265	181197	Civic	44730	371	2006	4.8	2	7	3	Red	0	3	1	1	1	Manual	new
266	186355	Bolt	21731	377	2021	3.4	4	7	1	White	0	2	3	1	4	Manual	new
267	39962	EQC	54164	332	2014	2.2	4	4	2	Blue	0	6	3	2	3	Manual	new
268	0	GLC	64450	357	2024	2.9	4	5	0	Green	0	6	2	4	1	Manual	new
269	0	Cruze	58566	172	2025	2.1	2	5	0	Gray	0	2	3	3	4	Manual	new
270	0	RAV4	21661	357	2024	4.5	4	4	0	Silver	0	9	2	3	1	Manual	new
271	19103	Ioniq	28200	296	2015	4.3	4	4	3	Green	0	8	1	2	2	Manual	new
272	0	Optima	39517	289	2024	2.1	4	4	0	Blue	0	4	3	1	2	Manual	new
273	45292	RAV4	65287	390	2009	3.5	4	7	1	Green	0	9	2	1	3	Manual	new
274	53200	Civic	42035	344	2021	2.6	4	4	1	Blue	0	3	1	3	2	Manual	new
275	0	CR-V	58481	298	2025	2	2	2	0	Gray	0	3	1	3	5	Manual	new
276	79141	F-150	48430	330	2022	2.8	2	5	3	Gray	0	1	1	2	2	Manual	new
277	0	Cruze	28700	392	2024	4.1	4	2	0	Blue	0	2	1	1	5	Manual	new
278	0	Mustang	20688	97	2025	1.7	4	2	0	Silver	0	1	2	2	2	Manual	new
279	87943	Ioniq	58764	343	2017	1	2	2	2	Gray	0	8	1	5	2	Manual	new
280	27676	Cruze	39791	85	2014	2.9	2	4	3	Gray	0	2	2	4	3	Manual	new
281	150103	E-Class	17715	363	2016	3.4	2	5	1	Blue	0	6	3	3	4	Manual	new
282	0	Sonata	27631	162	2024	3.7	2	7	0	Gray	0	8	3	1	1	Manual	new
283	195208	C-Class	38213	190	2008	1.4	2	4	1	Black	0	6	4	4	5	Manual	new
284	0	CR-V	25961	230	2025	2	2	7	0	Black	0	3	2	3	4	Manual	new
285	85077	Insight	26425	380	2019	1.3	4	4	2	Silver	0	3	4	2	2	Manual	new
286	0	Focus	73909	352	2024	2	4	4	0	Black	0	1	4	4	4	Manual	new
287	0	Rogue	38651	75	2025	3.7	2	4	0	White	0	10	1	2	4	Manual	new
288	62362	Altima	19085	259	2016	1.9	2	5	1	White	0	10	4	4	5	Manual	new
289	141674	Corolla	52611	361	2008	1.7	4	5	3	Silver	0	9	2	5	3	Manual	new
290	0	EQC	46646	316	2025	4.5	2	4	0	White	0	6	2	2	4	Manual	new
291	0	Explorer	38544	130	2024	3.6	4	5	0	Gray	0	1	3	5	5	Manual	new
292	0	Niro	30838	135	2024	3.3	2	4	0	Gray	0	4	4	1	1	Manual	new
293	0	Altima	48581	277	2024	3.4	2	5	0	Red	0	10	2	2	5	Manual	new
294	112680	Leaf	55508	331	2010	2.1	4	7	1	Silver	0	10	3	1	1	Manual	new
295	9341	e-tron	68723	380	2009	1.4	4	2	1	Green	0	7	3	1	3	Manual	new
296	146370	Focus	48932	259	2009	4.5	4	4	3	Green	0	1	1	4	5	Manual	new
297	130079	Civic	33412	348	2009	2.6	2	2	2	Gray	0	3	3	5	3	Manual	new
298	0	Cruze	41574	124	2025	1.6	4	5	0	Green	0	2	3	1	5	Manual	new
299	113325	Rogue	39063	354	2017	2.9	4	5	1	Green	0	10	4	4	4	Manual	new
300	61218	Mustang	67055	384	2010	3.8	2	4	1	White	0	1	4	5	1	Manual	new
301	73967	i3	20202	89	2007	3.9	4	5	1	Gray	0	5	3	1	1	Manual	new
302	177198	i3	17184	376	2005	3	2	4	1	Gray	0	5	2	5	2	Manual	new
303	0	A4	37953	272	2024	2.6	2	2	0	Gray	0	7	2	5	1	Manual	new
304	64322	Equinox	75431	364	2016	1	2	7	2	Silver	0	2	3	5	3	Manual	new
305	72552	Explorer	77793	358	2008	2.9	2	5	3	Green	0	1	2	4	5	Manual	new
306	22708	Sentra	58999	187	2008	4.2	4	5	2	Silver	0	10	4	1	1	Manual	new
307	181605	E-Class	51045	161	2007	2.9	4	4	2	Silver	0	6	2	3	4	Manual	new
308	0	e-tron	28440	173	2024	4.3	4	4	0	Green	0	7	3	5	1	Manual	new
309	0	F-150	55343	322	2024	4.6	4	7	0	Blue	0	1	4	1	2	Manual	new
310	0	Sonata	76077	86	2024	3	4	4	0	White	0	8	4	5	3	Manual	new
311	0	Sportage	52765	236	2024	2.4	4	4	0	Silver	0	4	3	3	4	Manual	new
312	135749	EQC	42241	260	2016	2.5	4	5	1	White	0	6	4	2	3	Manual	new
313	0	5 Series	70660	170	2025	1.6	2	7	0	Green	0	5	3	5	4	Manual	new
314	0	Ioniq	31313	360	2025	1.2	2	4	0	Red	0	8	4	2	2	Manual	new
315	99624	Rio	37369	280	2015	1.5	2	4	2	Green	0	4	2	3	2	Manual	new
316	165868	Insight	56061	144	2007	4.5	4	7	2	Gray	0	3	2	1	3	Manual	new
317	0	Elantra	35376	219	2024	3.8	4	5	0	White	0	8	2	3	3	Manual	new
318	11055	Bolt	58031	110	2010	1.8	4	2	1	Red	0	2	3	5	5	Manual	new
319	0	Cruze	32059	149	2025	1.3	4	5	0	Blue	0	2	1	2	2	Manual	new
320	0	Optima	58130	236	2024	4.5	4	5	0	Silver	0	4	1	4	4	Manual	new
321	142221	Malibu	46307	186	2023	4.2	4	5	2	Black	0	2	2	4	2	Manual	new
322	0	X3	33639	343	2024	1	4	7	0	Black	0	5	3	5	5	Manual	new
323	0	E-Class	72340	293	2025	2.6	2	7	0	Green	0	6	3	4	4	Manual	new
324	165750	C-Class	57149	342	2012	4.2	4	4	3	Green	0	6	2	5	4	Manual	new
325	0	X3	60530	321	2025	1.8	2	4	0	Red	0	5	4	1	1	Manual	new
326	192484	3 Series	30132	147	2013	1.1	2	5	1	White	0	5	4	3	5	Manual	new
327	0	Insight	18642	270	2025	1.3	4	4	0	Blue	0	3	1	3	5	Manual	new
328	0	Corolla	62945	87	2025	1.8	2	4	0	White	0	9	4	4	2	Manual	new
329	0	Accord	56503	171	2024	2.4	2	4	0	Red	0	3	2	2	5	Manual	new
330	0	Civic	66294	74	2025	4.9	4	4	0	Black	0	3	1	5	4	Manual	new
331	0	i3	38108	148	2025	3.8	2	4	0	White	0	5	1	2	2	Manual	new
332	185682	Equinox	62085	198	2011	4.6	4	7	1	Silver	0	2	4	3	3	Manual	new
333	0	Optima	32896	376	2025	4.7	2	2	0	Silver	0	4	2	2	5	Manual	new
334	172254	GLC	72390	387	2019	4.4	2	5	1	Gray	0	6	4	5	3	Manual	new
335	165704	Sonata	41637	234	2022	1.4	2	2	1	Green	0	8	2	2	4	Manual	new
336	0	Camry	17068	398	2025	4.3	4	5	0	Red	0	9	3	3	4	Manual	new
337	0	Sentra	45423	397	2024	1.2	4	5	0	Green	0	10	4	5	3	Manual	new
338	0	C-Class	77438	119	2025	1.4	2	7	0	Blue	0	6	1	2	3	Manual	new
339	156142	A6	60665	288	2008	4.5	2	4	3	Silver	0	7	2	4	3	Manual	new
340	149200	Accord	41802	394	2016	2.7	4	4	2	Silver	0	3	2	1	4	Manual	new
341	109094	Tucson	78892	375	2019	1.1	2	5	2	Red	0	8	1	3	4	Manual	new
342	0	Q5	17452	252	2025	1.6	4	5	0	Silver	0	7	3	2	4	Manual	new
343	0	GLC	62032	317	2025	1.7	2	5	0	Red	0	6	3	1	5	Manual	new
344	114188	Focus	63599	378	2016	4.7	4	2	2	Black	0	1	1	1	1	Manual	new
345	62880	Accord	58786	271	2021	4.9	2	4	3	White	0	3	3	3	5	Manual	new
346	154799	5 Series	32066	274	2007	3	2	4	2	White	0	5	1	1	4	Manual	new
347	0	Niro	32306	290	2024	2.3	2	2	0	Gray	0	4	3	4	5	Manual	new
348	0	CR-V	65029	156	2025	5	4	4	0	White	0	3	2	5	4	Manual	new
349	0	Q5	30798	387	2024	4.7	4	2	0	Black	0	7	1	5	2	Manual	new
350	0	Niro	28247	337	2025	4	4	4	0	Gray	0	4	3	5	5	Manual	new
351	79452	Sentra	18450	74	2010	1.3	4	5	1	Green	0	10	3	5	1	Manual	new
352	0	EQC	46503	375	2025	3.1	2	4	0	Silver	0	6	1	4	3	Manual	new
353	0	Corolla	40570	150	2025	1.1	4	5	0	Gray	0	9	2	3	4	Manual	new
354	0	Equinox	76368	213	2025	1.9	4	7	0	Gray	0	2	4	2	1	Manual	new
355	45042	Sonata	74132	238	2012	2.8	2	4	3	Gray	0	8	4	2	3	Manual	new
356	0	Malibu	79719	144	2025	3.6	2	5	0	Red	0	2	3	1	3	Manual	new
357	12728	Mustang	77477	225	2009	2.8	4	4	3	Green	0	1	2	2	1	Manual	new
358	0	5 Series	30009	83	2025	2.4	4	4	0	Silver	0	5	3	1	5	Manual	new
359	41048	Accord	29707	279	2020	4.1	2	5	2	White	0	3	3	2	4	Manual	new
360	0	A4	71340	196	2025	2.7	2	7	0	Gray	0	7	4	3	5	Manual	new
361	0	Sentra	72055	195	2025	3.1	4	2	0	Silver	0	10	4	4	3	Manual	new
362	84837	Camry	25821	220	2019	3.5	2	4	2	White	0	9	2	4	1	Manual	new
363	0	Cruze	36024	82	2024	1.7	2	7	0	Red	0	2	4	3	2	Manual	new
364	0	3 Series	20544	266	2024	3.9	2	7	0	Silver	0	5	4	4	1	Manual	new
365	0	X3	64995	96	2024	2.7	4	7	0	Black	0	5	3	2	1	Manual	new
366	0	5 Series	47345	325	2025	3.2	2	7	0	Blue	0	5	1	2	3	Manual	new
367	162605	Niro	72340	212	2019	3.5	2	2	1	Blue	0	4	1	2	1	Manual	new
368	0	Civic	74825	95	2024	1.4	2	4	0	Gray	0	3	2	3	3	Manual	new
369	14395	Altima	35983	264	2023	4.3	4	2	2	Black	0	10	1	4	4	Manual	new
370	142532	Explorer	54783	125	2021	3.3	2	7	2	Gray	0	1	3	1	2	Manual	new
371	168379	Tucson	54928	324	2021	3.1	4	7	3	Green	0	8	2	2	3	Manual	new
372	0	Q5	45217	130	2024	3.9	2	7	0	White	0	7	1	5	2	Manual	new
373	0	Accord	66362	227	2024	2.2	4	2	0	Red	0	3	2	3	2	Manual	new
374	0	Elantra	74948	315	2024	4.7	2	4	0	White	0	8	2	2	5	Manual	new
375	19685	Equinox	51086	79	2018	1.8	4	5	3	Red	0	2	2	2	2	Manual	new
376	154679	RAV4	53687	227	2022	3.8	4	2	1	Black	0	9	4	4	1	Manual	new
377	61659	Optima	22295	89	2019	4.1	2	7	2	Silver	0	4	2	5	5	Manual	new
378	0	Malibu	65409	143	2025	4.1	2	4	0	Blue	0	2	4	5	5	Manual	new
379	0	Elantra	36663	93	2025	1.4	4	2	0	Silver	0	8	1	3	4	Manual	new
380	0	Accord	65231	130	2025	2.1	2	5	0	Red	0	3	2	5	3	Manual	new
381	0	Cruze	24201	215	2025	3.3	2	2	0	Black	0	2	2	1	2	Manual	new
382	0	Bolt	73714	95	2024	1.4	2	2	0	White	0	2	1	4	4	Manual	new
383	56943	Leaf	51906	117	2014	4.3	4	2	2	White	0	10	1	3	5	Manual	new
384	0	Optima	40485	239	2024	4.2	4	7	0	White	0	4	2	5	1	Manual	new
385	49774	Rio	54288	135	2020	3	4	2	2	Black	0	4	2	1	1	Manual	new
386	67541	EQC	78302	266	2023	1.3	2	7	2	Green	0	6	3	4	3	Manual	new
387	0	Accord	53490	307	2024	2.3	2	7	0	Blue	0	3	4	3	5	Manual	new
388	174080	Focus	29144	141	2015	4.5	2	4	2	Gray	0	1	1	2	5	Manual	new
389	56292	Equinox	34482	225	2023	4.7	4	5	2	Red	0	2	3	1	1	Manual	new
390	0	Leaf	73569	97	2025	1	4	2	0	Green	0	10	1	3	1	Manual	new
391	105346	e-tron	43287	178	2015	3.6	4	4	3	Blue	0	7	4	1	5	Manual	new
392	0	Insight	15754	78	2025	1.6	4	7	0	Blue	0	3	3	5	4	Manual	new
393	138540	Ioniq	40006	185	2010	1.7	2	7	2	Green	0	8	4	2	3	Manual	new
394	153937	EQC	22355	316	2006	4.8	2	4	1	Gray	0	6	4	1	2	Manual	new
395	0	Rio	59464	346	2024	4.2	4	2	0	Black	0	4	4	1	1	Manual	new
396	91904	Niro	77437	220	2023	2.2	2	5	3	Gray	0	4	4	1	2	Manual	new
397	0	Prius	33643	112	2024	1.5	2	5	0	Black	0	9	2	2	3	Manual	new
398	34242	GLC	57845	259	2005	4.2	4	4	3	White	0	6	3	2	3	Manual	new
399	0	RAV4	63929	281	2024	4.1	2	7	0	Gray	0	9	3	2	4	Manual	new
400	0	Rogue	25894	274	2025	2.9	4	4	0	White	0	10	1	4	5	Manual	new
1	41579	Focus	53382	86	2012	1.1	2	4	1	Silver	0	1	1	1	1	Manual	new
\.


--
-- Data for Name: car_image; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.car_image (id, url, "carId", type) FROM stdin;
1	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	1	main
2	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	2	main
3	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	3	main
4	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	4	main
5	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	5	main
6	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	6	main
7	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	7	main
8	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	8	main
9	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	9	main
10	33a9db78-9092-4281-8702-eb5130abcf98.webp	10	main
11	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	11	main
12	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	12	main
13	33a9db78-9092-4281-8702-eb5130abcf98.webp	13	main
14	33a9db78-9092-4281-8702-eb5130abcf98.webp	14	main
15	33a9db78-9092-4281-8702-eb5130abcf98.webp	15	main
16	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	16	main
17	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	17	main
18	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	18	main
19	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	19	main
20	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	20	main
21	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	21	main
22	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	22	main
23	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	23	main
24	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	24	main
25	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	25	main
26	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	26	main
27	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	27	main
28	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	28	main
29	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	29	main
30	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	30	main
31	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	31	main
32	33a9db78-9092-4281-8702-eb5130abcf98.webp	32	main
33	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	33	main
34	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	34	main
35	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	35	main
36	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	36	main
37	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	37	main
38	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	38	main
39	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	39	main
40	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	40	main
41	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	41	main
42	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	42	main
43	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	43	main
44	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	44	main
45	33a9db78-9092-4281-8702-eb5130abcf98.webp	45	main
46	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	46	main
47	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	47	main
48	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	48	main
49	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	49	main
50	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	50	main
51	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	51	main
52	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	52	main
53	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	53	main
54	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	54	main
55	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	55	main
56	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	56	main
57	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	57	main
58	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	58	main
59	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	59	main
60	33a9db78-9092-4281-8702-eb5130abcf98.webp	60	main
61	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	61	main
62	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	62	main
63	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	63	main
64	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	64	main
65	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	65	main
66	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	66	main
67	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	67	main
68	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	68	main
69	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	69	main
70	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	70	main
71	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	71	main
72	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	72	main
73	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	73	main
74	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	74	main
75	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	75	main
76	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	76	main
77	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	77	main
78	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	78	main
79	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	79	main
80	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	80	main
81	33a9db78-9092-4281-8702-eb5130abcf98.webp	81	main
82	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	82	main
83	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	83	main
84	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	84	main
85	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	85	main
86	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	86	main
87	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	87	main
88	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	88	main
89	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	89	main
90	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	90	main
91	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	91	main
92	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	92	main
93	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	93	main
94	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	94	main
95	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	95	main
96	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	96	main
97	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	97	main
98	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	98	main
99	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	99	main
100	33a9db78-9092-4281-8702-eb5130abcf98.webp	100	main
101	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	101	main
102	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	102	main
103	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	103	main
104	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	104	main
105	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	105	main
106	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	106	main
107	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	107	main
108	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	108	main
109	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	109	main
110	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	110	main
111	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	111	main
112	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	112	main
113	33a9db78-9092-4281-8702-eb5130abcf98.webp	113	main
114	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	114	main
115	33a9db78-9092-4281-8702-eb5130abcf98.webp	115	main
116	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	116	main
117	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	117	main
118	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	118	main
119	33a9db78-9092-4281-8702-eb5130abcf98.webp	119	main
120	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	120	main
121	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	121	main
122	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	122	main
123	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	123	main
124	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	124	main
125	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	125	main
126	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	126	main
127	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	127	main
128	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	128	main
129	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	129	main
130	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	130	main
131	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	131	main
132	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	132	main
133	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	133	main
134	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	134	main
135	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	135	main
136	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	136	main
137	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	137	main
138	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	138	main
139	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	139	main
140	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	140	main
141	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	141	main
142	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	142	main
143	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	143	main
144	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	144	main
145	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	145	main
146	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	146	main
147	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	147	main
148	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	148	main
149	33a9db78-9092-4281-8702-eb5130abcf98.webp	149	main
150	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	150	main
151	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	151	main
152	33a9db78-9092-4281-8702-eb5130abcf98.webp	152	main
153	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	153	main
154	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	154	main
155	33a9db78-9092-4281-8702-eb5130abcf98.webp	155	main
156	33a9db78-9092-4281-8702-eb5130abcf98.webp	156	main
157	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	157	main
158	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	158	main
159	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	159	main
160	33a9db78-9092-4281-8702-eb5130abcf98.webp	160	main
161	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	161	main
162	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	162	main
163	33a9db78-9092-4281-8702-eb5130abcf98.webp	163	main
164	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	164	main
165	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	165	main
166	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	166	main
167	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	167	main
168	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	168	main
169	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	169	main
170	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	170	main
171	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	171	main
172	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	172	main
173	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	173	main
174	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	174	main
175	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	175	main
176	33a9db78-9092-4281-8702-eb5130abcf98.webp	176	main
177	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	177	main
178	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	178	main
179	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	179	main
180	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	180	main
181	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	181	main
182	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	182	main
183	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	183	main
184	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	184	main
185	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	185	main
186	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	186	main
187	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	187	main
188	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	188	main
189	33a9db78-9092-4281-8702-eb5130abcf98.webp	189	main
190	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	190	main
191	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	191	main
192	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	192	main
193	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	193	main
194	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	194	main
195	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	195	main
196	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	196	main
197	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	197	main
198	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	198	main
199	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	199	main
200	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	200	main
201	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	201	main
202	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	202	main
203	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	203	main
204	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	204	main
205	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	205	main
206	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	206	main
207	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	207	main
208	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	208	main
209	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	209	main
210	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	210	main
211	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	211	main
212	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	212	main
213	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	213	main
214	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	214	main
215	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	215	main
216	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	216	main
217	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	217	main
218	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	218	main
219	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	219	main
220	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	220	main
221	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	221	main
222	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	222	main
223	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	223	main
224	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	224	main
225	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	225	main
226	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	226	main
227	33a9db78-9092-4281-8702-eb5130abcf98.webp	227	main
228	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	228	main
229	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	229	main
230	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	230	main
231	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	231	main
232	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	232	main
233	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	233	main
234	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	234	main
235	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	235	main
236	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	236	main
237	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	237	main
238	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	238	main
239	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	239	main
240	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	240	main
241	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	241	main
242	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	242	main
243	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	243	main
244	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	244	main
245	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	245	main
246	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	246	main
247	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	247	main
248	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	248	main
249	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	249	main
250	33a9db78-9092-4281-8702-eb5130abcf98.webp	250	main
251	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	251	main
252	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	252	main
253	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	253	main
254	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	254	main
255	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	255	main
256	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	256	main
257	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	257	main
258	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	258	main
259	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	259	main
260	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	260	main
261	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	261	main
262	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	262	main
263	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	263	main
264	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	264	main
265	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	265	main
266	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	266	main
267	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	267	main
268	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	268	main
269	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	269	main
270	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	270	main
271	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	271	main
272	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	272	main
273	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	273	main
274	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	274	main
275	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	275	main
276	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	276	main
277	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	277	main
278	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	278	main
279	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	279	main
280	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	280	main
281	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	281	main
282	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	282	main
283	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	283	main
284	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	284	main
285	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	285	main
286	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	286	main
287	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	287	main
288	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	288	main
289	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	289	main
290	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	290	main
291	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	291	main
292	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	292	main
293	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	293	main
294	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	294	main
295	33a9db78-9092-4281-8702-eb5130abcf98.webp	295	main
296	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	296	main
297	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	297	main
298	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	298	main
299	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	299	main
300	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	300	main
301	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	301	main
302	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	302	main
303	33a9db78-9092-4281-8702-eb5130abcf98.webp	303	main
304	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	304	main
305	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	305	main
306	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	306	main
307	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	307	main
308	33a9db78-9092-4281-8702-eb5130abcf98.webp	308	main
309	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	309	main
310	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	310	main
311	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	311	main
312	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	312	main
313	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	313	main
314	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	314	main
315	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	315	main
316	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	316	main
317	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	317	main
318	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	318	main
319	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	319	main
320	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	320	main
321	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	321	main
322	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	322	main
323	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	323	main
324	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	324	main
325	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	325	main
326	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	326	main
327	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	327	main
328	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	328	main
329	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	329	main
330	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	330	main
331	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	331	main
332	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	332	main
333	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	333	main
334	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	334	main
335	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	335	main
336	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	336	main
337	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	337	main
338	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	338	main
339	33a9db78-9092-4281-8702-eb5130abcf98.webp	339	main
340	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	340	main
341	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	341	main
342	33a9db78-9092-4281-8702-eb5130abcf98.webp	342	main
343	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	343	main
344	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	344	main
345	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	345	main
346	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	346	main
347	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	347	main
348	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	348	main
349	33a9db78-9092-4281-8702-eb5130abcf98.webp	349	main
350	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	350	main
351	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	351	main
352	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	352	main
353	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	353	main
354	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	354	main
355	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	355	main
356	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	356	main
357	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	357	main
358	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	358	main
359	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	359	main
360	33a9db78-9092-4281-8702-eb5130abcf98.webp	360	main
361	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	361	main
362	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	362	main
363	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	363	main
364	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	364	main
365	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	365	main
366	1d43b5e6-dca7-4942-87d0-0fb0b8b42615.webp	366	main
367	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	367	main
368	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	368	main
369	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	369	main
370	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	370	main
371	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	371	main
372	33a9db78-9092-4281-8702-eb5130abcf98.webp	372	main
373	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	373	main
374	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	374	main
375	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	375	main
376	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	376	main
377	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	377	main
378	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	378	main
379	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	379	main
380	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	380	main
381	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	381	main
382	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	382	main
383	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	383	main
384	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	384	main
385	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	385	main
386	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	386	main
387	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	387	main
388	e87f2473-6c2b-4d55-ac06-0925ee1120dd.webp	388	main
389	f557a05b-69d3-4753-a8d2-1ab1a6c89256.webp	389	main
390	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	390	main
391	33a9db78-9092-4281-8702-eb5130abcf98.webp	391	main
392	697d38c9-0aa6-4c1f-a435-5e4d866ca744.webp	392	main
393	6a97f6ac-803c-4ff6-b936-11ce65c48592.webp	393	main
394	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	394	main
395	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	395	main
396	449dd01d-7a1b-4e53-9d69-81b763e6de95.webp	396	main
397	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	397	main
398	09ac2ed6-9017-4cab-8fc9-8701bd002571.webp	398	main
399	96638e03-5945-4aaa-991f-8126e5f9b0ac.webp	399	main
400	a3c3bce9-8b25-4a9d-b37e-6ee13e6d0d48.webp	400	main
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.category (id, name) FROM stdin;
1	suv
2	convertible
3	sedan
4	pickup
5	coupe
\.


--
-- Data for Name: fuel_type; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fuel_type (id, type) FROM stdin;
1	hybrid
2	diesel
3	gasoline
4	electric
\.


--
-- Data for Name: recommendation; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.recommendation (id, date, "carId") FROM stdin;
\.


--
-- Data for Name: recommended_car; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.recommended_car (id, "recommendationId", "carId") FROM stdin;
\.


--
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.review (id, email, score, comment, "carId") FROM stdin;
1	user@example.com	4	Great car! Smooth ride and excellent fuel efficiency.	1
2	user@idigics.com	5	Noice	1
3	user@idigics.com	5	Noice	2
4	user@idigics.com	5	Noice	2
5	user@example.com	4	Great car! Smooth ride and excellent fuel efficiency.	2
\.


--
-- Data for Name: sub_category; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sub_category (id, name) FROM stdin;
1	luxary
2	sport
3	classic
4	economy
5	family
\.


--
-- Name: brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.brand_id_seq', 10, true);


--
-- Name: car_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.car_id_seq', 405, true);


--
-- Name: car_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.car_image_id_seq', 413, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.category_id_seq', 5, true);


--
-- Name: fuel_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.fuel_type_id_seq', 4, true);


--
-- Name: recommendation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.recommendation_id_seq', 1, false);


--
-- Name: recommended_car_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.recommended_car_id_seq', 1, false);


--
-- Name: review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.review_id_seq', 5, true);


--
-- Name: sub_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.sub_category_id_seq', 5, true);


--
-- Name: recommendation PK_17cb51984a6627ef2ce7370e23c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT "PK_17cb51984a6627ef2ce7370e23c" PRIMARY KEY (id);


--
-- Name: review PK_2e4299a343a81574217255c00ca; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT "PK_2e4299a343a81574217255c00ca" PRIMARY KEY (id);


--
-- Name: recommended_car PK_457fd2d856ee7c21d2414401b35; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.recommended_car
    ADD CONSTRAINT "PK_457fd2d856ee7c21d2414401b35" PRIMARY KEY (id);


--
-- Name: fuel_type PK_546a28980794b5335ca804e76d8; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fuel_type
    ADD CONSTRAINT "PK_546a28980794b5335ca804e76d8" PRIMARY KEY (id);


--
-- Name: car PK_55bbdeb14e0b1d7ab417d11ee6d; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT "PK_55bbdeb14e0b1d7ab417d11ee6d" PRIMARY KEY (id);


--
-- Name: sub_category PK_59f4461923255f1ce7fc5e7423c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sub_category
    ADD CONSTRAINT "PK_59f4461923255f1ce7fc5e7423c" PRIMARY KEY (id);


--
-- Name: car_image PK_76cf0a3401a80a59c62f3576bbc; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.car_image
    ADD CONSTRAINT "PK_76cf0a3401a80a59c62f3576bbc" PRIMARY KEY (id);


--
-- Name: category PK_9c4e4a89e3674fc9f382d733f03; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT "PK_9c4e4a89e3674fc9f382d733f03" PRIMARY KEY (id);


--
-- Name: brand PK_a5d20765ddd942eb5de4eee2d7f; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT "PK_a5d20765ddd942eb5de4eee2d7f" PRIMARY KEY (id);


--
-- Name: category UQ_23c05c292c439d77b0de816b500; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT "UQ_23c05c292c439d77b0de816b500" UNIQUE (name);


--
-- Name: fuel_type UQ_3d02f037dd544e5008c4ffd2f62; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fuel_type
    ADD CONSTRAINT "UQ_3d02f037dd544e5008c4ffd2f62" UNIQUE (type);


--
-- Name: brand UQ_5f468ae5696f07da025138e38f7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT "UQ_5f468ae5696f07da025138e38f7" UNIQUE (name);


--
-- Name: sub_category UQ_7745a7cea2687ee7b048f828c76; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sub_category
    ADD CONSTRAINT "UQ_7745a7cea2687ee7b048f828c76" UNIQUE (name);


--
-- Name: car_image FK_0200bc874183c1427906dd64e3b; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.car_image
    ADD CONSTRAINT "FK_0200bc874183c1427906dd64e3b" FOREIGN KEY ("carId") REFERENCES public.car(id) ON DELETE CASCADE;


--
-- Name: car FK_0cf42901253ea72db9ca703383d; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT "FK_0cf42901253ea72db9ca703383d" FOREIGN KEY ("categoryId") REFERENCES public.category(id);


--
-- Name: car FK_5135c20525a555f97a240a440f0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT "FK_5135c20525a555f97a240a440f0" FOREIGN KEY ("subCategoryId") REFERENCES public.sub_category(id);


--
-- Name: recommendation FK_66172aa1e5331473164be066cda; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT "FK_66172aa1e5331473164be066cda" FOREIGN KEY ("carId") REFERENCES public.car(id) ON DELETE CASCADE;


--
-- Name: car FK_728700aee449838965f5cf87cee; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT "FK_728700aee449838965f5cf87cee" FOREIGN KEY ("brandId") REFERENCES public.brand(id);


--
-- Name: review FK_a486d511114d8c1610818c33109; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT "FK_a486d511114d8c1610818c33109" FOREIGN KEY ("carId") REFERENCES public.car(id) ON DELETE CASCADE;


--
-- Name: recommended_car FK_c2f58bfd705979183c3e66fec12; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.recommended_car
    ADD CONSTRAINT "FK_c2f58bfd705979183c3e66fec12" FOREIGN KEY ("recommendationId") REFERENCES public.recommendation(id) ON DELETE CASCADE;


--
-- Name: car FK_f44f056613c5327358306b519c4; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.car
    ADD CONSTRAINT "FK_f44f056613c5327358306b519c4" FOREIGN KEY ("fuelTypeId") REFERENCES public.fuel_type(id);


--
-- Name: recommended_car FK_fd565f7dbed501e31919b5bb319; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.recommended_car
    ADD CONSTRAINT "FK_fd565f7dbed501e31919b5bb319" FOREIGN KEY ("carId") REFERENCES public.car(id);


--
-- PostgreSQL database dump complete
--

