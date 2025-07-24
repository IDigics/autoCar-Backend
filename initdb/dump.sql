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
-- Name: car_image_type_enum; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.car_image_type_enum AS ENUM (
    'main',
    'secondary'
);


ALTER TYPE public.car_image_type_enum OWNER TO admin;

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
    gear character varying NOT NULL,
    "offerType" character varying NOT NULL,
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
    "subCategoryId" integer
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

COPY public.car (id, mileage, model, gear, "offerType", price, "horsePower", year, "engineSize", doors, seats, "previousOwner", color, "averageReviewScore", "brandId", "fuelTypeId", "categoryId", "subCategoryId") FROM stdin;
1	41579	Focus	Automatic	used	53382	86	2012	1.1	2	4	1	Silver	0	1	1	1	1
2	159472	Malibu	Automatic	used	64322	151	2012	3.8	4	5	2	Blue	0	2	2	2	2
3	95165	Focus	Automatic	used	62432	344	2008	1.5	4	2	2	Silver	0	1	2	3	3
4	0	Accord	Manual	new	79039	189	2024	4.5	4	5	0	White	0	3	3	3	4
5	0	CR-V	Automatic	new	49719	195	2025	1.7	4	5	0	Gray	0	3	1	1	4
6	0	Civic	Manual	new	32403	178	2024	4.7	4	4	0	Gray	0	3	2	4	5
7	152159	Optima	Manual	used	73358	274	2009	2.4	2	7	1	Red	0	4	2	5	1
8	105039	5 Series	Manual	used	78120	75	2007	3.7	2	5	2	Green	0	5	4	3	1
9	0	EQC	Manual	new	78172	161	2025	3	2	5	0	Green	0	6	1	1	3
10	144029	A6	Manual	used	46759	127	2010	4.7	4	4	3	Red	0	7	1	2	3
11	37967	Focus	Manual	used	76545	154	2007	2.1	4	4	3	Silver	0	1	3	2	2
12	36720	Tucson	Automatic	used	19161	80	2021	3.4	2	4	2	Red	0	8	3	5	1
13	0	A4	Automatic	new	33101	318	2025	1.9	2	7	0	Blue	0	7	1	4	5
14	0	A4	Manual	new	41721	97	2025	3.7	2	2	0	White	0	7	2	3	1
15	0	A6	Manual	new	26926	306	2025	2	2	7	0	Green	0	7	3	1	1
16	0	Corolla	Manual	new	46566	179	2024	4.5	2	4	0	White	0	9	3	5	5
17	196497	EQC	Automatic	used	27343	181	2018	4.9	2	5	3	Red	0	6	4	5	3
18	0	Optima	Automatic	new	53677	190	2024	2.6	2	2	0	Silver	0	4	3	5	5
19	192745	Rogue	Automatic	used	32264	137	2011	3.7	4	7	3	Black	0	10	2	5	1
20	0	Rio	Automatic	new	75661	105	2024	4.5	4	5	0	Blue	0	4	2	4	3
21	74328	C-Class	Automatic	used	63257	149	2008	2.1	2	5	1	Blue	0	6	1	3	3
22	0	Sportage	Manual	new	17865	240	2024	4.1	4	4	0	Gray	0	4	4	4	3
23	0	Elantra	Automatic	new	69248	368	2024	3.2	4	4	0	Red	0	8	3	3	2
24	0	RAV4	Manual	new	65707	278	2024	4.9	2	4	0	Green	0	9	1	2	4
25	0	Elantra	Automatic	new	32342	125	2025	2.5	2	7	0	Blue	0	8	4	2	5
26	0	CR-V	Automatic	new	40900	212	2024	4.5	4	5	0	Gray	0	3	1	1	5
27	0	Equinox	Automatic	new	52738	205	2024	1.2	4	5	0	Gray	0	2	2	3	5
28	71773	Sentra	Manual	used	15109	345	2023	3.7	2	5	1	White	0	10	1	5	2
29	0	Rogue	Manual	new	36201	221	2025	3.2	2	7	0	Gray	0	10	2	4	4
30	84658	Rogue	Automatic	used	42942	366	2022	3.4	4	7	1	White	0	10	2	4	4
31	0	Bolt	Manual	new	21070	190	2024	3.7	2	4	0	Blue	0	2	2	5	1
32	0	e-tron	Automatic	new	61692	266	2025	3	2	4	0	Gray	0	7	4	5	1
33	0	Sonata	Automatic	new	74635	132	2025	2.8	4	5	0	Green	0	8	1	4	3
34	129433	Bolt	Manual	used	63865	396	2010	2.1	4	4	3	Black	0	2	4	4	1
35	146597	E-Class	Automatic	used	24803	266	2015	3.8	2	2	2	White	0	6	1	4	2
36	115138	Bolt	Automatic	used	70687	364	2006	2.5	2	5	1	Black	0	2	4	4	5
37	119251	Malibu	Automatic	used	40275	277	2012	3.9	4	4	2	Silver	0	2	4	1	1
38	0	Elantra	Manual	new	26812	203	2025	2.5	2	7	0	Black	0	8	3	3	5
39	10081	EQC	Manual	used	29574	105	2007	4.1	2	2	2	Blue	0	6	1	2	1
40	0	Altima	Automatic	new	51658	181	2024	2.9	4	5	0	Blue	0	10	4	1	3
41	11731	Mustang	Manual	used	40782	171	2008	1.3	2	2	3	Gray	0	1	2	3	3
42	178413	Focus	Automatic	used	47887	244	2022	1.1	4	7	2	Red	0	1	2	4	2
43	141772	Optima	Manual	used	45216	373	2010	2.1	2	2	3	Black	0	4	2	4	4
44	90200	Niro	Manual	used	28787	202	2005	2.4	4	2	2	Silver	0	4	3	2	1
45	186039	e-tron	Manual	used	44131	78	2022	1.4	2	7	1	Gray	0	7	4	2	2
46	95113	Rogue	Manual	used	37867	302	2022	2.1	4	4	3	Red	0	10	4	2	2
47	0	Mustang	Manual	new	62098	338	2024	3.4	2	4	0	Black	0	1	4	2	2
48	0	X3	Automatic	new	78329	353	2024	2.2	2	7	0	Red	0	5	2	5	3
49	53329	EQC	Manual	used	76169	314	2019	1.5	2	7	2	White	0	6	1	5	3
50	0	Camry	Automatic	new	22699	283	2025	3.4	2	7	0	White	0	9	1	4	2
51	20789	Leaf	Automatic	used	55658	205	2023	3.6	2	4	3	Blue	0	10	1	1	1
52	160664	3 Series	Manual	used	17121	217	2019	3.8	4	2	3	Gray	0	5	4	2	2
53	63932	Altima	Manual	used	68731	106	2008	1.2	4	5	3	White	0	10	3	5	5
54	134445	EQC	Automatic	used	53872	291	2021	3.9	4	2	3	Red	0	6	4	2	3
55	50925	Sentra	Manual	used	74544	162	2023	5	4	7	1	Red	0	10	4	4	2
56	91456	Tucson	Manual	used	33734	275	2008	4.3	2	7	1	Red	0	8	4	3	2
57	177401	Civic	Manual	used	18523	335	2021	2.4	4	7	1	Green	0	3	4	5	4
58	132064	E-Class	Automatic	used	78254	381	2019	4.2	2	5	3	Silver	0	6	1	5	3
59	0	Elantra	Automatic	new	57101	148	2024	3	4	5	0	White	0	8	4	4	5
60	0	e-tron	Automatic	new	71161	211	2025	4.1	4	5	0	Green	0	7	3	1	2
61	177999	RAV4	Automatic	used	44025	317	2023	2.4	4	7	3	Black	0	9	4	2	4
62	0	Leaf	Manual	new	63405	265	2025	2.5	2	7	0	Red	0	10	1	2	3
63	0	Rogue	Manual	new	15997	143	2025	2.6	2	2	0	White	0	10	1	3	2
64	0	Leaf	Manual	new	55741	319	2025	4.5	2	2	0	Blue	0	10	4	3	4
65	0	F-150	Automatic	new	60110	84	2024	1.2	2	5	0	Black	0	1	4	3	5
66	52200	5 Series	Automatic	used	20132	265	2023	3.5	2	7	3	Silver	0	5	3	2	4
67	7463	Sportage	Manual	used	59044	150	2013	1.3	4	5	3	Gray	0	4	4	4	2
68	0	Sportage	Automatic	new	30418	362	2025	2.4	4	5	0	Red	0	4	4	4	2
69	164138	Corolla	Automatic	used	56380	387	2014	2	2	2	1	Gray	0	9	2	5	2
70	82361	Rio	Manual	used	26416	137	2009	4.1	4	5	1	Green	0	4	2	2	2
71	24739	Sportage	Automatic	used	70909	273	2008	4.9	4	2	2	Green	0	4	3	4	1
72	181250	C-Class	Manual	used	68457	260	2016	1.4	2	7	3	Red	0	6	2	1	3
73	0	Accord	Manual	new	22583	93	2025	4.8	4	7	0	Red	0	3	2	5	4
74	180763	Malibu	Automatic	used	72551	120	2019	4.3	4	5	2	Red	0	2	4	3	4
75	0	Niro	Manual	new	50390	400	2025	2.4	4	5	0	Blue	0	4	1	5	5
76	0	Mustang	Automatic	new	79273	359	2024	1.8	2	4	0	Green	0	1	2	2	2
77	146614	3 Series	Automatic	used	22145	83	2009	1.5	4	4	1	Silver	0	5	2	3	1
78	0	X3	Automatic	new	63468	313	2024	2.8	4	2	0	White	0	5	4	1	4
79	13165	Sentra	Manual	used	70074	288	2019	3.7	4	7	3	Red	0	10	1	5	2
80	0	Altima	Manual	new	39758	375	2024	3.1	4	7	0	Red	0	10	2	5	3
81	93848	e-tron	Manual	used	42039	118	2012	2.3	4	5	2	Black	0	7	4	2	5
82	0	Focus	Automatic	new	63398	260	2024	4.2	2	5	0	Gray	0	1	4	5	5
83	0	Insight	Manual	new	21734	329	2025	1.9	4	4	0	Green	0	3	2	5	2
84	0	Equinox	Manual	new	69935	388	2025	3.5	2	5	0	Red	0	2	3	2	2
85	42552	GLC	Automatic	used	24221	394	2005	4.9	2	4	1	White	0	6	4	4	5
86	90035	Accord	Automatic	used	25112	386	2014	1.2	2	5	3	White	0	3	1	4	5
87	139308	Leaf	Manual	used	42944	215	2013	3.7	4	5	1	Red	0	10	1	2	5
88	0	Sentra	Automatic	new	64877	200	2024	2.2	2	2	0	White	0	10	2	4	4
89	0	i3	Manual	new	71014	91	2025	2.7	4	2	0	Green	0	5	1	3	3
90	111176	Ioniq	Manual	used	26171	386	2014	2.8	4	2	1	White	0	8	1	5	4
91	0	Ioniq	Manual	new	29402	156	2025	1.3	2	4	0	Green	0	8	2	3	2
92	0	5 Series	Automatic	new	26277	148	2024	4	2	4	0	Green	0	5	2	4	5
93	120281	Leaf	Manual	used	43743	225	2015	4.2	2	5	1	Silver	0	10	1	5	2
94	0	Niro	Manual	new	19987	116	2024	3.5	4	7	0	Silver	0	4	2	1	1
95	44547	Optima	Manual	used	21727	245	2020	4.9	2	4	3	Red	0	4	1	2	5
96	106558	Optima	Manual	used	59128	96	2016	4.2	4	2	2	Black	0	4	4	5	3
97	26365	Tucson	Manual	used	35165	270	2009	1.5	2	5	2	Silver	0	8	3	4	2
98	9779	3 Series	Manual	used	26717	179	2021	2.4	4	4	2	Blue	0	5	2	2	4
99	0	Explorer	Automatic	new	53821	148	2024	1.6	2	7	0	Red	0	1	2	4	2
100	144987	e-tron	Manual	used	77763	310	2019	4.6	2	5	1	Gray	0	7	3	1	5
101	114749	Sportage	Automatic	used	67081	140	2021	4.5	2	7	3	Green	0	4	3	3	3
102	76510	Focus	Automatic	used	69018	116	2007	4.8	2	7	1	Black	0	1	4	5	5
103	26392	Prius	Automatic	used	16832	120	2012	4.4	4	4	2	Blue	0	9	2	5	2
104	6376	Optima	Automatic	used	31635	146	2019	3.2	4	2	3	Green	0	4	1	3	4
105	0	C-Class	Manual	new	19082	325	2024	3.4	2	4	0	Gray	0	6	4	2	2
106	114200	Elantra	Automatic	used	49026	254	2012	1.3	2	7	3	Green	0	8	3	4	1
107	22710	Tucson	Automatic	used	62641	391	2005	1.4	4	4	2	Red	0	8	2	3	3
108	52783	Accord	Automatic	used	61542	304	2020	1.1	2	2	3	Green	0	3	3	2	1
109	71404	CR-V	Automatic	used	33597	94	2022	4.5	4	5	2	Red	0	3	1	3	5
110	135076	Ioniq	Manual	used	75080	335	2015	2.1	2	7	1	Red	0	8	4	4	3
111	90962	X3	Manual	used	43984	288	2008	1.7	4	5	1	White	0	5	2	5	2
112	180946	Leaf	Manual	used	48350	151	2006	4.8	2	7	1	Red	0	10	4	2	1
113	13489	Q5	Manual	used	76673	260	2017	2.8	2	4	3	Silver	0	7	3	3	5
114	0	CR-V	Automatic	new	47437	268	2024	4.7	2	5	0	Green	0	3	1	3	5
115	40580	Q5	Manual	used	26222	297	2011	5	4	5	1	Gray	0	7	1	5	3
116	191007	Equinox	Manual	used	48069	132	2010	4.9	2	4	3	Green	0	2	3	4	1
117	165418	CR-V	Automatic	used	35103	315	2022	3.1	4	2	1	Blue	0	3	1	3	1
118	172718	Niro	Automatic	used	43120	98	2009	4.3	2	5	3	Blue	0	4	3	2	2
119	56459	Q5	Automatic	used	55626	384	2007	3.1	2	4	2	Blue	0	7	2	1	3
120	0	Civic	Manual	new	57323	362	2024	2.7	2	7	0	Gray	0	3	1	1	2
121	0	EQC	Manual	new	19743	100	2025	1.6	4	7	0	White	0	6	2	2	2
122	95536	Altima	Automatic	used	64443	333	2015	3.2	4	4	3	White	0	10	4	5	2
123	0	Optima	Manual	new	76450	385	2024	2.7	2	5	0	Silver	0	4	1	3	4
124	135382	i3	Automatic	used	76440	328	2020	2.8	2	4	2	Silver	0	5	1	3	1
125	145690	RAV4	Automatic	used	43010	205	2020	3.9	4	5	2	Red	0	9	1	4	1
126	24275	Altima	Manual	used	64686	213	2022	4.3	2	4	2	Red	0	10	4	4	2
127	0	CR-V	Automatic	new	17944	140	2024	3.9	4	7	0	Blue	0	3	4	1	3
128	166611	X3	Manual	used	47975	330	2010	3.1	4	7	2	Green	0	5	2	5	2
129	195139	Civic	Manual	used	32259	366	2023	3.3	2	7	2	Blue	0	3	1	1	3
130	0	Sonata	Automatic	new	16230	230	2024	2.7	4	4	0	White	0	8	1	1	3
131	0	Rio	Manual	new	49156	230	2024	4.8	4	5	0	Silver	0	4	2	3	2
132	0	Leaf	Manual	new	29616	222	2024	4.1	2	7	0	Black	0	10	2	4	2
133	182372	Equinox	Manual	used	68194	144	2008	2.2	4	2	3	Black	0	2	4	4	2
134	0	Optima	Automatic	new	22099	370	2025	2	2	4	0	Gray	0	4	2	2	1
135	183570	F-150	Automatic	used	77693	150	2020	2.6	4	7	1	Gray	0	1	3	2	2
136	0	CR-V	Automatic	new	74359	159	2024	2.7	2	2	0	Green	0	3	3	4	5
137	0	X3	Automatic	new	75349	241	2024	2.1	4	4	0	Green	0	5	2	1	5
138	0	E-Class	Manual	new	57138	165	2025	1.1	4	5	0	Silver	0	6	3	2	4
139	27737	Leaf	Automatic	used	27010	141	2021	2.9	2	2	2	Black	0	10	4	4	4
140	194499	Sportage	Manual	used	57489	190	2014	1.2	2	7	3	Black	0	4	1	2	5
141	0	Equinox	Automatic	new	29243	138	2025	2.9	4	5	0	White	0	2	2	1	5
142	0	Malibu	Manual	new	20076	358	2024	1.4	2	4	0	Blue	0	2	4	3	3
143	0	Rio	Manual	new	67564	302	2025	1.5	4	7	0	Silver	0	4	1	5	3
144	0	Sportage	Automatic	new	63477	366	2025	1.3	4	5	0	Gray	0	4	2	5	3
145	112182	Corolla	Automatic	used	64778	400	2006	4.9	4	7	2	White	0	9	3	4	5
146	145839	Mustang	Automatic	used	62310	184	2008	4.3	2	5	1	White	0	1	4	1	5
147	0	Bolt	Manual	new	25082	166	2024	4.7	2	2	0	Green	0	2	4	4	3
148	0	Camry	Automatic	new	44018	94	2024	2	2	7	0	White	0	9	1	2	3
149	0	A4	Manual	new	52535	234	2025	1.9	2	4	0	White	0	7	3	3	2
150	17290	Camry	Manual	used	66077	233	2022	3.8	4	4	2	Black	0	9	2	4	4
151	0	Bolt	Automatic	new	67375	99	2024	3.2	4	4	0	White	0	2	2	2	2
152	0	Q5	Automatic	new	49816	167	2025	1.2	4	2	0	Green	0	7	2	5	4
153	84478	Altima	Automatic	used	75915	130	2011	4	4	4	2	Gray	0	10	1	1	4
154	127224	Sonata	Manual	used	32001	332	2014	4.5	4	2	2	Green	0	8	2	4	2
155	152462	Q5	Automatic	used	16054	353	2018	4.7	4	5	1	Blue	0	7	3	2	2
156	0	e-tron	Manual	new	64618	320	2025	4.9	4	7	0	Blue	0	7	2	3	4
157	0	i3	Automatic	new	76437	94	2024	4.1	4	4	0	Green	0	5	1	2	1
158	0	3 Series	Automatic	new	55159	385	2025	4.7	4	2	0	Red	0	5	2	1	3
159	0	Elantra	Automatic	new	47644	290	2025	4.2	2	2	0	Red	0	8	2	1	4
160	109044	A6	Manual	used	77354	305	2016	3.3	2	5	2	Gray	0	7	1	5	1
161	129781	F-150	Automatic	used	60684	112	2017	3	4	5	3	Silver	0	1	1	5	3
162	0	Camry	Automatic	new	75070	213	2025	4.6	2	4	0	Green	0	9	2	3	1
163	47585	A6	Manual	used	59007	346	2007	2.3	2	2	2	Silver	0	7	3	3	1
164	0	F-150	Manual	new	77979	237	2024	1.1	4	7	0	White	0	1	2	2	2
165	158583	Bolt	Automatic	used	65190	221	2010	4.2	2	2	3	Black	0	2	4	2	5
166	28991	i3	Manual	used	43907	208	2016	1.4	2	4	1	White	0	5	1	4	3
167	0	Bolt	Manual	new	51024	375	2024	3.4	4	7	0	Red	0	2	1	3	5
168	0	Elantra	Automatic	new	24024	224	2024	2.1	2	2	0	Blue	0	8	4	4	2
169	70981	Tucson	Manual	used	53597	170	2007	2.8	2	5	2	Red	0	8	3	4	2
170	117883	Leaf	Manual	used	35843	172	2019	2.9	2	7	2	Black	0	10	3	3	5
171	108005	Altima	Automatic	used	75584	172	2017	3.4	2	2	2	Gray	0	10	2	4	4
172	0	Sportage	Automatic	new	56166	193	2025	2	2	7	0	Green	0	4	4	4	1
173	186327	Niro	Automatic	used	66396	254	2022	3.8	2	2	3	Green	0	4	4	2	2
174	32772	3 Series	Automatic	used	31817	331	2015	4	2	7	2	Black	0	5	1	4	5
175	32406	Altima	Manual	used	74835	113	2005	1.5	2	5	2	Black	0	10	2	3	5
176	119862	e-tron	Manual	used	19366	92	2020	4.2	2	2	1	Green	0	7	4	3	1
177	0	5 Series	Manual	new	77300	188	2024	4.2	2	4	0	Gray	0	5	2	4	5
178	106930	Camry	Automatic	used	28375	102	2023	3.3	2	5	2	Black	0	9	1	2	5
179	87157	Explorer	Manual	used	53155	248	2021	2.4	4	4	3	Green	0	1	4	3	3
180	0	Sentra	Automatic	new	34849	163	2025	2.5	2	7	0	White	0	10	1	1	4
181	171592	Leaf	Automatic	used	46826	141	2010	1.7	4	2	2	Green	0	10	3	3	1
182	0	Optima	Manual	new	59505	282	2025	3.8	4	7	0	Blue	0	4	4	5	3
183	63941	Camry	Automatic	used	65748	359	2006	4	4	2	2	Silver	0	9	2	5	2
184	0	Equinox	Manual	new	21657	196	2025	2.2	2	7	0	Black	0	2	3	3	1
185	0	Rio	Manual	new	25788	141	2024	4.1	2	2	0	Silver	0	4	2	3	3
186	155139	E-Class	Automatic	used	23813	280	2014	4.7	4	4	2	Gray	0	6	2	2	4
187	0	X3	Automatic	new	52532	207	2025	3.5	4	7	0	Red	0	5	4	5	5
188	90796	Equinox	Automatic	used	62510	304	2019	3.5	4	2	2	Green	0	2	1	1	5
189	0	e-tron	Manual	new	68842	242	2025	3.2	2	7	0	Green	0	7	2	3	1
190	46414	Corolla	Manual	used	15043	289	2005	1.8	2	5	1	Blue	0	9	4	3	1
191	0	CR-V	Automatic	new	40762	226	2025	3.9	2	7	0	Gray	0	3	3	5	1
192	160629	Camry	Manual	used	15603	245	2007	4.3	4	4	1	White	0	9	3	5	4
193	0	Elantra	Manual	new	72264	140	2024	2.5	2	4	0	Red	0	8	2	1	3
194	60851	Camry	Manual	used	55044	296	2016	4.4	2	2	3	Blue	0	9	3	5	3
195	69955	Tucson	Automatic	used	31130	377	2015	3.4	4	2	1	Green	0	8	2	3	4
196	19304	Malibu	Manual	used	40082	193	2014	3	2	2	3	Black	0	2	3	3	4
197	50290	Ioniq	Automatic	used	16084	104	2022	1.1	2	2	3	Red	0	8	4	4	3
198	172913	EQC	Manual	used	20433	110	2017	3	2	4	1	Silver	0	6	3	3	5
199	67557	Sentra	Automatic	used	20603	292	2018	1.5	2	5	3	Gray	0	10	1	2	1
200	0	Camry	Manual	new	48995	202	2024	1.7	2	5	0	Gray	0	9	4	5	1
201	73930	Insight	Manual	used	44587	254	2021	1.2	2	5	1	Blue	0	3	1	3	1
202	0	Sentra	Automatic	new	30895	311	2024	2.5	2	4	0	Green	0	10	1	5	3
203	193819	Sonata	Manual	used	68689	362	2012	2.5	2	4	2	Blue	0	8	2	1	1
204	90799	Elantra	Manual	used	15518	172	2014	2.2	4	4	2	White	0	8	1	3	3
205	0	Optima	Manual	new	16554	347	2024	2.4	2	5	0	Red	0	4	1	4	2
206	0	Mustang	Automatic	new	78216	142	2025	3.8	2	2	0	Blue	0	1	4	1	5
207	0	Insight	Manual	new	19863	360	2024	1.2	2	4	0	Black	0	3	3	3	2
208	66239	Tucson	Automatic	used	23847	369	2019	1.4	2	4	2	White	0	8	1	4	2
209	85821	Elantra	Manual	used	70411	116	2011	1.6	4	2	2	Blue	0	8	4	3	4
210	17832	Mustang	Manual	used	68305	159	2017	1.1	4	7	3	Silver	0	1	2	1	4
211	0	F-150	Automatic	new	19008	183	2024	1.5	4	5	0	Gray	0	1	1	5	3
212	0	Rogue	Automatic	new	73662	297	2024	4.2	2	5	0	Red	0	10	1	5	5
213	12728	Camry	Manual	used	26232	179	2017	4.6	4	5	2	White	0	9	4	2	1
214	149359	Altima	Automatic	used	20701	266	2020	1.5	2	4	2	Gray	0	10	4	1	1
215	95186	Tucson	Manual	used	32578	83	2022	2.3	2	2	2	Green	0	8	2	3	1
216	0	Sportage	Automatic	new	57696	206	2024	3.1	2	4	0	Silver	0	4	1	4	2
217	0	5 Series	Automatic	new	60724	250	2025	4.8	2	4	0	Green	0	5	2	4	3
218	19724	E-Class	Automatic	used	16295	314	2006	1	2	4	1	Black	0	6	3	2	2
219	0	Corolla	Manual	new	77436	261	2024	3.8	4	2	0	Black	0	9	1	3	2
220	88173	5 Series	Manual	used	29510	371	2020	4.3	4	5	3	Gray	0	5	3	3	4
221	52731	3 Series	Automatic	used	56577	123	2023	4.7	2	5	1	Gray	0	5	2	5	4
222	0	CR-V	Manual	new	15740	177	2024	2	2	5	0	Black	0	3	2	5	1
223	113532	Prius	Manual	used	37830	262	2018	1.4	4	4	1	Blue	0	9	4	4	1
224	0	RAV4	Automatic	new	19823	157	2025	4.6	2	2	0	Silver	0	9	2	5	2
225	0	Leaf	Manual	new	25211	121	2025	2.3	2	7	0	Gray	0	10	3	1	3
226	18011	GLC	Manual	used	24983	254	2012	1	2	5	1	Green	0	6	4	1	5
227	0	A4	Manual	new	78508	312	2024	4.4	4	7	0	White	0	7	3	4	2
228	0	F-150	Manual	new	27127	92	2025	2.1	4	5	0	Blue	0	1	4	3	3
229	0	Camry	Manual	new	78095	371	2024	1.9	2	7	0	Green	0	9	2	1	5
230	0	Bolt	Automatic	new	40662	87	2025	3	2	2	0	Green	0	2	2	4	4
231	0	5 Series	Manual	new	20093	292	2024	1.8	2	5	0	Black	0	5	1	5	1
232	125103	Ioniq	Manual	used	22313	146	2013	1.6	2	2	3	Silver	0	8	1	5	2
233	176648	Equinox	Manual	used	17435	211	2013	2.6	4	2	2	White	0	2	4	3	4
234	93569	Prius	Manual	used	33222	321	2016	4.4	2	4	1	Blue	0	9	2	3	5
235	120793	CR-V	Manual	used	63161	334	2007	4.5	2	4	1	Red	0	3	3	3	3
236	0	Sonata	Automatic	new	69403	197	2024	1.1	2	5	0	Gray	0	8	3	2	2
237	13011	Insight	Manual	used	46771	298	2008	1.7	4	5	3	Black	0	3	3	2	2
238	0	Explorer	Automatic	new	70498	179	2025	4.4	2	4	0	Black	0	1	1	4	3
239	50403	Corolla	Automatic	used	31405	226	2009	3.9	4	7	3	White	0	9	1	3	5
240	141482	E-Class	Automatic	used	15477	261	2014	3.2	4	5	3	Gray	0	6	4	5	5
241	73458	Explorer	Automatic	used	24745	193	2015	4.6	4	5	2	Gray	0	1	2	2	1
242	106783	Sportage	Automatic	used	37305	183	2018	3.7	4	5	2	Silver	0	4	1	3	4
243	38539	Malibu	Automatic	used	76550	241	2008	3.6	2	5	2	Blue	0	2	2	3	5
244	126572	CR-V	Manual	used	18489	394	2023	3.3	2	7	2	Blue	0	3	1	1	1
245	41009	Tucson	Manual	used	41597	361	2006	4.6	4	4	1	Black	0	8	3	2	1
246	0	Sportage	Automatic	new	44383	177	2025	4	2	4	0	White	0	4	1	5	4
247	130147	Leaf	Automatic	used	17452	172	2017	3.9	2	5	2	Green	0	10	4	1	4
248	0	Corolla	Manual	new	23380	266	2024	3	4	4	0	Red	0	9	2	5	2
249	40072	EQC	Manual	used	38351	166	2018	1.7	4	2	3	Blue	0	6	2	2	4
250	0	A4	Automatic	new	39387	397	2024	2	2	2	0	Gray	0	7	2	5	1
251	37399	Corolla	Manual	used	60621	175	2019	3.8	2	5	2	White	0	9	2	5	3
252	193420	E-Class	Manual	used	22410	124	2008	3	2	5	3	Green	0	6	1	1	4
253	148691	Insight	Automatic	used	59733	316	2010	2.3	2	2	1	Gray	0	3	4	5	1
254	0	Leaf	Automatic	new	73810	399	2024	1.9	4	5	0	White	0	10	1	5	1
255	86974	3 Series	Automatic	used	21174	93	2016	1	2	4	3	Black	0	5	4	3	5
256	0	Rogue	Automatic	new	22399	274	2025	4.8	4	7	0	Gray	0	10	2	4	5
257	0	3 Series	Automatic	new	42041	372	2024	2.9	4	4	0	Silver	0	5	3	4	2
258	0	Sentra	Automatic	new	72693	295	2025	1.2	4	5	0	Red	0	10	4	1	3
259	185418	Altima	Manual	used	58011	197	2021	2.9	4	4	3	Green	0	10	1	1	3
260	0	Corolla	Automatic	new	19866	321	2025	2.3	4	5	0	Red	0	9	4	1	4
261	125348	Bolt	Manual	used	20721	325	2012	2.8	2	7	1	Gray	0	2	4	5	1
262	0	Ioniq	Manual	new	72857	357	2024	1.8	4	5	0	Black	0	8	1	5	4
263	123628	Sportage	Automatic	used	64355	183	2016	1	4	5	3	Silver	0	4	1	1	2
264	0	Focus	Manual	new	21952	382	2025	1.8	2	7	0	Blue	0	1	3	4	4
265	181197	Civic	Manual	used	44730	371	2006	4.8	2	7	3	Red	0	3	1	1	1
266	186355	Bolt	Automatic	used	21731	377	2021	3.4	4	7	1	White	0	2	3	1	4
267	39962	EQC	Manual	used	54164	332	2014	2.2	4	4	2	Blue	0	6	3	2	3
268	0	GLC	Automatic	new	64450	357	2024	2.9	4	5	0	Green	0	6	2	4	1
269	0	Cruze	Automatic	new	58566	172	2025	2.1	2	5	0	Gray	0	2	3	3	4
270	0	RAV4	Manual	new	21661	357	2024	4.5	4	4	0	Silver	0	9	2	3	1
271	19103	Ioniq	Manual	used	28200	296	2015	4.3	4	4	3	Green	0	8	1	2	2
272	0	Optima	Automatic	new	39517	289	2024	2.1	4	4	0	Blue	0	4	3	1	2
273	45292	RAV4	Automatic	used	65287	390	2009	3.5	4	7	1	Green	0	9	2	1	3
274	53200	Civic	Automatic	used	42035	344	2021	2.6	4	4	1	Blue	0	3	1	3	2
275	0	CR-V	Automatic	new	58481	298	2025	2	2	2	0	Gray	0	3	1	3	5
276	79141	F-150	Manual	used	48430	330	2022	2.8	2	5	3	Gray	0	1	1	2	2
277	0	Cruze	Automatic	new	28700	392	2024	4.1	4	2	0	Blue	0	2	1	1	5
278	0	Mustang	Automatic	new	20688	97	2025	1.7	4	2	0	Silver	0	1	2	2	2
279	87943	Ioniq	Manual	used	58764	343	2017	1	2	2	2	Gray	0	8	1	5	2
280	27676	Cruze	Manual	used	39791	85	2014	2.9	2	4	3	Gray	0	2	2	4	3
281	150103	E-Class	Automatic	used	17715	363	2016	3.4	2	5	1	Blue	0	6	3	3	4
282	0	Sonata	Manual	new	27631	162	2024	3.7	2	7	0	Gray	0	8	3	1	1
283	195208	C-Class	Manual	used	38213	190	2008	1.4	2	4	1	Black	0	6	4	4	5
284	0	CR-V	Manual	new	25961	230	2025	2	2	7	0	Black	0	3	2	3	4
285	85077	Insight	Automatic	used	26425	380	2019	1.3	4	4	2	Silver	0	3	4	2	2
286	0	Focus	Automatic	new	73909	352	2024	2	4	4	0	Black	0	1	4	4	4
287	0	Rogue	Manual	new	38651	75	2025	3.7	2	4	0	White	0	10	1	2	4
288	62362	Altima	Automatic	used	19085	259	2016	1.9	2	5	1	White	0	10	4	4	5
289	141674	Corolla	Manual	used	52611	361	2008	1.7	4	5	3	Silver	0	9	2	5	3
290	0	EQC	Manual	new	46646	316	2025	4.5	2	4	0	White	0	6	2	2	4
291	0	Explorer	Automatic	new	38544	130	2024	3.6	4	5	0	Gray	0	1	3	5	5
292	0	Niro	Automatic	new	30838	135	2024	3.3	2	4	0	Gray	0	4	4	1	1
293	0	Altima	Automatic	new	48581	277	2024	3.4	2	5	0	Red	0	10	2	2	5
294	112680	Leaf	Automatic	used	55508	331	2010	2.1	4	7	1	Silver	0	10	3	1	1
295	9341	e-tron	Manual	used	68723	380	2009	1.4	4	2	1	Green	0	7	3	1	3
296	146370	Focus	Manual	used	48932	259	2009	4.5	4	4	3	Green	0	1	1	4	5
297	130079	Civic	Automatic	used	33412	348	2009	2.6	2	2	2	Gray	0	3	3	5	3
298	0	Cruze	Manual	new	41574	124	2025	1.6	4	5	0	Green	0	2	3	1	5
299	113325	Rogue	Automatic	used	39063	354	2017	2.9	4	5	1	Green	0	10	4	4	4
300	61218	Mustang	Manual	used	67055	384	2010	3.8	2	4	1	White	0	1	4	5	1
301	73967	i3	Manual	used	20202	89	2007	3.9	4	5	1	Gray	0	5	3	1	1
302	177198	i3	Automatic	used	17184	376	2005	3	2	4	1	Gray	0	5	2	5	2
303	0	A4	Manual	new	37953	272	2024	2.6	2	2	0	Gray	0	7	2	5	1
304	64322	Equinox	Manual	used	75431	364	2016	1	2	7	2	Silver	0	2	3	5	3
305	72552	Explorer	Manual	used	77793	358	2008	2.9	2	5	3	Green	0	1	2	4	5
306	22708	Sentra	Automatic	used	58999	187	2008	4.2	4	5	2	Silver	0	10	4	1	1
307	181605	E-Class	Automatic	used	51045	161	2007	2.9	4	4	2	Silver	0	6	2	3	4
308	0	e-tron	Manual	new	28440	173	2024	4.3	4	4	0	Green	0	7	3	5	1
309	0	F-150	Manual	new	55343	322	2024	4.6	4	7	0	Blue	0	1	4	1	2
310	0	Sonata	Manual	new	76077	86	2024	3	4	4	0	White	0	8	4	5	3
311	0	Sportage	Manual	new	52765	236	2024	2.4	4	4	0	Silver	0	4	3	3	4
312	135749	EQC	Automatic	used	42241	260	2016	2.5	4	5	1	White	0	6	4	2	3
313	0	5 Series	Manual	new	70660	170	2025	1.6	2	7	0	Green	0	5	3	5	4
314	0	Ioniq	Manual	new	31313	360	2025	1.2	2	4	0	Red	0	8	4	2	2
315	99624	Rio	Manual	used	37369	280	2015	1.5	2	4	2	Green	0	4	2	3	2
316	165868	Insight	Manual	used	56061	144	2007	4.5	4	7	2	Gray	0	3	2	1	3
317	0	Elantra	Automatic	new	35376	219	2024	3.8	4	5	0	White	0	8	2	3	3
318	11055	Bolt	Automatic	used	58031	110	2010	1.8	4	2	1	Red	0	2	3	5	5
319	0	Cruze	Automatic	new	32059	149	2025	1.3	4	5	0	Blue	0	2	1	2	2
320	0	Optima	Automatic	new	58130	236	2024	4.5	4	5	0	Silver	0	4	1	4	4
321	142221	Malibu	Manual	used	46307	186	2023	4.2	4	5	2	Black	0	2	2	4	2
322	0	X3	Manual	new	33639	343	2024	1	4	7	0	Black	0	5	3	5	5
323	0	E-Class	Manual	new	72340	293	2025	2.6	2	7	0	Green	0	6	3	4	4
324	165750	C-Class	Manual	used	57149	342	2012	4.2	4	4	3	Green	0	6	2	5	4
325	0	X3	Manual	new	60530	321	2025	1.8	2	4	0	Red	0	5	4	1	1
326	192484	3 Series	Automatic	used	30132	147	2013	1.1	2	5	1	White	0	5	4	3	5
327	0	Insight	Automatic	new	18642	270	2025	1.3	4	4	0	Blue	0	3	1	3	5
328	0	Corolla	Automatic	new	62945	87	2025	1.8	2	4	0	White	0	9	4	4	2
329	0	Accord	Manual	new	56503	171	2024	2.4	2	4	0	Red	0	3	2	2	5
330	0	Civic	Manual	new	66294	74	2025	4.9	4	4	0	Black	0	3	1	5	4
331	0	i3	Automatic	new	38108	148	2025	3.8	2	4	0	White	0	5	1	2	2
332	185682	Equinox	Manual	used	62085	198	2011	4.6	4	7	1	Silver	0	2	4	3	3
333	0	Optima	Manual	new	32896	376	2025	4.7	2	2	0	Silver	0	4	2	2	5
334	172254	GLC	Automatic	used	72390	387	2019	4.4	2	5	1	Gray	0	6	4	5	3
335	165704	Sonata	Manual	used	41637	234	2022	1.4	2	2	1	Green	0	8	2	2	4
336	0	Camry	Automatic	new	17068	398	2025	4.3	4	5	0	Red	0	9	3	3	4
337	0	Sentra	Automatic	new	45423	397	2024	1.2	4	5	0	Green	0	10	4	5	3
338	0	C-Class	Automatic	new	77438	119	2025	1.4	2	7	0	Blue	0	6	1	2	3
339	156142	A6	Manual	used	60665	288	2008	4.5	2	4	3	Silver	0	7	2	4	3
340	149200	Accord	Manual	used	41802	394	2016	2.7	4	4	2	Silver	0	3	2	1	4
341	109094	Tucson	Automatic	used	78892	375	2019	1.1	2	5	2	Red	0	8	1	3	4
342	0	Q5	Automatic	new	17452	252	2025	1.6	4	5	0	Silver	0	7	3	2	4
343	0	GLC	Automatic	new	62032	317	2025	1.7	2	5	0	Red	0	6	3	1	5
344	114188	Focus	Automatic	used	63599	378	2016	4.7	4	2	2	Black	0	1	1	1	1
345	62880	Accord	Automatic	used	58786	271	2021	4.9	2	4	3	White	0	3	3	3	5
346	154799	5 Series	Manual	used	32066	274	2007	3	2	4	2	White	0	5	1	1	4
347	0	Niro	Automatic	new	32306	290	2024	2.3	2	2	0	Gray	0	4	3	4	5
348	0	CR-V	Automatic	new	65029	156	2025	5	4	4	0	White	0	3	2	5	4
349	0	Q5	Automatic	new	30798	387	2024	4.7	4	2	0	Black	0	7	1	5	2
350	0	Niro	Automatic	new	28247	337	2025	4	4	4	0	Gray	0	4	3	5	5
351	79452	Sentra	Manual	used	18450	74	2010	1.3	4	5	1	Green	0	10	3	5	1
352	0	EQC	Manual	new	46503	375	2025	3.1	2	4	0	Silver	0	6	1	4	3
353	0	Corolla	Manual	new	40570	150	2025	1.1	4	5	0	Gray	0	9	2	3	4
354	0	Equinox	Automatic	new	76368	213	2025	1.9	4	7	0	Gray	0	2	4	2	1
355	45042	Sonata	Manual	used	74132	238	2012	2.8	2	4	3	Gray	0	8	4	2	3
356	0	Malibu	Manual	new	79719	144	2025	3.6	2	5	0	Red	0	2	3	1	3
357	12728	Mustang	Manual	used	77477	225	2009	2.8	4	4	3	Green	0	1	2	2	1
358	0	5 Series	Automatic	new	30009	83	2025	2.4	4	4	0	Silver	0	5	3	1	5
359	41048	Accord	Automatic	used	29707	279	2020	4.1	2	5	2	White	0	3	3	2	4
360	0	A4	Manual	new	71340	196	2025	2.7	2	7	0	Gray	0	7	4	3	5
361	0	Sentra	Automatic	new	72055	195	2025	3.1	4	2	0	Silver	0	10	4	4	3
362	84837	Camry	Manual	used	25821	220	2019	3.5	2	4	2	White	0	9	2	4	1
363	0	Cruze	Manual	new	36024	82	2024	1.7	2	7	0	Red	0	2	4	3	2
364	0	3 Series	Manual	new	20544	266	2024	3.9	2	7	0	Silver	0	5	4	4	1
365	0	X3	Automatic	new	64995	96	2024	2.7	4	7	0	Black	0	5	3	2	1
366	0	5 Series	Manual	new	47345	325	2025	3.2	2	7	0	Blue	0	5	1	2	3
367	162605	Niro	Automatic	used	72340	212	2019	3.5	2	2	1	Blue	0	4	1	2	1
368	0	Civic	Manual	new	74825	95	2024	1.4	2	4	0	Gray	0	3	2	3	3
369	14395	Altima	Manual	used	35983	264	2023	4.3	4	2	2	Black	0	10	1	4	4
370	142532	Explorer	Automatic	used	54783	125	2021	3.3	2	7	2	Gray	0	1	3	1	2
371	168379	Tucson	Automatic	used	54928	324	2021	3.1	4	7	3	Green	0	8	2	2	3
372	0	Q5	Automatic	new	45217	130	2024	3.9	2	7	0	White	0	7	1	5	2
373	0	Accord	Manual	new	66362	227	2024	2.2	4	2	0	Red	0	3	2	3	2
374	0	Elantra	Manual	new	74948	315	2024	4.7	2	4	0	White	0	8	2	2	5
375	19685	Equinox	Manual	used	51086	79	2018	1.8	4	5	3	Red	0	2	2	2	2
376	154679	RAV4	Automatic	used	53687	227	2022	3.8	4	2	1	Black	0	9	4	4	1
377	61659	Optima	Automatic	used	22295	89	2019	4.1	2	7	2	Silver	0	4	2	5	5
378	0	Malibu	Manual	new	65409	143	2025	4.1	2	4	0	Blue	0	2	4	5	5
379	0	Elantra	Automatic	new	36663	93	2025	1.4	4	2	0	Silver	0	8	1	3	4
380	0	Accord	Manual	new	65231	130	2025	2.1	2	5	0	Red	0	3	2	5	3
381	0	Cruze	Manual	new	24201	215	2025	3.3	2	2	0	Black	0	2	2	1	2
382	0	Bolt	Manual	new	73714	95	2024	1.4	2	2	0	White	0	2	1	4	4
383	56943	Leaf	Manual	used	51906	117	2014	4.3	4	2	2	White	0	10	1	3	5
384	0	Optima	Manual	new	40485	239	2024	4.2	4	7	0	White	0	4	2	5	1
385	49774	Rio	Manual	used	54288	135	2020	3	4	2	2	Black	0	4	2	1	1
386	67541	EQC	Automatic	used	78302	266	2023	1.3	2	7	2	Green	0	6	3	4	3
387	0	Accord	Automatic	new	53490	307	2024	2.3	2	7	0	Blue	0	3	4	3	5
388	174080	Focus	Automatic	used	29144	141	2015	4.5	2	4	2	Gray	0	1	1	2	5
389	56292	Equinox	Manual	used	34482	225	2023	4.7	4	5	2	Red	0	2	3	1	1
390	0	Leaf	Manual	new	73569	97	2025	1	4	2	0	Green	0	10	1	3	1
391	105346	e-tron	Manual	used	43287	178	2015	3.6	4	4	3	Blue	0	7	4	1	5
392	0	Insight	Automatic	new	15754	78	2025	1.6	4	7	0	Blue	0	3	3	5	4
393	138540	Ioniq	Manual	used	40006	185	2010	1.7	2	7	2	Green	0	8	4	2	3
394	153937	EQC	Manual	used	22355	316	2006	4.8	2	4	1	Gray	0	6	4	1	2
395	0	Rio	Automatic	new	59464	346	2024	4.2	4	2	0	Black	0	4	4	1	1
396	91904	Niro	Manual	used	77437	220	2023	2.2	2	5	3	Gray	0	4	4	1	2
397	0	Prius	Automatic	new	33643	112	2024	1.5	2	5	0	Black	0	9	2	2	3
398	34242	GLC	Automatic	used	57845	259	2005	4.2	4	4	3	White	0	6	3	2	3
399	0	RAV4	Manual	new	63929	281	2024	4.1	2	7	0	Gray	0	9	3	2	4
400	0	Rogue	Automatic	new	25894	274	2025	2.9	4	4	0	White	0	10	1	4	5
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

SELECT pg_catalog.setval('public.car_id_seq', 400, true);


--
-- Name: car_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.car_image_id_seq', 400, true);


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

SELECT pg_catalog.setval('public.review_id_seq', 1, false);


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

