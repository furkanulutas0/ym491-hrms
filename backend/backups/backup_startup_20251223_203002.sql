--
-- PostgreSQL database dump
--

\restrict ZfIPQ8gSxn29riODs4Na2PKu2BTrmb0fSFxMnUj1eoFa8cJ4VAecE6BacNwkNpd

-- Dumped from database version 15.15
-- Dumped by pg_dump version 15.15 (Debian 15.15-1.pgdg13+1)

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
-- Name: userrole; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.userrole AS ENUM (
    'ADMIN',
    'USER'
);


ALTER TYPE public.userrole OWNER TO "user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: candidate_additional_info; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_additional_info (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    driving_license character varying(50),
    military_status character varying(100),
    availability character varying(100),
    willing_to_relocate boolean DEFAULT false,
    willing_to_travel boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_additional_info OWNER TO "user";

--
-- Name: candidate_additional_info_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_additional_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_additional_info_id_seq OWNER TO "user";

--
-- Name: candidate_additional_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_additional_info_id_seq OWNED BY public.candidate_additional_info.id;


--
-- Name: candidate_addresses; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_addresses (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    address_type character varying(50) DEFAULT 'primary'::character varying,
    country character varying(100),
    city character varying(100),
    street text,
    postal_code character varying(20),
    is_current boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_addresses OWNER TO "user";

--
-- Name: candidate_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_addresses_id_seq OWNER TO "user";

--
-- Name: candidate_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_addresses_id_seq OWNED BY public.candidate_addresses.id;


--
-- Name: candidate_awards; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_awards (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    award_name character varying(200) NOT NULL,
    issuer character varying(200),
    award_date date,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_awards OWNER TO "user";

--
-- Name: candidate_awards_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_awards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_awards_id_seq OWNER TO "user";

--
-- Name: candidate_awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_awards_id_seq OWNED BY public.candidate_awards.id;


--
-- Name: candidate_certifications; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_certifications (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    certification_name character varying(200) NOT NULL,
    issuing_organization character varying(200),
    issue_date date,
    expiration_date date,
    credential_id character varying(150),
    credential_url character varying(255),
    does_not_expire boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_certifications OWNER TO "user";

--
-- Name: candidate_certifications_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_certifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_certifications_id_seq OWNER TO "user";

--
-- Name: candidate_certifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_certifications_id_seq OWNED BY public.candidate_certifications.id;


--
-- Name: candidate_education; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_education (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    institution character varying(200) NOT NULL,
    degree character varying(150),
    field_of_study character varying(150),
    gpa character varying(20),
    start_date date,
    end_date date,
    is_current boolean DEFAULT false,
    thesis text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_education OWNER TO "user";

--
-- Name: TABLE candidate_education; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.candidate_education IS 'Education history for candidates';


--
-- Name: candidate_education_courses; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_education_courses (
    id integer NOT NULL,
    education_id integer NOT NULL,
    course_name character varying(200) NOT NULL
);


ALTER TABLE public.candidate_education_courses OWNER TO "user";

--
-- Name: candidate_education_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_education_courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_education_courses_id_seq OWNER TO "user";

--
-- Name: candidate_education_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_education_courses_id_seq OWNED BY public.candidate_education_courses.id;


--
-- Name: candidate_education_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_education_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_education_id_seq OWNER TO "user";

--
-- Name: candidate_education_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_education_id_seq OWNED BY public.candidate_education.id;


--
-- Name: candidate_hobbies; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_hobbies (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    hobby character varying(150) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.candidate_hobbies OWNER TO "user";

--
-- Name: candidate_hobbies_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_hobbies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_hobbies_id_seq OWNER TO "user";

--
-- Name: candidate_hobbies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_hobbies_id_seq OWNED BY public.candidate_hobbies.id;


--
-- Name: candidate_languages; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_languages (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    language character varying(100) NOT NULL,
    proficiency character varying(50),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_languages OWNER TO "user";

--
-- Name: candidate_languages_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_languages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_languages_id_seq OWNER TO "user";

--
-- Name: candidate_languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_languages_id_seq OWNED BY public.candidate_languages.id;


--
-- Name: candidate_personal_info; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_personal_info (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    birth_date date,
    gender character varying(20),
    nationality character varying(100),
    email character varying(255),
    phone character varying(50),
    website character varying(255),
    linkedin_url character varying(255),
    github_url character varying(255),
    professional_title character varying(150),
    professional_summary text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_personal_info OWNER TO "user";

--
-- Name: TABLE candidate_personal_info; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.candidate_personal_info IS 'Detailed personal information for candidates';


--
-- Name: candidate_personal_info_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_personal_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_personal_info_id_seq OWNER TO "user";

--
-- Name: candidate_personal_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_personal_info_id_seq OWNED BY public.candidate_personal_info.id;


--
-- Name: candidate_project_achievements; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_project_achievements (
    id integer NOT NULL,
    project_id integer NOT NULL,
    achievement text NOT NULL
);


ALTER TABLE public.candidate_project_achievements OWNER TO "user";

--
-- Name: candidate_project_achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_project_achievements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_project_achievements_id_seq OWNER TO "user";

--
-- Name: candidate_project_achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_project_achievements_id_seq OWNED BY public.candidate_project_achievements.id;


--
-- Name: candidate_project_links; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_project_links (
    id integer NOT NULL,
    project_id integer NOT NULL,
    url character varying(255) NOT NULL,
    link_type character varying(50)
);


ALTER TABLE public.candidate_project_links OWNER TO "user";

--
-- Name: candidate_project_links_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_project_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_project_links_id_seq OWNER TO "user";

--
-- Name: candidate_project_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_project_links_id_seq OWNED BY public.candidate_project_links.id;


--
-- Name: candidate_project_technologies; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_project_technologies (
    id integer NOT NULL,
    project_id integer NOT NULL,
    technology character varying(100) NOT NULL
);


ALTER TABLE public.candidate_project_technologies OWNER TO "user";

--
-- Name: candidate_project_technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_project_technologies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_project_technologies_id_seq OWNER TO "user";

--
-- Name: candidate_project_technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_project_technologies_id_seq OWNED BY public.candidate_project_technologies.id;


--
-- Name: candidate_projects; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_projects (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    project_name character varying(200) NOT NULL,
    description text,
    role character varying(150),
    start_date date,
    end_date date,
    is_current boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_projects OWNER TO "user";

--
-- Name: TABLE candidate_projects; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.candidate_projects IS 'Projects worked on by candidates';


--
-- Name: candidate_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_projects_id_seq OWNER TO "user";

--
-- Name: candidate_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_projects_id_seq OWNED BY public.candidate_projects.id;


--
-- Name: candidate_publications; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_publications (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    title character varying(300) NOT NULL,
    publication_type character varying(100),
    publisher character varying(200),
    publication_date date,
    url character varying(255),
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_publications OWNER TO "user";

--
-- Name: candidate_publications_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_publications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_publications_id_seq OWNER TO "user";

--
-- Name: candidate_publications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_publications_id_seq OWNED BY public.candidate_publications.id;


--
-- Name: candidate_raw_data; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_raw_data (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    raw_structured_data jsonb,
    n8n_response jsonb,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.candidate_raw_data OWNER TO "user";

--
-- Name: TABLE candidate_raw_data; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.candidate_raw_data IS 'Stores original n8n response and raw structured data for reference';


--
-- Name: candidate_raw_data_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_raw_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_raw_data_id_seq OWNER TO "user";

--
-- Name: candidate_raw_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_raw_data_id_seq OWNED BY public.candidate_raw_data.id;


--
-- Name: candidate_soft_skills; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_soft_skills (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    skill_name character varying(100) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.candidate_soft_skills OWNER TO "user";

--
-- Name: candidate_soft_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_soft_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_soft_skills_id_seq OWNER TO "user";

--
-- Name: candidate_soft_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_soft_skills_id_seq OWNED BY public.candidate_soft_skills.id;


--
-- Name: candidate_technical_skills; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_technical_skills (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    skill_category_id integer,
    skill_name character varying(150) NOT NULL,
    proficiency_level character varying(50),
    years_of_experience numeric(4,1),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_technical_skills OWNER TO "user";

--
-- Name: candidate_technical_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_technical_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_technical_skills_id_seq OWNER TO "user";

--
-- Name: candidate_technical_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_technical_skills_id_seq OWNED BY public.candidate_technical_skills.id;


--
-- Name: candidate_volunteering; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_volunteering (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    role character varying(150) NOT NULL,
    organization character varying(200) NOT NULL,
    start_date date,
    end_date date,
    is_current boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_volunteering OWNER TO "user";

--
-- Name: candidate_volunteering_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_volunteering_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_volunteering_id_seq OWNER TO "user";

--
-- Name: candidate_volunteering_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_volunteering_id_seq OWNED BY public.candidate_volunteering.id;


--
-- Name: candidate_volunteering_responsibilities; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_volunteering_responsibilities (
    id integer NOT NULL,
    volunteering_id integer NOT NULL,
    responsibility text NOT NULL
);


ALTER TABLE public.candidate_volunteering_responsibilities OWNER TO "user";

--
-- Name: candidate_volunteering_responsibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_volunteering_responsibilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_volunteering_responsibilities_id_seq OWNER TO "user";

--
-- Name: candidate_volunteering_responsibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_volunteering_responsibilities_id_seq OWNED BY public.candidate_volunteering_responsibilities.id;


--
-- Name: candidate_work_experience; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_work_experience (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    job_title character varying(150) NOT NULL,
    company character varying(200) NOT NULL,
    employment_type character varying(50),
    country character varying(100),
    city character varying(100),
    start_date date NOT NULL,
    end_date date,
    is_current boolean DEFAULT false,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidate_work_experience OWNER TO "user";

--
-- Name: TABLE candidate_work_experience; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.candidate_work_experience IS 'Work experience history for candidates';


--
-- Name: candidate_work_experience_achievements; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_work_experience_achievements (
    id integer NOT NULL,
    work_experience_id integer NOT NULL,
    achievement text NOT NULL,
    display_order integer DEFAULT 0
);


ALTER TABLE public.candidate_work_experience_achievements OWNER TO "user";

--
-- Name: candidate_work_experience_achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_work_experience_achievements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_work_experience_achievements_id_seq OWNER TO "user";

--
-- Name: candidate_work_experience_achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_work_experience_achievements_id_seq OWNED BY public.candidate_work_experience_achievements.id;


--
-- Name: candidate_work_experience_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_work_experience_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_work_experience_id_seq OWNER TO "user";

--
-- Name: candidate_work_experience_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_work_experience_id_seq OWNED BY public.candidate_work_experience.id;


--
-- Name: candidate_work_experience_responsibilities; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_work_experience_responsibilities (
    id integer NOT NULL,
    work_experience_id integer NOT NULL,
    responsibility text NOT NULL,
    display_order integer DEFAULT 0
);


ALTER TABLE public.candidate_work_experience_responsibilities OWNER TO "user";

--
-- Name: candidate_work_experience_responsibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_work_experience_responsibilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_work_experience_responsibilities_id_seq OWNER TO "user";

--
-- Name: candidate_work_experience_responsibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_work_experience_responsibilities_id_seq OWNED BY public.candidate_work_experience_responsibilities.id;


--
-- Name: candidate_work_experience_technologies; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidate_work_experience_technologies (
    id integer NOT NULL,
    work_experience_id integer NOT NULL,
    technology character varying(100) NOT NULL
);


ALTER TABLE public.candidate_work_experience_technologies OWNER TO "user";

--
-- Name: candidate_work_experience_technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidate_work_experience_technologies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidate_work_experience_technologies_id_seq OWNER TO "user";

--
-- Name: candidate_work_experience_technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidate_work_experience_technologies_id_seq OWNED BY public.candidate_work_experience_technologies.id;


--
-- Name: candidates; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.candidates (
    id integer NOT NULL,
    candidate_id character varying(50) NOT NULL,
    full_name character varying(200) NOT NULL,
    email character varying(255),
    phone character varying(50),
    original_filename character varying(255),
    file_url character varying(500),
    source character varying(100) DEFAULT 'CV Upload - AI Parsed'::character varying,
    completeness_score integer DEFAULT 0,
    profile_status character varying(50) DEFAULT 'Complete'::character varying,
    total_experience_years numeric(4,1) DEFAULT 0,
    current_position character varying(200),
    current_company character varying(200),
    highest_degree character varying(100),
    field_of_study character varying(150),
    institution character varying(200),
    certifications_count integer DEFAULT 0,
    projects_count integer DEFAULT 0,
    volunteering_count integer DEFAULT 0,
    "timestamp" timestamp with time zone DEFAULT now(),
    processed_date timestamp with time zone DEFAULT now(),
    last_updated timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.candidates OWNER TO "user";

--
-- Name: TABLE candidates; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.candidates IS 'Main table storing candidate basic information from analyzed CVs';


--
-- Name: candidates_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.candidates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.candidates_id_seq OWNER TO "user";

--
-- Name: candidates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.candidates_id_seq OWNED BY public.candidates.id;


--
-- Name: education_courses; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.education_courses (
    id integer NOT NULL,
    education_id integer NOT NULL,
    course_name character varying(200) NOT NULL,
    display_order integer DEFAULT 0
);


ALTER TABLE public.education_courses OWNER TO "user";

--
-- Name: education_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.education_courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.education_courses_id_seq OWNER TO "user";

--
-- Name: education_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.education_courses_id_seq OWNED BY public.education_courses.id;


--
-- Name: employee_additional_info; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_additional_info (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    driving_license character varying(50),
    military_status character varying(100),
    availability character varying(100),
    willing_to_relocate boolean DEFAULT false,
    willing_to_travel boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_additional_info OWNER TO "user";

--
-- Name: employee_additional_info_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_additional_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_additional_info_id_seq OWNER TO "user";

--
-- Name: employee_additional_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_additional_info_id_seq OWNED BY public.employee_additional_info.id;


--
-- Name: employee_addresses; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_addresses (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    address_type character varying(50) DEFAULT 'primary'::character varying,
    country character varying(100),
    city character varying(100),
    street text,
    postal_code character varying(20),
    is_current boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_addresses OWNER TO "user";

--
-- Name: employee_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_addresses_id_seq OWNER TO "user";

--
-- Name: employee_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_addresses_id_seq OWNED BY public.employee_addresses.id;


--
-- Name: employee_awards; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_awards (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    award_name character varying(200) NOT NULL,
    issuer character varying(200),
    award_date date,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_awards OWNER TO "user";

--
-- Name: employee_awards_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_awards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_awards_id_seq OWNER TO "user";

--
-- Name: employee_awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_awards_id_seq OWNED BY public.employee_awards.id;


--
-- Name: employee_certifications; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_certifications (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    certification_name character varying(200) NOT NULL,
    issuing_organization character varying(200),
    issue_date date,
    expiration_date date,
    credential_id character varying(150),
    credential_url character varying(255),
    does_not_expire boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_certifications OWNER TO "user";

--
-- Name: employee_certifications_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_certifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_certifications_id_seq OWNER TO "user";

--
-- Name: employee_certifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_certifications_id_seq OWNED BY public.employee_certifications.id;


--
-- Name: employee_education; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_education (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    institution character varying(200) NOT NULL,
    degree character varying(150),
    field_of_study character varying(150),
    gpa character varying(20),
    start_date date,
    end_date date,
    is_current boolean DEFAULT false,
    thesis text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_education OWNER TO "user";

--
-- Name: employee_education_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_education_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_education_id_seq OWNER TO "user";

--
-- Name: employee_education_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_education_id_seq OWNED BY public.employee_education.id;


--
-- Name: employee_hobbies; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_hobbies (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    hobby character varying(150) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.employee_hobbies OWNER TO "user";

--
-- Name: employee_hobbies_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_hobbies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_hobbies_id_seq OWNER TO "user";

--
-- Name: employee_hobbies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_hobbies_id_seq OWNED BY public.employee_hobbies.id;


--
-- Name: employee_languages; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_languages (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    language character varying(100) NOT NULL,
    proficiency character varying(50),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_languages OWNER TO "user";

--
-- Name: employee_languages_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_languages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_languages_id_seq OWNER TO "user";

--
-- Name: employee_languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_languages_id_seq OWNED BY public.employee_languages.id;


--
-- Name: employee_personal_info; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_personal_info (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    birth_date date,
    gender character varying(20),
    nationality character varying(100),
    email character varying(255),
    phone character varying(50),
    website character varying(255),
    linkedin_url character varying(255),
    github_url character varying(255),
    professional_title character varying(150),
    professional_summary text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_personal_info OWNER TO "user";

--
-- Name: employee_personal_info_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_personal_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_personal_info_id_seq OWNER TO "user";

--
-- Name: employee_personal_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_personal_info_id_seq OWNED BY public.employee_personal_info.id;


--
-- Name: employee_projects; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_projects (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    project_name character varying(200) NOT NULL,
    description text,
    role character varying(150),
    start_date date,
    end_date date,
    is_current boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_projects OWNER TO "user";

--
-- Name: employee_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_projects_id_seq OWNER TO "user";

--
-- Name: employee_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_projects_id_seq OWNED BY public.employee_projects.id;


--
-- Name: employee_publications; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_publications (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    title character varying(300) NOT NULL,
    publication_type character varying(100),
    publisher character varying(200),
    publication_date date,
    url character varying(255),
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_publications OWNER TO "user";

--
-- Name: employee_publications_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_publications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_publications_id_seq OWNER TO "user";

--
-- Name: employee_publications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_publications_id_seq OWNED BY public.employee_publications.id;


--
-- Name: employee_soft_skills; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_soft_skills (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    skill_name character varying(100) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.employee_soft_skills OWNER TO "user";

--
-- Name: employee_soft_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_soft_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_soft_skills_id_seq OWNER TO "user";

--
-- Name: employee_soft_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_soft_skills_id_seq OWNED BY public.employee_soft_skills.id;


--
-- Name: employee_technical_skills; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_technical_skills (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    skill_category_id integer,
    skill_name character varying(150) NOT NULL,
    proficiency_level character varying(50),
    years_of_experience numeric(4,1),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_technical_skills OWNER TO "user";

--
-- Name: employee_technical_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_technical_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_technical_skills_id_seq OWNER TO "user";

--
-- Name: employee_technical_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_technical_skills_id_seq OWNED BY public.employee_technical_skills.id;


--
-- Name: employee_volunteering; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_volunteering (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    role character varying(150) NOT NULL,
    organization character varying(200) NOT NULL,
    start_date date,
    end_date date,
    is_current boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_volunteering OWNER TO "user";

--
-- Name: employee_volunteering_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_volunteering_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_volunteering_id_seq OWNER TO "user";

--
-- Name: employee_volunteering_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_volunteering_id_seq OWNED BY public.employee_volunteering.id;


--
-- Name: employee_work_experience; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employee_work_experience (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    job_title character varying(150) NOT NULL,
    company character varying(200) NOT NULL,
    employment_type character varying(50),
    country character varying(100),
    city character varying(100),
    start_date date NOT NULL,
    end_date date,
    is_current boolean DEFAULT false,
    description text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employee_work_experience OWNER TO "user";

--
-- Name: employee_work_experience_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employee_work_experience_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_work_experience_id_seq OWNER TO "user";

--
-- Name: employee_work_experience_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employee_work_experience_id_seq OWNED BY public.employee_work_experience.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.employees (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    title character varying(100),
    department character varying(100),
    hire_date timestamp without time zone,
    salary integer,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.employees OWNER TO "user";

--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employees_id_seq OWNER TO "user";

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: job_application_notes; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.job_application_notes (
    id integer NOT NULL,
    application_id integer NOT NULL,
    author_id integer NOT NULL,
    note text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.job_application_notes OWNER TO "user";

--
-- Name: job_application_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.job_application_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_application_notes_id_seq OWNER TO "user";

--
-- Name: job_application_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.job_application_notes_id_seq OWNED BY public.job_application_notes.id;


--
-- Name: job_applications; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.job_applications (
    id integer NOT NULL,
    job_posting_id integer NOT NULL,
    candidate_name character varying(150) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(50),
    resume_url character varying(500),
    cover_letter text,
    portfolio_url character varying(500),
    linkedin_url character varying(500),
    source character varying(100),
    status character varying(50) DEFAULT 'New'::character varying NOT NULL,
    applied_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    pipeline_stage character varying(50) DEFAULT 'applied'::character varying NOT NULL,
    pipeline_stage_updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    ai_review_result json,
    ai_review_score integer,
    exam_assigned boolean DEFAULT false,
    exam_platform_id character varying(255),
    exam_completed_at timestamp with time zone,
    exam_score integer,
    ai_interview_scheduled_at timestamp with time zone,
    ai_interview_completed_at timestamp with time zone,
    ai_interview_type character varying(20),
    documents_required json,
    documents_submitted json,
    proposal_sent_at timestamp with time zone,
    proposal_accepted boolean,
    candidate_id character varying(50)
);


ALTER TABLE public.job_applications OWNER TO "user";

--
-- Name: COLUMN job_applications.candidate_id; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON COLUMN public.job_applications.candidate_id IS 'Reference to candidate ID in candidates table for full CV data';


--
-- Name: job_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.job_applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_applications_id_seq OWNER TO "user";

--
-- Name: job_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.job_applications_id_seq OWNED BY public.job_applications.id;


--
-- Name: job_posting_activities; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.job_posting_activities (
    id integer NOT NULL,
    job_posting_id integer NOT NULL,
    actor_id integer,
    action_type character varying(100) NOT NULL,
    details text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.job_posting_activities OWNER TO "user";

--
-- Name: job_posting_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.job_posting_activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_posting_activities_id_seq OWNER TO "user";

--
-- Name: job_posting_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.job_posting_activities_id_seq OWNED BY public.job_posting_activities.id;


--
-- Name: job_posting_daily_stats; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.job_posting_daily_stats (
    id integer NOT NULL,
    job_posting_id integer NOT NULL,
    date date NOT NULL,
    views_count integer DEFAULT 0,
    applications_count integer DEFAULT 0
);


ALTER TABLE public.job_posting_daily_stats OWNER TO "user";

--
-- Name: job_posting_daily_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.job_posting_daily_stats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_posting_daily_stats_id_seq OWNER TO "user";

--
-- Name: job_posting_daily_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.job_posting_daily_stats_id_seq OWNED BY public.job_posting_daily_stats.id;


--
-- Name: job_posting_notes; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.job_posting_notes (
    id integer NOT NULL,
    job_posting_id integer NOT NULL,
    author_id integer NOT NULL,
    note text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.job_posting_notes OWNER TO "user";

--
-- Name: job_posting_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.job_posting_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_posting_notes_id_seq OWNER TO "user";

--
-- Name: job_posting_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.job_posting_notes_id_seq OWNED BY public.job_posting_notes.id;


--
-- Name: job_postings; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.job_postings (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    department character varying(100),
    location character varying(100),
    work_type character varying(50),
    status character varying(50) DEFAULT 'Draft'::character varying NOT NULL,
    description text,
    responsibilities text[],
    requirements text[],
    benefits text[],
    salary_range_min integer,
    salary_range_max integer,
    salary_currency character varying(10) DEFAULT 'USD'::character varying,
    posting_date timestamp with time zone DEFAULT now(),
    expiration_date timestamp with time zone,
    created_by integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.job_postings OWNER TO "user";

--
-- Name: job_postings_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.job_postings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_postings_id_seq OWNER TO "user";

--
-- Name: job_postings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.job_postings_id_seq OWNED BY public.job_postings.id;


--
-- Name: project_achievements; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.project_achievements (
    id integer NOT NULL,
    project_id integer NOT NULL,
    achievement text NOT NULL,
    display_order integer DEFAULT 0
);


ALTER TABLE public.project_achievements OWNER TO "user";

--
-- Name: project_achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.project_achievements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_achievements_id_seq OWNER TO "user";

--
-- Name: project_achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.project_achievements_id_seq OWNED BY public.project_achievements.id;


--
-- Name: project_links; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.project_links (
    id integer NOT NULL,
    project_id integer NOT NULL,
    link_url character varying(255) NOT NULL,
    link_type character varying(50)
);


ALTER TABLE public.project_links OWNER TO "user";

--
-- Name: project_links_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.project_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_links_id_seq OWNER TO "user";

--
-- Name: project_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.project_links_id_seq OWNED BY public.project_links.id;


--
-- Name: project_technologies; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.project_technologies (
    id integer NOT NULL,
    project_id integer NOT NULL,
    technology character varying(100) NOT NULL
);


ALTER TABLE public.project_technologies OWNER TO "user";

--
-- Name: project_technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.project_technologies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_technologies_id_seq OWNER TO "user";

--
-- Name: project_technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.project_technologies_id_seq OWNED BY public.project_technologies.id;


--
-- Name: skill_categories; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.skill_categories (
    id integer NOT NULL,
    category_name character varying(100) NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.skill_categories OWNER TO "user";

--
-- Name: skill_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.skill_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skill_categories_id_seq OWNER TO "user";

--
-- Name: skill_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.skill_categories_id_seq OWNED BY public.skill_categories.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying NOT NULL,
    hashed_password character varying NOT NULL,
    full_name character varying,
    is_active boolean DEFAULT true,
    role character varying DEFAULT 'user'::character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO "user";

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO "user";

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: volunteering_responsibilities; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.volunteering_responsibilities (
    id integer NOT NULL,
    volunteering_id integer NOT NULL,
    responsibility text NOT NULL,
    display_order integer DEFAULT 0
);


ALTER TABLE public.volunteering_responsibilities OWNER TO "user";

--
-- Name: volunteering_responsibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.volunteering_responsibilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteering_responsibilities_id_seq OWNER TO "user";

--
-- Name: volunteering_responsibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.volunteering_responsibilities_id_seq OWNED BY public.volunteering_responsibilities.id;


--
-- Name: work_experience_achievements; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.work_experience_achievements (
    id integer NOT NULL,
    work_experience_id integer NOT NULL,
    achievement text NOT NULL,
    display_order integer DEFAULT 0
);


ALTER TABLE public.work_experience_achievements OWNER TO "user";

--
-- Name: work_experience_achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.work_experience_achievements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_experience_achievements_id_seq OWNER TO "user";

--
-- Name: work_experience_achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.work_experience_achievements_id_seq OWNED BY public.work_experience_achievements.id;


--
-- Name: work_experience_responsibilities; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.work_experience_responsibilities (
    id integer NOT NULL,
    work_experience_id integer NOT NULL,
    responsibility text NOT NULL,
    display_order integer DEFAULT 0
);


ALTER TABLE public.work_experience_responsibilities OWNER TO "user";

--
-- Name: work_experience_responsibilities_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.work_experience_responsibilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_experience_responsibilities_id_seq OWNER TO "user";

--
-- Name: work_experience_responsibilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.work_experience_responsibilities_id_seq OWNED BY public.work_experience_responsibilities.id;


--
-- Name: work_experience_technologies; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.work_experience_technologies (
    id integer NOT NULL,
    work_experience_id integer NOT NULL,
    technology character varying(100) NOT NULL
);


ALTER TABLE public.work_experience_technologies OWNER TO "user";

--
-- Name: work_experience_technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.work_experience_technologies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_experience_technologies_id_seq OWNER TO "user";

--
-- Name: work_experience_technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.work_experience_technologies_id_seq OWNED BY public.work_experience_technologies.id;


--
-- Name: candidate_additional_info id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_additional_info ALTER COLUMN id SET DEFAULT nextval('public.candidate_additional_info_id_seq'::regclass);


--
-- Name: candidate_addresses id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_addresses ALTER COLUMN id SET DEFAULT nextval('public.candidate_addresses_id_seq'::regclass);


--
-- Name: candidate_awards id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_awards ALTER COLUMN id SET DEFAULT nextval('public.candidate_awards_id_seq'::regclass);


--
-- Name: candidate_certifications id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_certifications ALTER COLUMN id SET DEFAULT nextval('public.candidate_certifications_id_seq'::regclass);


--
-- Name: candidate_education id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_education ALTER COLUMN id SET DEFAULT nextval('public.candidate_education_id_seq'::regclass);


--
-- Name: candidate_education_courses id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_education_courses ALTER COLUMN id SET DEFAULT nextval('public.candidate_education_courses_id_seq'::regclass);


--
-- Name: candidate_hobbies id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_hobbies ALTER COLUMN id SET DEFAULT nextval('public.candidate_hobbies_id_seq'::regclass);


--
-- Name: candidate_languages id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_languages ALTER COLUMN id SET DEFAULT nextval('public.candidate_languages_id_seq'::regclass);


--
-- Name: candidate_personal_info id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_personal_info ALTER COLUMN id SET DEFAULT nextval('public.candidate_personal_info_id_seq'::regclass);


--
-- Name: candidate_project_achievements id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_project_achievements ALTER COLUMN id SET DEFAULT nextval('public.candidate_project_achievements_id_seq'::regclass);


--
-- Name: candidate_project_links id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_project_links ALTER COLUMN id SET DEFAULT nextval('public.candidate_project_links_id_seq'::regclass);


--
-- Name: candidate_project_technologies id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_project_technologies ALTER COLUMN id SET DEFAULT nextval('public.candidate_project_technologies_id_seq'::regclass);


--
-- Name: candidate_projects id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_projects ALTER COLUMN id SET DEFAULT nextval('public.candidate_projects_id_seq'::regclass);


--
-- Name: candidate_publications id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_publications ALTER COLUMN id SET DEFAULT nextval('public.candidate_publications_id_seq'::regclass);


--
-- Name: candidate_raw_data id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_raw_data ALTER COLUMN id SET DEFAULT nextval('public.candidate_raw_data_id_seq'::regclass);


--
-- Name: candidate_soft_skills id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_soft_skills ALTER COLUMN id SET DEFAULT nextval('public.candidate_soft_skills_id_seq'::regclass);


--
-- Name: candidate_technical_skills id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_technical_skills ALTER COLUMN id SET DEFAULT nextval('public.candidate_technical_skills_id_seq'::regclass);


--
-- Name: candidate_volunteering id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_volunteering ALTER COLUMN id SET DEFAULT nextval('public.candidate_volunteering_id_seq'::regclass);


--
-- Name: candidate_volunteering_responsibilities id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_volunteering_responsibilities ALTER COLUMN id SET DEFAULT nextval('public.candidate_volunteering_responsibilities_id_seq'::regclass);


--
-- Name: candidate_work_experience id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience ALTER COLUMN id SET DEFAULT nextval('public.candidate_work_experience_id_seq'::regclass);


--
-- Name: candidate_work_experience_achievements id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience_achievements ALTER COLUMN id SET DEFAULT nextval('public.candidate_work_experience_achievements_id_seq'::regclass);


--
-- Name: candidate_work_experience_responsibilities id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience_responsibilities ALTER COLUMN id SET DEFAULT nextval('public.candidate_work_experience_responsibilities_id_seq'::regclass);


--
-- Name: candidate_work_experience_technologies id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience_technologies ALTER COLUMN id SET DEFAULT nextval('public.candidate_work_experience_technologies_id_seq'::regclass);


--
-- Name: candidates id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidates ALTER COLUMN id SET DEFAULT nextval('public.candidates_id_seq'::regclass);


--
-- Name: education_courses id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.education_courses ALTER COLUMN id SET DEFAULT nextval('public.education_courses_id_seq'::regclass);


--
-- Name: employee_additional_info id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_additional_info ALTER COLUMN id SET DEFAULT nextval('public.employee_additional_info_id_seq'::regclass);


--
-- Name: employee_addresses id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_addresses ALTER COLUMN id SET DEFAULT nextval('public.employee_addresses_id_seq'::regclass);


--
-- Name: employee_awards id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_awards ALTER COLUMN id SET DEFAULT nextval('public.employee_awards_id_seq'::regclass);


--
-- Name: employee_certifications id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_certifications ALTER COLUMN id SET DEFAULT nextval('public.employee_certifications_id_seq'::regclass);


--
-- Name: employee_education id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_education ALTER COLUMN id SET DEFAULT nextval('public.employee_education_id_seq'::regclass);


--
-- Name: employee_hobbies id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_hobbies ALTER COLUMN id SET DEFAULT nextval('public.employee_hobbies_id_seq'::regclass);


--
-- Name: employee_languages id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_languages ALTER COLUMN id SET DEFAULT nextval('public.employee_languages_id_seq'::regclass);


--
-- Name: employee_personal_info id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_personal_info ALTER COLUMN id SET DEFAULT nextval('public.employee_personal_info_id_seq'::regclass);


--
-- Name: employee_projects id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_projects ALTER COLUMN id SET DEFAULT nextval('public.employee_projects_id_seq'::regclass);


--
-- Name: employee_publications id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_publications ALTER COLUMN id SET DEFAULT nextval('public.employee_publications_id_seq'::regclass);


--
-- Name: employee_soft_skills id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_soft_skills ALTER COLUMN id SET DEFAULT nextval('public.employee_soft_skills_id_seq'::regclass);


--
-- Name: employee_technical_skills id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_technical_skills ALTER COLUMN id SET DEFAULT nextval('public.employee_technical_skills_id_seq'::regclass);


--
-- Name: employee_volunteering id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_volunteering ALTER COLUMN id SET DEFAULT nextval('public.employee_volunteering_id_seq'::regclass);


--
-- Name: employee_work_experience id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_work_experience ALTER COLUMN id SET DEFAULT nextval('public.employee_work_experience_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: job_application_notes id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_application_notes ALTER COLUMN id SET DEFAULT nextval('public.job_application_notes_id_seq'::regclass);


--
-- Name: job_applications id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_applications ALTER COLUMN id SET DEFAULT nextval('public.job_applications_id_seq'::regclass);


--
-- Name: job_posting_activities id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_activities ALTER COLUMN id SET DEFAULT nextval('public.job_posting_activities_id_seq'::regclass);


--
-- Name: job_posting_daily_stats id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_daily_stats ALTER COLUMN id SET DEFAULT nextval('public.job_posting_daily_stats_id_seq'::regclass);


--
-- Name: job_posting_notes id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_notes ALTER COLUMN id SET DEFAULT nextval('public.job_posting_notes_id_seq'::regclass);


--
-- Name: job_postings id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_postings ALTER COLUMN id SET DEFAULT nextval('public.job_postings_id_seq'::regclass);


--
-- Name: project_achievements id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.project_achievements ALTER COLUMN id SET DEFAULT nextval('public.project_achievements_id_seq'::regclass);


--
-- Name: project_links id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.project_links ALTER COLUMN id SET DEFAULT nextval('public.project_links_id_seq'::regclass);


--
-- Name: project_technologies id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.project_technologies ALTER COLUMN id SET DEFAULT nextval('public.project_technologies_id_seq'::regclass);


--
-- Name: skill_categories id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.skill_categories ALTER COLUMN id SET DEFAULT nextval('public.skill_categories_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: volunteering_responsibilities id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.volunteering_responsibilities ALTER COLUMN id SET DEFAULT nextval('public.volunteering_responsibilities_id_seq'::regclass);


--
-- Name: work_experience_achievements id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.work_experience_achievements ALTER COLUMN id SET DEFAULT nextval('public.work_experience_achievements_id_seq'::regclass);


--
-- Name: work_experience_responsibilities id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.work_experience_responsibilities ALTER COLUMN id SET DEFAULT nextval('public.work_experience_responsibilities_id_seq'::regclass);


--
-- Name: work_experience_technologies id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.work_experience_technologies ALTER COLUMN id SET DEFAULT nextval('public.work_experience_technologies_id_seq'::regclass);


--
-- Data for Name: candidate_additional_info; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_additional_info (id, candidate_id, driving_license, military_status, availability, willing_to_relocate, willing_to_travel, created_at, updated_at) FROM stdin;
1	EMP-TEST-123456	B	Completed	Immediate	t	f	2025-12-19 10:28:09.601007+00	\N
2	EMP-1766141328216				f	f	2025-12-19 12:30:15.325018+00	\N
3	EMP-1766239092988	Class B	Completed	Immediately	t	t	2025-12-20 13:58:10.850979+00	\N
4	EMP-1766239676620	Class B	Completed	Immediately	t	f	2025-12-20 14:07:54.362886+00	\N
5	EMP-1766252302499				f	f	2025-12-20 17:38:20.827172+00	\N
6	EMP-1766254966950				f	f	2025-12-20 18:22:45.100317+00	\N
7	EMP-1766255177864	Class B	Postponed	Immediately	t	f	2025-12-20 18:26:15.919585+00	\N
8	EMP-1766398835588	Class B	Not Applicable	Immediately	t	t	2025-12-22 10:20:33.930098+00	\N
9	EMP-1766436935343				f	f	2025-12-22 20:55:33.328939+00	\N
10	EMP-1766519202434				f	f	2025-12-23 19:46:40.044516+00	\N
11	EMP-1766519616749				f	f	2025-12-23 19:53:34.266207+00	\N
13	EMP-1766519936675				f	f	2025-12-23 19:58:54.584036+00	\N
15	EMP-1766521577842				f	f	2025-12-23 20:26:15.628619+00	\N
\.


--
-- Data for Name: candidate_addresses; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_addresses (id, candidate_id, address_type, country, city, street, postal_code, is_current, created_at, updated_at) FROM stdin;
1	EMP-TEST-123456	primary	Turkey	Istanbul	\N	\N	t	2025-12-19 10:28:09.601007+00	\N
2	EMP-TEST-123456	primary	Turkey	Istanbul	\N	\N	t	2025-12-19 10:28:09.601007+00	\N
3	EMP-1766141328216	primary	Turkey	İstanbul	\N	\N	t	2025-12-19 12:30:15.325018+00	\N
4	EMP-1766141328216	primary	Turkey	İstanbul	Ümraniye		t	2025-12-19 12:30:15.325018+00	\N
5	EMP-1766239092988	primary	Turkiye	Istanbul	\N	\N	t	2025-12-20 13:58:10.850979+00	\N
6	EMP-1766239092988	primary	Turkiye	Istanbul			t	2025-12-20 13:58:10.850979+00	\N
7	EMP-1766239676620	primary	Amerika	Sakarya	\N	\N	t	2025-12-20 14:07:54.362886+00	\N
8	EMP-1766252302499	primary	Turkey	Istanbul	\N	\N	t	2025-12-20 17:38:20.827172+00	\N
9	EMP-1766252302499	primary	Turkey	Istanbul			t	2025-12-20 17:38:20.827172+00	\N
10	EMP-1766254966950	primary	Turkey	Istanbul	\N	\N	t	2025-12-20 18:22:45.100317+00	\N
11	EMP-1766254966950	primary	Turkey	Istanbul			t	2025-12-20 18:22:45.100317+00	\N
12	EMP-1766255177864	primary	Türkiye	İstanbul	\N	\N	t	2025-12-20 18:26:15.919585+00	\N
13	EMP-1766398835588	primary		İstanbul	\N	\N	t	2025-12-22 10:20:33.930098+00	\N
14	EMP-1766398835588	primary		İstanbul	Üsküdar		t	2025-12-22 10:20:33.930098+00	\N
15	EMP-1766436935343	primary	Turkey	İstanbul	\N	\N	t	2025-12-22 20:55:33.328939+00	\N
16	EMP-1766436935343	primary	Turkey	İstanbul	Üsküdar		t	2025-12-22 20:55:33.328939+00	\N
17	EMP-1766519202434	primary	Türkiye	İstanbul	\N	\N	t	2025-12-23 19:46:40.044516+00	\N
18	EMP-1766519202434	primary	Türkiye	İstanbul			t	2025-12-23 19:46:40.044516+00	\N
21	EMP-1766519936675	primary	Turkiye	Istanbul	\N	\N	t	2025-12-23 19:58:54.584036+00	\N
22	EMP-1766519936675	primary	Turkiye	Istanbul			t	2025-12-23 19:58:54.584036+00	\N
25	EMP-1766521577842	primary	Turkiye	Istanbul	\N	\N	t	2025-12-23 20:26:15.628619+00	\N
26	EMP-1766521577842	primary	Turkiye	Istanbul			t	2025-12-23 20:26:15.628619+00	\N
\.


--
-- Data for Name: candidate_awards; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_awards (id, candidate_id, award_name, issuer, award_date, description, created_at, updated_at) FROM stdin;
1	EMP-1766141328216	100% Full Scholarship	Doğuş University	2022-12-19	Awarded based on outstanding academic performance.	2025-12-19 12:30:15.325018+00	\N
2	EMP-1766239676620	National 5th place ranking at Teknofest Finals	Teknofest	\N	Achieved through innovation and teamwork with the LOOP Software & Idea Development Team.	2025-12-20 14:07:54.362886+00	\N
3	EMP-1766255177864	National 5th Place Ranking	Teknofest	\N	Achieved by guiding the LOOP Software & Idea Development Team to the Teknofest Finals through innovation and teamwork.	2025-12-20 18:26:15.919585+00	\N
4	EMP-1766519616749	National 5th Place Ranking	Teknofest Finals	\N	Achieved through innovation and teamwork while guiding the LOOP Software & Idea Development Team.	2025-12-23 19:53:34.266207+00	\N
\.


--
-- Data for Name: candidate_certifications; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_certifications (id, candidate_id, certification_name, issuing_organization, issue_date, expiration_date, credential_id, credential_url, does_not_expire, created_at, updated_at) FROM stdin;
1	EMP-1766239092988			\N	\N			f	2025-12-20 13:58:10.850979+00	\N
2	EMP-1766239092988			\N	\N			f	2025-12-20 13:58:10.850979+00	\N
3	EMP-1766239092988			\N	\N			f	2025-12-20 13:58:10.850979+00	\N
4	EMP-1766239092988			\N	\N			f	2025-12-20 13:58:10.850979+00	\N
5	EMP-1766252302499		Pearson	\N	\N			f	2025-12-20 17:38:20.827172+00	\N
6	EMP-1766252302499		Marmara University (with the support of ITU, ODTU and Boğaziçi)	2025-10-01	2026-04-30			f	2025-12-20 17:38:20.827172+00	\N
7	EMP-1766254966950		Pearson	\N	\N			f	2025-12-20 18:22:45.100317+00	\N
8	EMP-1766254966950		Marmara University (with the support of ITU, ODTU and Boğaziçi)	2025-10-01	2026-04-30			f	2025-12-20 18:22:45.100317+00	\N
9	EMP-1766398835588		Turkcell Geleceği Yazanlar	\N	\N			f	2025-12-22 10:20:33.930098+00	\N
10	EMP-1766398835588		Turkcell Geleceği Yazanlar	\N	\N			f	2025-12-22 10:20:33.930098+00	\N
11	EMP-1766398835588		Doğuş Üniversitesi	\N	\N			f	2025-12-22 10:20:33.930098+00	\N
12	EMP-1766398835588		Cisco	\N	\N			f	2025-12-22 10:20:33.930098+00	\N
13	EMP-1766398835588		Cisco	\N	\N			f	2025-12-22 10:20:33.930098+00	\N
14	EMP-1766398835588		Cisco	\N	\N			f	2025-12-22 10:20:33.930098+00	\N
15	EMP-1766398835588		Cisco	\N	\N			f	2025-12-22 10:20:33.930098+00	\N
16	EMP-1766436935343		Turkcell Geleceği Yazanlar	\N	\N			f	2025-12-22 20:55:33.328939+00	\N
17	EMP-1766436935343		Turkcell Geleceği Yazanlar	\N	\N			f	2025-12-22 20:55:33.328939+00	\N
18	EMP-1766436935343		Cisco	\N	\N			f	2025-12-22 20:55:33.328939+00	\N
19	EMP-1766436935343		Doğuş Üniversitesi	\N	\N			f	2025-12-22 20:55:33.328939+00	\N
20	EMP-1766436935343		Cisco	\N	\N			f	2025-12-22 20:55:33.328939+00	\N
21	EMP-1766436935343		Cisco	\N	\N			f	2025-12-22 20:55:33.328939+00	\N
22	EMP-1766436935343		Cisco	\N	\N			f	2025-12-22 20:55:33.328939+00	\N
23	EMP-1766519202434		Türkcell Geleceği Yazanlar	2023-11-01	\N			f	2025-12-23 19:46:40.044516+00	\N
24	EMP-1766519202434		Türkcell Geleceği Yazanlar	2023-11-01	\N			f	2025-12-23 19:46:40.044516+00	\N
25	EMP-1766519202434		Doğuş Üniversitesi	2023-11-01	\N			f	2025-12-23 19:46:40.044516+00	\N
26	EMP-1766519202434		Cisco	2023-11-01	\N			f	2025-12-23 19:46:40.044516+00	\N
27	EMP-1766519202434		Cisco	2023-11-01	\N			f	2025-12-23 19:46:40.044516+00	\N
28	EMP-1766519202434		Cisco	2023-11-01	\N			f	2025-12-23 19:46:40.044516+00	\N
29	EMP-1766519202434		Cisco	2023-11-01	\N			f	2025-12-23 19:46:40.044516+00	\N
34	EMP-1766519936675			\N	\N			f	2025-12-23 19:58:54.584036+00	\N
35	EMP-1766519936675			\N	\N			f	2025-12-23 19:58:54.584036+00	\N
36	EMP-1766519936675			\N	\N			f	2025-12-23 19:58:54.584036+00	\N
37	EMP-1766519936675			\N	\N			f	2025-12-23 19:58:54.584036+00	\N
42	EMP-1766521577842			\N	\N			f	2025-12-23 20:26:15.628619+00	\N
43	EMP-1766521577842			\N	\N			f	2025-12-23 20:26:15.628619+00	\N
44	EMP-1766521577842			\N	\N			f	2025-12-23 20:26:15.628619+00	\N
45	EMP-1766521577842			\N	\N			f	2025-12-23 20:26:15.628619+00	\N
\.


--
-- Data for Name: candidate_education; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_education (id, candidate_id, institution, degree, field_of_study, gpa, start_date, end_date, is_current, thesis, created_at, updated_at) FROM stdin;
1	EMP-TEST-123456	Test University	Bachelor's	Computer Science	3.8	2015-09-01	2019-06-01	f		2025-12-19 10:28:09.601007+00	\N
2	EMP-1766141328216	Doğuş University	B.Sc.	Computer Engineering		2022-12-19	\N	t		2025-12-19 12:30:15.325018+00	\N
3	EMP-1766239092988	Dogus University	Bachelor of Science	Computer Engineering		2021-09-01	2026-06-01	t		2025-12-20 13:58:10.850979+00	\N
4	EMP-1766239676620	Doğuş University	BSc.	Software Engineering		2022-06-01	2026-06-01	t	Focusing on full-stack development, software architecture, and DevOps practices.	2025-12-20 14:07:54.362886+00	\N
5	EMP-1766239676620	Doğuş University	Program	English Preparation		2021-10-01	2022-06-01	f	Completed an intensive English preparation program, enhancing academic and professional communication skills.	2025-12-20 14:07:54.362886+00	\N
6	EMP-1766252302499	Dogus University	Bachelor's Degree	Computer Engineering (%100 English)		2021-09-01	\N	t		2025-12-20 17:38:20.827172+00	\N
7	EMP-1766252302499	Anadolu University (Second University)	Associate Degree	Web Design and Coding		2021-09-01	2023-06-01	f		2025-12-20 17:38:20.827172+00	\N
8	EMP-1766254966950	Dogus University	Bachelor	Computer Engineering		2021-09-01	2026-06-01	t		2025-12-20 18:22:45.100317+00	\N
9	EMP-1766254966950	Anadolu University	Associate Degree	Web Design and Coding		2021-09-01	2023-06-01	f		2025-12-20 18:22:45.100317+00	\N
10	EMP-1766255177864	Doğuş University	BSc.	Software Engineering		2021-10-01	2026-06-01	t		2025-12-20 18:26:15.919585+00	\N
11	EMP-1766255177864	Doğuş University	Program	English Preparation Program		2021-10-01	2022-06-01	f		2025-12-20 18:26:15.919585+00	\N
12	EMP-1766398835588	Doğuş Üniversitesi		Yazılım Mühendisliği		2023-09-01	\N	t		2025-12-22 10:20:33.930098+00	\N
13	EMP-1766436935343	Doğuş Üniversitesi	Lisans	Yazılım Mühendisliği		\N	\N	t		2025-12-22 20:55:33.328939+00	\N
14	EMP-1766519202434	Doğuş Üniversitesi	Lisans	Yazılım Mühendisliği		2021-09-01	\N	t		2025-12-23 19:46:40.044516+00	\N
15	EMP-1766519616749	Doğuş University	Bachelor's degree	Software Engineering		2022-06-01	2026-06-01	t		2025-12-23 19:53:34.266207+00	\N
16	EMP-1766519616749	Doğuş University	Program Completion	English Language		2021-10-01	2022-06-01	f		2025-12-23 19:53:34.266207+00	\N
18	EMP-1766519936675	Dogus University	Bachelor of Science	Computer Engineering		2021-09-01	2026-06-01	t		2025-12-23 19:58:54.584036+00	\N
20	EMP-1766521577842	Dogus University	Bachelor of Science	Computer Engineering		2021-09-01	2026-06-01	t		2025-12-23 20:26:15.628619+00	\N
\.


--
-- Data for Name: candidate_education_courses; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_education_courses (id, education_id, course_name) FROM stdin;
1	1	Data Structures
2	1	Algorithms
3	1	Database Systems
4	2	Data Structures
5	2	Algorithms
6	2	Operating Systems
7	2	Database Management
8	2	Object-Oriented Programming
9	15	full-stack development
10	15	software architecture
11	15	DevOps practices
\.


--
-- Data for Name: candidate_hobbies; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_hobbies (id, candidate_id, hobby, created_at) FROM stdin;
1	EMP-TEST-123456	Reading	2025-12-19 10:28:09.601007+00
2	EMP-TEST-123456	Coding	2025-12-19 10:28:09.601007+00
3	EMP-1766239092988	aaaa	2025-12-20 13:58:10.850979+00
4	EMP-1766239676620	Abc	2025-12-20 14:07:54.362886+00
5	EMP-1766239676620	bca	2025-12-20 14:07:54.362886+00
6	EMP-1766239676620	dba	2025-12-20 14:07:54.362886+00
7	EMP-1766255177864	aabb	2025-12-20 18:26:15.919585+00
8	EMP-1766255177864	cc	2025-12-20 18:26:15.919585+00
9	EMP-1766255177864	dd	2025-12-20 18:26:15.919585+00
10	EMP-1766398835588	mmmm	2025-12-22 10:20:33.930098+00
\.


--
-- Data for Name: candidate_languages; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_languages (id, candidate_id, language, proficiency, created_at, updated_at) FROM stdin;
1	EMP-TEST-123456	English	Fluent	2025-12-19 10:28:09.601007+00	\N
2	EMP-TEST-123456	Turkish	Native	2025-12-19 10:28:09.601007+00	\N
3	EMP-1766141328216	Turkish	Native	2025-12-19 12:30:15.325018+00	\N
4	EMP-1766141328216	English	B2	2025-12-19 12:30:15.325018+00	\N
5	EMP-1766239092988	Turkish	Native	2025-12-20 13:58:10.850979+00	\N
6	EMP-1766239092988	English	Upper Intermediate	2025-12-20 13:58:10.850979+00	\N
7	EMP-1766239676620	English		2025-12-20 14:07:54.362886+00	\N
8	EMP-1766252302499	English		2025-12-20 17:38:20.827172+00	\N
9	EMP-1766254966950	English		2025-12-20 18:22:45.100317+00	\N
10	EMP-1766398835588	İngilizce	Pre - Intermediate	2025-12-22 10:20:33.930098+00	\N
11	EMP-1766436935343	İngilizce	Pre - Intermediate	2025-12-22 20:55:33.328939+00	\N
12	EMP-1766519616749	English	Proficient	2025-12-23 19:53:34.266207+00	\N
15	EMP-1766519936675	Turkish	native	2025-12-23 19:58:54.584036+00	\N
16	EMP-1766519936675	English	upper int.	2025-12-23 19:58:54.584036+00	\N
19	EMP-1766521577842	Turkish	native	2025-12-23 20:26:15.628619+00	\N
20	EMP-1766521577842	English	upper int.	2025-12-23 20:26:15.628619+00	\N
\.


--
-- Data for Name: candidate_personal_info; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_personal_info (id, candidate_id, birth_date, gender, nationality, email, phone, website, linkedin_url, github_url, professional_title, professional_summary, created_at, updated_at) FROM stdin;
1	EMP-TEST-123456	\N	\N	\N	test@example.com	+1234567890	\N	https://www.linkedin.com/in/test-candidate	https://github.com/testcandidate	Software Engineer	Experienced software engineer with 5+ years of experience.	2025-12-19 10:28:09.601007+00	\N
2	EMP-1766141328216	\N			muhammetsahinyildirim@gmail.com	+905067002739		https://www.linkedin.com/in/muhammetsahinyildirim	https://github.com/sahinyildiriim	Computer Engineering Student	Computer Engineering student at Doğuş University on a full scholarship. I bridge my academic foundations in Python, Java, and C++ with practical application through projects developed using React and modern web technologies. As the Chairman of the Board at the 'Mühendis Beyinler Kulübü' (Engineer Brains Club), I have honed my skills in team management, strategic planning, and organization alongside my technical growth. I am seeking an internship or full-time position where I can leverage my passion for learning and solution-oriented mindset to create value in real-world projects.	2025-12-19 12:30:15.325018+00	\N
3	EMP-1766239092988	\N			muhammed.cihan@hotmail.com	+905350659595		https://linkedin.com/in/muhammedcihan		System Engineer Assistant	As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.	2025-12-20 13:58:10.850979+00	\N
4	EMP-1766239676620	\N			furkanulutas054@gmail.com	+905399225570		https://linkedin.com/in/Furkan-Ulutas	https://github.com/furkanulutas0	Software Engineering Student	I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using.NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.	2025-12-20 14:07:54.362886+00	\N
5	EMP-1766252302499	\N			zeynepnurgungor@icloud.com	05333903683		https://linkedin.com/in/linkedin.com/in/zeynepgngr/	https://github.com/github.com/Zypgungorr	STUDENT OF COMPUTER ENGINEERING	I am a fourth-year Computer Engineering student at Doğuş University. I started my software journey with university courses in C++, C#, Java, and Python, building a strong programming foundation. I also completed a two-year associate degree in Web Design and Coding, independently learning HTML, CSS, and JavaScript to create and customize websites. To strengthen my backend and full-stack skills, I studied .NET, Next.js, Node.js, and PostgreSQL, gaining hands-on experience through various projects. I completed my first two internships at Akgün Group and my third internship at Depauli Systems, working on diverse projects and gaining valuable industry experience. Currently, I am an active member of DOU LOOP, our university's software and idea development team, where collaborating on team projects has been invaluable for my career growth and technical development.	2025-12-20 17:38:20.827172+00	\N
6	EMP-1766254966950	\N			zeynepnurgungor@icloud.com	05333903683		https://linkedin.com/in/linkedin.com/in/zeynepgngr/	https://github.com/github.com/Zypgungorr	STUDENT OF COMPUTER ENGINEERING	I am a fourth-year Computer Engineering student at Doğuş University. I started my software journey with university courses in C++, C#, Java, and Python, building a strong programming foundation. I also completed a two-year associate degree in Web Design and Coding, independently learning HTML, CSS, and JavaScript to create and customize websites. To strengthen my backend and full-stack skills, I studied .NET, Next.js, Node.js, and PostgreSQL, gaining hands-on experience through various projects. I completed my first two internships at Akgün Group and my third internship at Depauli Systems, working on diverse projects and gaining valuable industry experience. Currently, I am an active member of DOU LOOP, our university's software and idea development team, where collaborating on team projects has been invaluable for my career growth and technical development.	2025-12-20 18:22:45.100317+00	\N
7	EMP-1766255177864	\N			furkanulutas054@gmail.com	+905399225570		https://www.linkedin.com/in/Furkan-Ulutas	https://github.com/furkanulutas0	Software Engineering Student	I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using.NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.	2025-12-20 18:26:15.919585+00	\N
8	EMP-1766398835588	\N			elanurdemir100@gmail.com			https://linkedin.com/in/in/elanurdemir		Yazılım Mühendisliği Öğrencisi	2023 yılı itibariyle Doğuş Üniversitesi, Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.	2025-12-22 10:20:33.930098+00	\N
9	EMP-1766436935343	\N			elanurdemir100@gmail.com			https://linkedin.com/in/in/elanurdemir		YAZILIM MÜHENDİSLİĞİ ÖĞRENCİSİ	2023 yılı itibariyle Doğuş Üniversitesi, Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.	2025-12-22 20:55:33.328939+00	\N
10	EMP-1766519202434	\N			elanurdemirr1000@gmail.com	+905476508013		https://linkedin.com/in/linkedin.com/in/elanurdemirr		YAZILIM MÜHENDİSLİĞİ ÖĞRENCİSİ	2023 yılı itibarıyla Doğuş Üniversitesi Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.	2025-12-23 19:46:40.044516+00	\N
11	EMP-1766519616749	\N			furkanulutas054@gmail.com	+905399225570		https://www.linkedin.com/in/furkan-ulutas	https://github.com/furkanulutas0	Software Engineering Student	I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using .NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.	2025-12-23 19:53:34.266207+00	\N
13	EMP-1766519936675	\N			muhammed.cihan@hotmail.com	+905350659595		https://www.linkedin.com/in/muhammedcihan		System Engineer Assistant	As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.	2025-12-23 19:58:54.584036+00	\N
15	EMP-1766521577842	\N			muhammed.cihan@hotmail.com	+905350659595		https://linkedin.com/in/muhammedcihan		System Engineer Assistant	As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.	2025-12-23 20:26:15.628619+00	\N
\.


--
-- Data for Name: candidate_project_achievements; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_project_achievements (id, project_id, achievement) FROM stdin;
1	1	Handled 10K+ daily users
2	5	Delivered 5+ real-world software projects.
3	5	Developed award-winning tech projects like AAIA.
4	5	Achieved a national 5th place ranking in Teknofest Finals through innovation and teamwork.
5	6	achieved 5th place at Teknofest
6	11	achieved 5th place at Teknofest
7	20	Delivered 5+ real-world software projects
8	20	Achieved a national 5th place ranking at the Teknofest Finals through innovation and teamwork
\.


--
-- Data for Name: candidate_project_links; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_project_links (id, project_id, url, link_type) FROM stdin;
\.


--
-- Data for Name: candidate_project_technologies; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_project_technologies (id, project_id, technology) FROM stdin;
1	1	Python
2	1	React
3	1	PostgreSQL
4	2	React
5	2	useState
6	2	useEffect
7	2	Git
8	3	React
9	3	CSS Flexbox/Grid
10	3	React Router
11	3	GitHub Pages
12	3	Git
13	4	React
14	4	API integrations
15	4	Git
16	5	AI-powered systems
17	5	Disaster communication systems
18	6	React Native
19	7	AI
20	8	.NET
21	8	C#
22	8	Next.js
23	8	PostgreSQL
24	8	Gemini AI
25	9	Next.js
26	10	.NET C#
27	10	Next.js
28	10	Gemini AI
29	10	Cohere AI
30	10	ChatGPT
31	11	React Native
32	12	AI
33	13	.NET (C#)
34	13	Next.js
35	13	PostgreSQL
36	13	Gemini AI
37	14	Next.js
38	15	.NET C#
39	15	Next.js
40	15	Gemini AI
41	15	Cohere AI
42	15	ChatGPT
43	16	Java
44	17	React Native
45	18	Java
46	19	React Native
47	20	AI
48	20	disaster communication systems
\.


--
-- Data for Name: candidate_projects; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_projects (id, candidate_id, project_name, description, role, start_date, end_date, is_current, created_at, updated_at) FROM stdin;
1	EMP-TEST-123456	E-commerce Platform	Built a scalable e-commerce platform	Lead Developer	2021-01-01	2021-12-01	f	2025-12-19 10:28:09.601007+00	\N
2	EMP-1766141328216	Todo App	Managed task operations and application lifecycle using React hooks (useState & useEffect). Designed a scalable and modular User Interface (UI) adopting a component-based structure. Implemented API integration and utilized localStorage to ensure data persistence across sessions. Utilized Git for source code management and version tracking throughout the development process.		\N	\N	f	2025-12-19 12:30:15.325018+00	\N
3	EMP-1766141328216	Portfolio Website	Developed a scalable Single Page Application (SPA) using React to showcase professional projects and technical skills. Designed a fully responsive and modern interface using CSS Flexbox/Grid, ensuring seamless usability across mobile and desktop devices. Implemented React Router to enable smooth, client-side page transitions and a dynamic user experience. Deployed and hosted the live application using GitHub Pages, managing version control via Git.		\N	\N	f	2025-12-19 12:30:15.325018+00	\N
4	EMP-1766141328216	VMS & PMS Projects	Actively contributed to the development of Visitor Management System (VMS) and Property Management System (PMS) applications. Built modular and scalable User Interfaces (UI) using React's component-based architecture, ensuring code maintainability and reusability. Implemented seamless API integrations and managed complex data flow between the frontend and backend services. Utilized Git for version control and adhered to team workflows to ensure smooth project delivery and collaboration.		\N	\N	f	2025-12-19 12:30:15.325018+00	\N
5	EMP-1766239676620	LOOP Software & Idea Development Team Projects (including AAIA, AI-powered and disaster communication systems)	As Co-founder and leader, managed 15+ students and delivered 5+ real-world software projects, including AI-powered and disaster communication systems. Guided the team to the Teknofest Finals.	Co-founder and Leader	\N	\N	f	2025-12-20 14:07:54.362886+00	\N
6	EMP-1766252302499	AAIA	AAIA is a React Native mobile application developed to assist people during disaster situations, integrated with our custom-built modem. I actively contributed to both the software development and system enhancement processes. The application aims to ensure reliable communication and coordinated assistance in emergencies.	Mobile Application - ReactNative	\N	\N	f	2025-12-20 17:38:20.827172+00	\N
7	EMP-1766252302499	Dietal	DietAl is an AI-powered nutrition recommendation system designed to provide personalized meal plans and health suggestions by analyzing user data. I took part in the development of this platform, focusing on delivering accurate recommendations through intelligent algorithms.	Mobile Application	\N	\N	f	2025-12-20 17:38:20.827172+00	\N
8	EMP-1766252302499	Smart Micro ERP System	Developed a web-based micro ERP system for SMEs to manage inventory, customer relations, and orders. Built with .NET (C#), Next.js, and PostgreSQL, and integrated Gemini-based AI modules for sales forecasting, price optimization, automated content generation, and trend analysis.	Web Application - Gemini AI, .NET, Next.js	\N	\N	f	2025-12-20 17:38:20.827172+00	\N
9	EMP-1766252302499	Law Firm Website	Developed an informational website for a law firm as a freelance project, using Next.js to deliver a fast, responsive, and SEO-friendly user experience.	Web Application - Next.js	\N	\N	f	2025-12-20 17:38:20.827172+00	\N
10	EMP-1766252302499	Prompt Bridge	Developed a user-friendly platform with .NET C# (backend) and Next.js (frontend) that integrates three AI models in a single panel, enabling sequential prompt chaining and streamlined workflow management.	Web Application - Gemini AI, Cohere AI, ChatGPT, .NET, Next.js	\N	\N	f	2025-12-20 17:38:20.827172+00	\N
11	EMP-1766254966950	AAIA	AAIA is a React Native mobile application developed to assist people during disaster situations, integrated with our custom-built modem. I actively contributed to both the software development and system enhancement processes. The application aims to ensure reliable communication and coordinated assistance in emergencies.	Mobile Application - ReactNative	\N	\N	f	2025-12-20 18:22:45.100317+00	\N
12	EMP-1766254966950	DietAl	DietAl is an AI-powered nutrition recommendation system designed to provide personalized meal plans and health suggestions by analyzing user data. I took part in the development of this platform, focusing on delivering accurate recommendations through intelligent algorithms.	Mobile Application	\N	\N	f	2025-12-20 18:22:45.100317+00	\N
13	EMP-1766254966950	Smart Micro ERP System	Developed a web-based micro ERP system for SMEs to manage inventory, customer relations, and orders. Built with .NET (C#), Next.js, and PostgreSQL, and integrated Gemini-based AI modules for sales forecasting, price optimization, automated content generation, and trend analysis.	Web Application - Gemini AI, .NET, Next.js	\N	\N	f	2025-12-20 18:22:45.100317+00	\N
14	EMP-1766254966950	Law Firm Website	Developed an informational website for a law firm as a freelance project, using Next.js to deliver a fast, responsive, and SEO-friendly user experience.	Web Application - Next.js	\N	\N	f	2025-12-20 18:22:45.100317+00	\N
15	EMP-1766254966950	Prompt Bridge	Developed a user-friendly platform with .NET C# (backend) and Next.js (frontend) that integrates three AI models in a single panel, enabling sequential prompt chaining and streamlined workflow management.	Web Application - Gemini AI, Cohere AI, ChatGPT, .NET, Next.js	\N	\N	f	2025-12-20 18:22:45.100317+00	\N
16	EMP-1766398835588	DOU LOOP "Yazılım ve Fikir Geliştirme" Takımı	A Takımında yazılım geliştirici olarak aktif bir şekilde ve Java kullanarak projeler geliştiriyorum. Mevcut projelere katkı sağlıyorum. Takım içinde işbirliği yaparak, karşılaştığımız zorluklara yaratıcı çözümler geliştirmeye odaklanıyorum. Teknik becerilerimi ve problem çözme yeteneklerimi geliştiriyorum.	Yazılım Geliştirici	2025-01-01	\N	t	2025-12-22 10:20:33.930098+00	\N
17	EMP-1766398835588	DOU LOOP "Yazılım ve Fikir Geliştirme" Takımı	Core Team üyesi olarak yazılım projelerinde yer aldım. Yazılım mühendisliği bilgimi pratiğe dökme fırsatı bulurken, React Native öğrendim. Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim.	Yazılım Geliştirme Core Team Üyesi	2023-12-01	2025-01-01	f	2025-12-22 10:20:33.930098+00	\N
18	EMP-1766436935343	Yazılım ve Fikir Geliştirme Takımı	A Takımında yazılım geliştirici olarak aktif bir şekilde ve Java kullanarak projeler geliştiriyorum. Mevcut projelere katkı sağlıyorum. Takım içinde işbirliği yaparak, karşılaştığımız zorluklara yaratıcı çözümler geliştirmeye odaklanıyorum. Teknik becerilerimi ve problem çözme yeteneklerimi geliştiriyorum.	Yazılım Geliştirici	2025-01-01	\N	t	2025-12-22 20:55:33.328939+00	\N
19	EMP-1766436935343	Yazılım ve Fikir Geliştirme Takımı	Core Team üyesi olarak yazılım projelerinde yer aldım. Yazılım mühendisliği bilgimi pratiğe dökme fırsatı bulurken, React Native öğrendim. Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim.	Yazılım Geliştirme Core Team Üyesi	2023-04-01	2025-01-01	f	2025-12-22 20:55:33.328939+00	\N
20	EMP-1766519616749	LOOP Software & Idea Development Team Initiatives (including AAIA)	Co-founded and led the LOOP Software & Idea Development Team, managing 15+ students and delivering 5+ real-world software projects, including AI-powered and disaster communication systems. Guided the team to the Teknofest Finals.	Co-founder, Team Leader	\N	\N	f	2025-12-23 19:53:34.266207+00	\N
\.


--
-- Data for Name: candidate_publications; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_publications (id, candidate_id, title, publication_type, publisher, publication_date, url, description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: candidate_raw_data; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_raw_data (id, candidate_id, raw_structured_data, n8n_response, created_at) FROM stdin;
1	EMP-TEST-123456	{"awards": [], "skills": {"languages": [{"language": "English", "proficiency": "Fluent"}, {"language": "Turkish", "proficiency": "Native"}], "soft_skills": ["Leadership", "Communication", "Problem Solving"], "technical_skills": [{"skills": ["Python", "JavaScript"], "skill_category": "Programming Languages"}, {"skills": ["React", "FastAPI"], "skill_category": "Frameworks"}]}, "summary": {"short_summary": "Experienced software engineer with 5+ years of experience.", "professional_title": "Software Engineer"}, "publications": [], "certifications": [], "personal_information": {"email": "test@example.com", "phone": "+1234567890", "github": "https://github.com/testcandidate", "address": {"city": "Istanbul", "country": "Turkey"}, "linkedin": "https://www.linkedin.com/in/test-candidate", "full_name": "Test Candidate"}, "additional_information": {"hobbies": ["Reading", "Coding"], "availability": "Immediate", "driving_license": "B", "military_status": "Completed", "willing_to_travel": false, "willing_to_relocate": true}}	{"email": "test@example.com", "phone": "+1234567890", "source": "CV Upload - AI Parsed", "location": "Istanbul, Turkey", "projects": "[{\\"project_name\\": \\"E-commerce Platform\\", \\"description\\": \\"Built a scalable e-commerce platform\\", \\"role\\": \\"Lead Developer\\", \\"start_date\\": \\"2021-01\\", \\"end_date\\": \\"2021-12\\", \\"is_current\\": false, \\"technologies\\": [\\"Python\\", \\"React\\", \\"PostgreSQL\\"], \\"achievements\\": [\\"Handled 10K+ daily users\\"], \\"links\\": []}]", "full_name": "Test Candidate", "languages": "English (Fluent), Turkish (Native)", "timestamp": "2025-12-19T09:42:13.536Z", "github_url": "https://github.com/testcandidate", "employee_id": "EMP-TEST-123456", "institution": "Test University", "soft_skills": "Leadership, Communication, Problem Solving", "last_updated": "2025-12-19T09:42:13.537Z", "linkedin_url": "https://www.linkedin.com/in/test-candidate", "volunteering": "[]", "certifications": "None", "field_of_study": "Computer Science", "highest_degree": "Bachelor's", "processed_date": "2025-12-19T09:42:13.537Z", "profile_status": "Complete", "projects_count": 1, "current_company": "Tech Company Inc.", "work_experience": "[{\\"job_title\\": \\"Senior Software Engineer\\", \\"company\\": \\"Tech Company Inc.\\", \\"employment_type\\": \\"Full-time\\", \\"location\\": {\\"country\\": \\"Turkey\\", \\"city\\": \\"Istanbul\\"}, \\"start_date\\": \\"2020-01\\", \\"end_date\\": null, \\"is_current\\": true, \\"responsibilities\\": [\\"Led development of microservices architecture\\", \\"Mentored junior developers\\"], \\"achievements\\": [\\"Improved system performance by 40%\\"], \\"technologies_used\\": [\\"Python\\", \\"FastAPI\\", \\"PostgreSQL\\", \\"Docker\\"]}]", "current_position": "Senior Software Engineer", "technical_skills": "Python, JavaScript, React, FastAPI, PostgreSQL, Docker", "education_details": "[{\\"institution\\": \\"Test University\\", \\"degree\\": \\"Bachelor's\\", \\"field_of_study\\": \\"Computer Science\\", \\"gpa\\": \\"3.8\\", \\"start_date\\": \\"2015-09\\", \\"end_date\\": \\"2019-06\\", \\"is_current\\": false, \\"courses\\": [\\"Data Structures\\", \\"Algorithms\\", \\"Database Systems\\"], \\"thesis\\": \\"\\"}]", "original_filename": "test_cv.pdf", "completeness_score": 95, "professional_title": "Software Engineer", "volunteering_count": 0, "raw_structured_data": "{\\"personal_information\\": {\\"full_name\\": \\"Test Candidate\\", \\"email\\": \\"test@example.com\\", \\"phone\\": \\"+1234567890\\", \\"linkedin\\": \\"https://www.linkedin.com/in/test-candidate\\", \\"github\\": \\"https://github.com/testcandidate\\", \\"address\\": {\\"country\\": \\"Turkey\\", \\"city\\": \\"Istanbul\\"}}, \\"summary\\": {\\"professional_title\\": \\"Software Engineer\\", \\"short_summary\\": \\"Experienced software engineer with 5+ years of experience.\\"}, \\"skills\\": {\\"technical_skills\\": [{\\"skill_category\\": \\"Programming Languages\\", \\"skills\\": [\\"Python\\", \\"JavaScript\\"]}, {\\"skill_category\\": \\"Frameworks\\", \\"skills\\": [\\"React\\", \\"FastAPI\\"]}], \\"soft_skills\\": [\\"Leadership\\", \\"Communication\\", \\"Problem Solving\\"], \\"languages\\": [{\\"language\\": \\"English\\", \\"proficiency\\": \\"Fluent\\"}, {\\"language\\": \\"Turkish\\", \\"proficiency\\": \\"Native\\"}]}, \\"certifications\\": [], \\"publications\\": [], \\"awards\\": [], \\"additional_information\\": {\\"hobbies\\": [\\"Reading\\", \\"Coding\\"], \\"driving_license\\": \\"B\\", \\"military_status\\": \\"Completed\\", \\"availability\\": \\"Immediate\\", \\"willing_to_relocate\\": true, \\"willing_to_travel\\": false}}", "certifications_count": 0, "professional_summary": "Experienced software engineer with 5+ years of experience.", "total_experience_years": 5.5}	2025-12-19 10:28:09.601007+00
2	EMP-1766141328216	{"awards": [{"date": "2022", "issuer": "Doğuş University", "award_name": "100% Full Scholarship", "description": "Awarded based on outstanding academic performance."}], "skills": {"languages": [{"language": "Turkish", "proficiency": "Native"}, {"language": "English", "proficiency": "B2"}], "soft_skills": [], "technical_skills": [{"skills": ["Java", "Python", "C++", "JavaScript", "TypeScript", "MATLAB"], "skill_category": "Programming Languages"}, {"skills": ["React", "React Native", "HTML5", "CSS3", "Tailwind CSS", "Bootstrap"], "skill_category": "Frontend & Mobile"}, {"skills": ["Node.js", "Express.js", "NestJS", ".NET"], "skill_category": "Backend & Frameworks"}, {"skills": ["PostgreSQL", "MySQL", "MongoDB", "Firebase"], "skill_category": "Databases & Cloud"}, {"skills": ["Git", "GitHub", "Jira", "Figma", "Android Studio", "Selenium"], "skill_category": "Tools & Testing"}]}, "summary": {"short_summary": "Computer Engineering student at Doğuş University on a full scholarship. I bridge my academic foundations in Python, Java, and C++ with practical application through projects developed using React and modern web technologies. As the Chairman of the Board at the 'Mühendis Beyinler Kulübü' (Engineer Brains Club), I have honed my skills in team management, strategic planning, and organization alongside my technical growth. I am seeking an internship or full-time position where I can leverage my passion for learning and solution-oriented mindset to create value in real-world projects.", "professional_title": "Computer Engineering Student"}, "projects": [{"role": "", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Managed task operations and application lifecycle using React hooks (useState & useEffect). Designed a scalable and modular User Interface (UI) adopting a component-based structure. Implemented API integration and utilized localStorage to ensure data persistence across sessions. Utilized Git for source code management and version tracking throughout the development process.", "achievements": [], "project_name": "Todo App", "technologies": ["React", "useState", "useEffect", "Git"]}, {"role": "", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a scalable Single Page Application (SPA) using React to showcase professional projects and technical skills. Designed a fully responsive and modern interface using CSS Flexbox/Grid, ensuring seamless usability across mobile and desktop devices. Implemented React Router to enable smooth, client-side page transitions and a dynamic user experience. Deployed and hosted the live application using GitHub Pages, managing version control via Git.", "achievements": [], "project_name": "Portfolio Website", "technologies": ["React", "CSS Flexbox/Grid", "React Router", "GitHub Pages", "Git"]}, {"role": "", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Actively contributed to the development of Visitor Management System (VMS) and Property Management System (PMS) applications. Built modular and scalable User Interfaces (UI) using React's component-based architecture, ensuring code maintainability and reusability. Implemented seamless API integrations and managed complex data flow between the frontend and backend services. Utilized Git for version control and adhered to team workflows to ensure smooth project delivery and collaboration.", "achievements": [], "project_name": "VMS & PMS Projects", "technologies": ["React", "API integrations", "Git"]}], "education": [{"gpa": "", "degree": "B.Sc.", "thesis": "", "courses": ["Data Structures", "Algorithms", "Operating Systems", "Database Management", "Object-Oriented Programming"], "end_date": "", "is_current": true, "start_date": "2022", "institution": "Doğuş University", "field_of_study": "Computer Engineering"}], "publications": [], "volunteering": [], "certifications": [], "work_experience": [{"company": "Mühendis Beyinler Kulübü (Engineer Brains Club)", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "Chairman of the Board", "is_current": true, "start_date": "2025-02", "achievements": [], "employment_type": "", "responsibilities": ["Served as the Chairman for the university's most active student community. Led and managed a 6-person executive team, establishing the club's annual strategic roadmap and event calendar.", "Successfully managed the planning, budgeting, and operational processes for 20-25 annual events, including technical seminars, workshops, and social activities.", "Strengthened communication between members and sub-committees, optimizing task allocation and performance tracking processes. Increased the number of active members through initiatives aimed at enhancing member engagement.", "Managed corporate communications with industry professionals and sponsor companies, securing both financial and in-kind resources for the club."], "technologies_used": []}, {"company": "Loop \\"Yazılım ve Fikir Geliştirme\\" Team", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "Junior Software Developer", "is_current": true, "start_date": "2025-01", "achievements": [], "employment_type": "", "responsibilities": ["Actively contributed to the front-end development of web-based projects, participating in all stages of the SDLC (analysis, coding, and testing).", "Applied foundational knowledge of Python and Java to web projects, gaining hands-on experience with React. Focused on building modular architectures and ensuring code reusability.", "Led internal brainstorming sessions to drive idea generation. Delivered creative solutions to technical challenges, ensuring projects were completed within deadlines."], "technologies_used": ["Python", "Java", "React"]}], "personal_information": {"email": "muhammetsahinyildirim@gmail.com", "phone": "+90506700 2739", "gender": "", "github": "https://github.com/sahinyildiriim", "address": {"city": "İstanbul", "street": "Ümraniye", "country": "Turkey", "postal_code": ""}, "website": "", "linkedin": "https://www.linkedin.com/in/muhammetsahinyildirim", "full_name": "Muhammet Şahin Yıldırım", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}	{"email": "muhammetsahinyildirim@gmail.com", "phone": "+905067002739", "source": "CV Upload - AI Parsed", "location": "İstanbul, Turkey", "projects": "[{\\"project_name\\":\\"Todo App\\",\\"description\\":\\"Managed task operations and application lifecycle using React hooks (useState & useEffect). Designed a scalable and modular User Interface (UI) adopting a component-based structure. Implemented API integration and utilized localStorage to ensure data persistence across sessions. Utilized Git for source code management and version tracking throughout the development process.\\",\\"role\\":\\"\\",\\"start_date\\":\\"\\",\\"end_date\\":\\"\\",\\"is_current\\":false,\\"technologies\\":[\\"React\\",\\"useState\\",\\"useEffect\\",\\"Git\\"],\\"achievements\\":[],\\"links\\":[]},{\\"project_name\\":\\"Portfolio Website\\",\\"description\\":\\"Developed a scalable Single Page Application (SPA) using React to showcase professional projects and technical skills. Designed a fully responsive and modern interface using CSS Flexbox/Grid, ensuring seamless usability across mobile and desktop devices. Implemented React Router to enable smooth, client-side page transitions and a dynamic user experience. Deployed and hosted the live application using GitHub Pages, managing version control via Git.\\",\\"role\\":\\"\\",\\"start_date\\":\\"\\",\\"end_date\\":\\"\\",\\"is_current\\":false,\\"technologies\\":[\\"React\\",\\"CSS Flexbox/Grid\\",\\"React Router\\",\\"GitHub Pages\\",\\"Git\\"],\\"achievements\\":[],\\"links\\":[]},{\\"project_name\\":\\"VMS & PMS Projects\\",\\"description\\":\\"Actively contributed to the development of Visitor Management System (VMS) and Property Management System (PMS) applications. Built modular and scalable User Interfaces (UI) using React's component-based architecture, ensuring code maintainability and reusability. Implemented seamless API integrations and managed complex data flow between the frontend and backend services. Utilized Git for version control and adhered to team workflows to ensure smooth project delivery and collaboration.\\",\\"role\\":\\"\\",\\"start_date\\":\\"\\",\\"end_date\\":\\"\\",\\"is_current\\":false,\\"technologies\\":[\\"React\\",\\"API integrations\\",\\"Git\\"],\\"achievements\\":[],\\"links\\":[]}]", "full_name": "Muhammet Şahin Yıldırım", "languages": "Turkish (Native), English (B2)", "timestamp": "2025-12-19T10:48:48.216Z", "github_url": "https://github.com/sahinyildiriim", "employee_id": "EMP-1766141328216", "institution": "Doğuş University", "soft_skills": "Not Specified", "last_updated": "2025-12-19T10:48:48.216Z", "linkedin_url": "https://www.linkedin.com/in/muhammetsahinyildirim", "volunteering": "[]", "certifications": "None", "field_of_study": "Computer Engineering", "highest_degree": "B.Sc.", "processed_date": "2025-12-19T10:48:48.216Z", "profile_status": "Complete", "projects_count": 3, "current_company": "Mühendis Beyinler Kulübü (Engineer Brains Club)", "work_experience": "[{\\"job_title\\":\\"Chairman of the Board\\",\\"company\\":\\"Mühendis Beyinler Kulübü (Engineer Brains Club)\\",\\"employment_type\\":\\"\\",\\"location\\":{\\"country\\":\\"\\",\\"city\\":\\"\\"},\\"start_date\\":\\"2025-02\\",\\"end_date\\":\\"\\",\\"is_current\\":true,\\"responsibilities\\":[\\"Served as the Chairman for the university's most active student community. Led and managed a 6-person executive team, establishing the club's annual strategic roadmap and event calendar.\\",\\"Successfully managed the planning, budgeting, and operational processes for 20-25 annual events, including technical seminars, workshops, and social activities.\\",\\"Strengthened communication between members and sub-committees, optimizing task allocation and performance tracking processes. Increased the number of active members through initiatives aimed at enhancing member engagement.\\",\\"Managed corporate communications with industry professionals and sponsor companies, securing both financial and in-kind resources for the club.\\"],\\"achievements\\":[],\\"technologies_used\\":[]},{\\"job_title\\":\\"Junior Software Developer\\",\\"company\\":\\"Loop \\\\\\"Yazılım ve Fikir Geliştirme\\\\\\" Team\\",\\"employment_type\\":\\"\\",\\"location\\":{\\"country\\":\\"\\",\\"city\\":\\"\\"},\\"start_date\\":\\"2025-01\\",\\"end_date\\":\\"\\",\\"is_current\\":true,\\"responsibilities\\":[\\"Actively contributed to the front-end development of web-based projects, participating in all stages of the SDLC (analysis, coding, and testing).\\",\\"Applied foundational knowledge of Python and Java to web projects, gaining hands-on experience with React. Focused on building modular architectures and ensuring code reusability.\\",\\"Led internal brainstorming sessions to drive idea generation. Delivered creative solutions to technical challenges, ensuring projects were completed within deadlines.\\"],\\"achievements\\":[],\\"technologies_used\\":[\\"Python\\",\\"Java\\",\\"React\\"]}]", "current_position": "Chairman of the Board", "technical_skills": "Java, Python, C++, JavaScript, TypeScript, MATLAB, React, React Native, HTML5, CSS3, Tailwind CSS, Bootstrap, Node.js, Express.js, NestJS, .NET, PostgreSQL, MySQL, MongoDB, Firebase, Git, GitHub, Jira, Figma, Android Studio, Selenium", "education_details": "[{\\"institution\\":\\"Doğuş University\\",\\"degree\\":\\"B.Sc.\\",\\"field_of_study\\":\\"Computer Engineering\\",\\"gpa\\":\\"\\",\\"start_date\\":\\"2022\\",\\"end_date\\":\\"\\",\\"is_current\\":true,\\"courses\\":[\\"Data Structures\\",\\"Algorithms\\",\\"Operating Systems\\",\\"Database Management\\",\\"Object-Oriented Programming\\"],\\"thesis\\":\\"\\"}]", "original_filename": "unknown.pdf", "completeness_score": 90, "professional_title": "Computer Engineering Student", "volunteering_count": 0, "raw_structured_data": "{\\"personal_information\\":{\\"full_name\\":\\"Muhammet Şahin Yıldırım\\",\\"birth_date\\":\\"\\",\\"gender\\":\\"\\",\\"nationality\\":\\"\\",\\"email\\":\\"muhammetsahinyildirim@gmail.com\\",\\"phone\\":\\"+90506700 2739\\",\\"website\\":\\"\\",\\"linkedin\\":\\"https://www.linkedin.com/in/muhammetsahinyildirim\\",\\"github\\":\\"https://github.com/sahinyildiriim\\",\\"address\\":{\\"country\\":\\"Turkey\\",\\"city\\":\\"İstanbul\\",\\"street\\":\\"Ümraniye\\",\\"postal_code\\":\\"\\"}},\\"summary\\":{\\"professional_title\\":\\"Computer Engineering Student\\",\\"short_summary\\":\\"Computer Engineering student at Doğuş University on a full scholarship. I bridge my academic foundations in Python, Java, and C++ with practical application through projects developed using React and modern web technologies. As the Chairman of the Board at the 'Mühendis Beyinler Kulübü' (Engineer Brains Club), I have honed my skills in team management, strategic planning, and organization alongside my technical growth. I am seeking an internship or full-time position where I can leverage my passion for learning and solution-oriented mindset to create value in real-world projects.\\"},\\"work_experience\\":[{\\"job_title\\":\\"Chairman of the Board\\",\\"company\\":\\"Mühendis Beyinler Kulübü (Engineer Brains Club)\\",\\"employment_type\\":\\"\\",\\"location\\":{\\"country\\":\\"\\",\\"city\\":\\"\\"},\\"start_date\\":\\"2025-02\\",\\"end_date\\":\\"\\",\\"is_current\\":true,\\"responsibilities\\":[\\"Served as the Chairman for the university's most active student community. Led and managed a 6-person executive team, establishing the club's annual strategic roadmap and event calendar.\\",\\"Successfully managed the planning, budgeting, and operational processes for 20-25 annual events, including technical seminars, workshops, and social activities.\\",\\"Strengthened communication between members and sub-committees, optimizing task allocation and performance tracking processes. Increased the number of active members through initiatives aimed at enhancing member engagement.\\",\\"Managed corporate communications with industry professionals and sponsor companies, securing both financial and in-kind resources for the club.\\"],\\"achievements\\":[],\\"technologies_used\\":[]},{\\"job_title\\":\\"Junior Software Developer\\",\\"company\\":\\"Loop \\\\\\"Yazılım ve Fikir Geliştirme\\\\\\" Team\\",\\"employment_type\\":\\"\\",\\"location\\":{\\"country\\":\\"\\",\\"city\\":\\"\\"},\\"start_date\\":\\"2025-01\\",\\"end_date\\":\\"\\",\\"is_current\\":true,\\"responsibilities\\":[\\"Actively contributed to the front-end development of web-based projects, participating in all stages of the SDLC (analysis, coding, and testing).\\",\\"Applied foundational knowledge of Python and Java to web projects, gaining hands-on experience with React. Focused on building modular architectures and ensuring code reusability.\\",\\"Led internal brainstorming sessions to drive idea generation. Delivered creative solutions to technical challenges, ensuring projects were completed within deadlines.\\"],\\"achievements\\":[],\\"technologies_used\\":[\\"Python\\",\\"Java\\",\\"React\\"]}],\\"education\\":[{\\"institution\\":\\"Doğuş University\\",\\"degree\\":\\"B.Sc.\\",\\"field_of_study\\":\\"Computer Engineering\\",\\"gpa\\":\\"\\",\\"start_date\\":\\"2022\\",\\"end_date\\":\\"\\",\\"is_current\\":true,\\"courses\\":[\\"Data Structures\\",\\"Algorithms\\",\\"Operating Systems\\",\\"Database Management\\",\\"Object-Oriented Programming\\"],\\"thesis\\":\\"\\"}],\\"skills\\":{\\"technical_skills\\":[{\\"skill_category\\":\\"Programming Languages\\",\\"skills\\":[\\"Java\\",\\"Python\\",\\"C++\\",\\"JavaScript\\",\\"TypeScript\\",\\"MATLAB\\"]},{\\"skill_category\\":\\"Frontend & Mobile\\",\\"skills\\":[\\"React\\",\\"React Native\\",\\"HTML5\\",\\"CSS3\\",\\"Tailwind CSS\\",\\"Bootstrap\\"]},{\\"skill_category\\":\\"Backend & Frameworks\\",\\"skills\\":[\\"Node.js\\",\\"Express.js\\",\\"NestJS\\",\\".NET\\"]},{\\"skill_category\\":\\"Databases & Cloud\\",\\"skills\\":[\\"PostgreSQL\\",\\"MySQL\\",\\"MongoDB\\",\\"Firebase\\"]},{\\"skill_category\\":\\"Tools & Testing\\",\\"skills\\":[\\"Git\\",\\"GitHub\\",\\"Jira\\",\\"Figma\\",\\"Android Studio\\",\\"Selenium\\"]}],\\"soft_skills\\":[],\\"languages\\":[{\\"language\\":\\"Turkish\\",\\"proficiency\\":\\"Native\\"},{\\"language\\":\\"English\\",\\"proficiency\\":\\"B2\\"}]},\\"certifications\\":[],\\"projects\\":[{\\"project_name\\":\\"Todo App\\",\\"description\\":\\"Managed task operations and application lifecycle using React hooks (useState & useEffect). Designed a scalable and modular User Interface (UI) adopting a component-based structure. Implemented API integration and utilized localStorage to ensure data persistence across sessions. Utilized Git for source code management and version tracking throughout the development process.\\",\\"role\\":\\"\\",\\"start_date\\":\\"\\",\\"end_date\\":\\"\\",\\"is_current\\":false,\\"technologies\\":[\\"React\\",\\"useState\\",\\"useEffect\\",\\"Git\\"],\\"achievements\\":[],\\"links\\":[]},{\\"project_name\\":\\"Portfolio Website\\",\\"description\\":\\"Developed a scalable Single Page Application (SPA) using React to showcase professional projects and technical skills. Designed a fully responsive and modern interface using CSS Flexbox/Grid, ensuring seamless usability across mobile and desktop devices. Implemented React Router to enable smooth, client-side page transitions and a dynamic user experience. Deployed and hosted the live application using GitHub Pages, managing version control via Git.\\",\\"role\\":\\"\\",\\"start_date\\":\\"\\",\\"end_date\\":\\"\\",\\"is_current\\":false,\\"technologies\\":[\\"React\\",\\"CSS Flexbox/Grid\\",\\"React Router\\",\\"GitHub Pages\\",\\"Git\\"],\\"achievements\\":[],\\"links\\":[]},{\\"project_name\\":\\"VMS & PMS Projects\\",\\"description\\":\\"Actively contributed to the development of Visitor Management System (VMS) and Property Management System (PMS) applications. Built modular and scalable User Interfaces (UI) using React's component-based architecture, ensuring code maintainability and reusability. Implemented seamless API integrations and managed complex data flow between the frontend and backend services. Utilized Git for version control and adhered to team workflows to ensure smooth project delivery and collaboration.\\",\\"role\\":\\"\\",\\"start_date\\":\\"\\",\\"end_date\\":\\"\\",\\"is_current\\":false,\\"technologies\\":[\\"React\\",\\"API integrations\\",\\"Git\\"],\\"achievements\\":[],\\"links\\":[]}],\\"publications\\":[],\\"awards\\":[{\\"award_name\\":\\"100% Full Scholarship\\",\\"issuer\\":\\"Doğuş University\\",\\"date\\":\\"2022\\",\\"description\\":\\"Awarded based on outstanding academic performance.\\"}],\\"volunteering\\":[],\\"additional_information\\":{\\"hobbies\\":[],\\"driving_license\\":\\"\\",\\"military_status\\":\\"\\",\\"availability\\":\\"\\",\\"willing_to_relocate\\":false,\\"willing_to_travel\\":false}}", "certifications_count": 0, "professional_summary": "Computer Engineering student at Doğuş University on a full scholarship. I bridge my academic foundations in Python, Java, and C++ with practical application through projects developed using React and modern web technologies. As the Chairman of the Board at the 'Mühendis Beyinler Kulübü' (Engineer Brains Club), I have honed my skills in team management, strategic planning, and organization alongside my technical growth. I am seeking an internship or full-time position where I can leverage my passion for learning and solution-oriented mindset to create value in real-world projects.", "total_experience_years": 1.8}	2025-12-19 12:30:15.325018+00
3	EMP-1766239092988	{"awards": [], "skills": {"languages": [{"language": "Turkish", "proficiency": "Native"}, {"language": "English", "proficiency": "Upper Intermediate"}], "soft_skills": ["Team management", "Cross-functional communication", "Event moderation", "Problem-solving"], "technical_skills": [{"skills": ["IBM CICS", "IBM MQ", "JCL", "RabbitMQ", "SSRS", "MS SQL"], "skill_category": "Tools & Technologies"}]}, "summary": {"short_summary": "As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.", "professional_title": "System Engineer Assistant"}, "projects": [], "education": [{"gpa": "", "degree": "Bachelor of Science", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}], "publications": [], "volunteering": [{"role": "Founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "University's first hackathon/ideathon team", "responsibilities": ["Founded and led the university's first hackathon/ideathon team."]}, {"role": "Chairman", "end_date": "", "is_current": false, "start_date": "", "organization": "Mühendis Beyinler Club", "responsibilities": ["Overseeing operations and student engagement.", "Organized technical events, workshops, and seminars to support practical skill development."]}], "certifications": [{"name": "IBM z/OS Introduction", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "SQL Server", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "IT Service Management", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "Java Basics", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}], "work_experience": [{"company": "Garanti BBVA Technology", "end_date": "", "location": {"city": "Istanbul", "country": "Turkiye"}, "job_title": "System Engineer Assistant", "is_current": true, "start_date": "2023-06", "achievements": [], "employment_type": "", "responsibilities": ["Created initial definitions for CICS environments systems.", "Performed process monitoring, error handling, and basic configuration on IBM CICS.", "Worked with queue and channel structures on IBM MQ, monitoring message flows.", "Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.", "Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.", "Generated internal reports from daily log data using SSRS.", "Collaborated with cross-functional teams (network, application, and database) to resolve system issues.", "Tracked job logs, analyzed system messages, and conducted initial error analysis.", "Wrote entry-level JCL scripts to initiate and monitor basic batch jobs"], "technologies_used": ["IBM CICS", "IBM MQ", "OMEGAMON", "SSRS", "JCL"]}], "personal_information": {"email": "muhammed.cihan@hotmail.com", "phone": "+90 (535) 065 95 95", "gender": "", "github": "", "address": {"city": "Istanbul", "street": "", "country": "Turkiye", "postal_code": ""}, "website": "", "linkedin": "@muhammedcihan", "full_name": "MUHAMMED CIHAN", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": ["aaaa"], "availability": "Immediately", "driving_license": "Class B", "military_status": "Completed", "willing_to_travel": true, "willing_to_relocate": true}}	{"email": "muhammed.cihan@hotmail.com", "phone": "+905350659595", "source": "CV Upload - AI Parsed", "location": "Istanbul, Turkiye", "projects": [], "full_name": "MUHAMMED CIHAN", "languages": "Turkish (Native), English (Upper Intermediate)", "timestamp": "2025-12-20T13:58:12.989Z", "github_url": "", "employee_id": "EMP-1766239092988", "institution": "Dogus University", "soft_skills": "Team management, Cross-functional communication, Event moderation, Problem-solving", "last_updated": "2025-12-20T13:58:12.990Z", "linkedin_url": "https://linkedin.com/in/muhammedcihan", "volunteering": [{"role": "Founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "University's first hackathon/ideathon team", "responsibilities": ["Founded and led the university's first hackathon/ideathon team."]}, {"role": "Chairman", "end_date": "", "is_current": false, "start_date": "", "organization": "Mühendis Beyinler Club", "responsibilities": ["Overseeing operations and student engagement.", "Organized technical events, workshops, and seminars to support practical skill development."]}], "certifications": "IBM z/OS Introduction, SQL Server, IT Service Management, Java Basics", "field_of_study": "Computer Engineering", "highest_degree": "Bachelor of Science", "processed_date": "2025-12-20T13:58:12.990Z", "profile_status": "Complete", "projects_count": 0, "current_company": "Garanti BBVA Technology", "work_experience": [{"company": "Garanti BBVA Technology", "end_date": "", "location": {"city": "Istanbul", "country": "Turkiye"}, "job_title": "System Engineer Assistant", "is_current": true, "start_date": "2023-06", "achievements": [], "employment_type": "", "responsibilities": ["Created initial definitions for CICS environments systems.", "Performed process monitoring, error handling, and basic configuration on IBM CICS.", "Worked with queue and channel structures on IBM MQ, monitoring message flows.", "Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.", "Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.", "Generated internal reports from daily log data using SSRS.", "Collaborated with cross-functional teams (network, application, and database) to resolve system issues.", "Tracked job logs, analyzed system messages, and conducted initial error analysis.", "Wrote entry-level JCL scripts to initiate and monitor basic batch jobs"], "technologies_used": ["IBM CICS", "IBM MQ", "OMEGAMON", "SSRS", "JCL"]}], "current_position": "System Engineer Assistant", "technical_skills": "IBM CICS, IBM MQ, JCL, RabbitMQ, SSRS, MS SQL", "education_details": [{"gpa": "", "degree": "Bachelor of Science", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}], "original_filename": "unknown.pdf", "completeness_score": 95, "professional_title": "System Engineer Assistant", "volunteering_count": 2, "raw_structured_data": {"awards": [], "skills": {"languages": [{"language": "Turkish", "proficiency": "Native"}, {"language": "English", "proficiency": "Upper Intermediate"}], "soft_skills": ["Team management", "Cross-functional communication", "Event moderation", "Problem-solving"], "technical_skills": [{"skills": ["IBM CICS", "IBM MQ", "JCL", "RabbitMQ", "SSRS", "MS SQL"], "skill_category": "Tools & Technologies"}]}, "summary": {"short_summary": "As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.", "professional_title": "System Engineer Assistant"}, "projects": [], "education": [{"gpa": "", "degree": "Bachelor of Science", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}], "publications": [], "volunteering": [{"role": "Founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "University's first hackathon/ideathon team", "responsibilities": ["Founded and led the university's first hackathon/ideathon team."]}, {"role": "Chairman", "end_date": "", "is_current": false, "start_date": "", "organization": "Mühendis Beyinler Club", "responsibilities": ["Overseeing operations and student engagement.", "Organized technical events, workshops, and seminars to support practical skill development."]}], "certifications": [{"name": "IBM z/OS Introduction", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "SQL Server", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "IT Service Management", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "Java Basics", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}], "work_experience": [{"company": "Garanti BBVA Technology", "end_date": "", "location": {"city": "Istanbul", "country": "Turkiye"}, "job_title": "System Engineer Assistant", "is_current": true, "start_date": "2023-06", "achievements": [], "employment_type": "", "responsibilities": ["Created initial definitions for CICS environments systems.", "Performed process monitoring, error handling, and basic configuration on IBM CICS.", "Worked with queue and channel structures on IBM MQ, monitoring message flows.", "Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.", "Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.", "Generated internal reports from daily log data using SSRS.", "Collaborated with cross-functional teams (network, application, and database) to resolve system issues.", "Tracked job logs, analyzed system messages, and conducted initial error analysis.", "Wrote entry-level JCL scripts to initiate and monitor basic batch jobs"], "technologies_used": ["IBM CICS", "IBM MQ", "OMEGAMON", "SSRS", "JCL"]}], "personal_information": {"email": "muhammed.cihan@hotmail.com", "phone": "+90 (535) 065 95 95", "gender": "", "github": "", "address": {"city": "Istanbul", "street": "", "country": "Turkiye", "postal_code": ""}, "website": "", "linkedin": "@muhammedcihan", "full_name": "MUHAMMED CIHAN", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": ["aaaa"], "availability": "Immediately", "driving_license": "Class B", "military_status": "Completed", "willing_to_travel": true, "willing_to_relocate": true}}, "certifications_count": 4, "professional_summary": "As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.", "total_experience_years": 2.5}	2025-12-20 13:58:10.850979+00
4	EMP-1766239676620	{"awards": [{"date": "", "issuer": "Teknofest", "award_name": "National 5th place ranking at Teknofest Finals", "description": "Achieved through innovation and teamwork with the LOOP Software & Idea Development Team."}], "skills": {"languages": [{"language": "English", "proficiency": ""}], "soft_skills": ["Project & Team Management", "Communication & Coordination", "Design Thinking", "Troubleshooting", "Planning", "Team Player"], "technical_skills": [{"skills": ["C#", "TypeScript", "Python", "Java"], "skill_category": "Programming Languages"}, {"skills": [".NET", "ASP.NET", "React", "Next.js", "NestJS", "Node.js", "Expo"], "skill_category": "Frameworks & Libraries"}, {"skills": ["Azure DevOps", "GitHub Actions", "Docker", "SonarQube", "ELK Stack", "Grafana"], "skill_category": "DevOps & Tools"}, {"skills": ["MS SQL", "PostgreSQL", "Redis", "NoSQL"], "skill_category": "Databases"}, {"skills": ["Figma", "Cursor"], "skill_category": "Other Tools"}]}, "summary": {"short_summary": "I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using.NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.", "professional_title": "Software Engineering Student"}, "projects": [{"role": "Co-founder and Leader", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "As Co-founder and leader, managed 15+ students and delivered 5+ real-world software projects, including AI-powered and disaster communication systems. Guided the team to the Teknofest Finals.", "achievements": ["Delivered 5+ real-world software projects.", "Developed award-winning tech projects like AAIA.", "Achieved a national 5th place ranking in Teknofest Finals through innovation and teamwork."], "project_name": "LOOP Software & Idea Development Team Projects (including AAIA, AI-powered and disaster communication systems)", "technologies": ["AI-powered systems", "Disaster communication systems"]}], "education": [{"gpa": "", "degree": "BSc.", "thesis": "Focusing on full-stack development, software architecture, and DevOps practices.", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2022-06", "institution": "Doğuş University", "field_of_study": "Software Engineering"}, {"gpa": "", "degree": "Program", "thesis": "Completed an intensive English preparation program, enhancing academic and professional communication skills.", "courses": [], "end_date": "2022-06", "is_current": false, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "English Preparation"}], "publications": [], "volunteering": [{"role": "Co-founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "LOOP Software & Idea Development Team", "responsibilities": ["Managed 15+ students.", "Delivered 5+ real-world software projects, including AI-powered and disaster communication systems.", "Guided the team to the Teknofest Finals, achieving a national 5th place ranking."]}, {"role": "Chairman", "end_date": "", "is_current": false, "start_date": "", "organization": "Largest university club (500+ active members)", "responsibilities": ["Organized 10+ technical and career events and increasing engagement by 40%.", "Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community."]}], "certifications": [], "work_experience": [{"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2025-04", "location": {"city": "", "country": ""}, "job_title": "Software Development Intern", "is_current": true, "start_date": "2024-10", "achievements": [], "employment_type": "Internship", "responsibilities": ["Developed full-stack applications using .NET, React, and Azure DevOps.", "Collaborated with QA and DevOps teams to enhance software scalability."], "technologies_used": [".NET", "React", "Azure DevOps"]}, {"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2024-10", "location": {"city": "", "country": ""}, "job_title": "Product Owner Intern", "is_current": false, "start_date": "2024-06", "achievements": ["Contributed to on-time delivery of key product features."], "employment_type": "Internship", "responsibilities": ["Managed product backlog and prioritized tasks using Agile development methodologies.", "Defined user stories and acceptance criteria to align development with business goals.", "Facilitated communication between stakeholders and technical teams.", "Contributed to on-time delivery of key product features."], "technologies_used": ["Agile"]}], "personal_information": {"email": "furkanulutas054@gmail.com", "phone": "+90 5399225570", "gender": "", "github": "@furkanulutas0", "address": {"city": "", "street": "", "country": "", "postal_code": ""}, "website": "", "linkedin": "@Furkan-Ulutas", "full_name": "Furkan Ulutaş", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": ["Abc", "bca", "dba"], "availability": "Immediately", "driving_license": "Class B", "military_status": "Completed", "willing_to_travel": false, "willing_to_relocate": true}}	{"email": "furkanulutas054@gmail.com", "phone": "+905399225570", "source": "CV Upload - AI Parsed", "location": "Sakarya, Amerika", "projects": [{"role": "Co-founder and Leader", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "As Co-founder and leader, managed 15+ students and delivered 5+ real-world software projects, including AI-powered and disaster communication systems. Guided the team to the Teknofest Finals.", "achievements": ["Delivered 5+ real-world software projects.", "Developed award-winning tech projects like AAIA.", "Achieved a national 5th place ranking in Teknofest Finals through innovation and teamwork."], "project_name": "LOOP Software & Idea Development Team Projects (including AAIA, AI-powered and disaster communication systems)", "technologies": ["AI-powered systems", "Disaster communication systems"]}], "full_name": "Furkan Ulutaş", "languages": "Türkçe", "timestamp": "2025-12-20T14:07:56.620Z", "github_url": "https://github.com/furkanulutas0", "employee_id": "EMP-1766239676620", "institution": "Doğuş University", "soft_skills": "Project & Team Management, Communication & Coordination, Design Thinking, Troubleshooting, Planning, Team Player", "last_updated": "2025-12-20T14:07:56.620Z", "linkedin_url": "https://linkedin.com/in/Furkan-Ulutas", "volunteering": [{"role": "Co-founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "LOOP Software & Idea Development Team", "responsibilities": ["Managed 15+ students.", "Delivered 5+ real-world software projects, including AI-powered and disaster communication systems.", "Guided the team to the Teknofest Finals, achieving a national 5th place ranking."]}, {"role": "Chairman", "end_date": "", "is_current": false, "start_date": "", "organization": "Largest university club (500+ active members)", "responsibilities": ["Organized 10+ technical and career events and increasing engagement by 40%.", "Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community."]}], "certifications": "None", "field_of_study": "Software Engineering", "highest_degree": "BSc.", "processed_date": "2025-12-20T14:07:56.620Z", "profile_status": "Complete", "projects_count": 1, "current_company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "work_experience": [{"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2025-04", "location": {"city": "", "country": ""}, "job_title": "Software Development Intern", "is_current": true, "start_date": "2024-10", "achievements": [], "employment_type": "Internship", "responsibilities": ["Developed full-stack applications using .NET, React, and Azure DevOps.", "Collaborated with QA and DevOps teams to enhance software scalability."], "technologies_used": [".NET", "React", "Azure DevOps"]}, {"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2024-10", "location": {"city": "", "country": ""}, "job_title": "Product Owner Intern", "is_current": false, "start_date": "2024-06", "achievements": ["Contributed to on-time delivery of key product features."], "employment_type": "Internship", "responsibilities": ["Managed product backlog and prioritized tasks using Agile development methodologies.", "Defined user stories and acceptance criteria to align development with business goals.", "Facilitated communication between stakeholders and technical teams.", "Contributed to on-time delivery of key product features."], "technologies_used": ["Agile"]}], "current_position": "Software Development Intern", "technical_skills": "C#, TypeScript, Python, Java, .NET, ASP.NET, React, Next.js, NestJS, Node.js, Expo, Azure DevOps, GitHub Actions, Docker, SonarQube, ELK Stack, Grafana, MS SQL, PostgreSQL, Redis, NoSQL, Figma, Cursor", "education_details": [{"gpa": "", "degree": "BSc.", "thesis": "Focusing on full-stack development, software architecture, and DevOps practices.", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2022-06", "institution": "Doğuş University", "field_of_study": "Software Engineering"}, {"gpa": "", "degree": "Program", "thesis": "Completed an intensive English preparation program, enhancing academic and professional communication skills.", "courses": [], "end_date": "2022-06", "is_current": false, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "English Preparation"}], "original_filename": "unknown.pdf", "completeness_score": 95, "professional_title": "Software Engineering Student", "volunteering_count": 2, "raw_structured_data": {"awards": [{"date": "", "issuer": "Teknofest", "award_name": "National 5th place ranking at Teknofest Finals", "description": "Achieved through innovation and teamwork with the LOOP Software & Idea Development Team."}], "skills": {"languages": [{"language": "English", "proficiency": ""}], "soft_skills": ["Project & Team Management", "Communication & Coordination", "Design Thinking", "Troubleshooting", "Planning", "Team Player"], "technical_skills": [{"skills": ["C#", "TypeScript", "Python", "Java"], "skill_category": "Programming Languages"}, {"skills": [".NET", "ASP.NET", "React", "Next.js", "NestJS", "Node.js", "Expo"], "skill_category": "Frameworks & Libraries"}, {"skills": ["Azure DevOps", "GitHub Actions", "Docker", "SonarQube", "ELK Stack", "Grafana"], "skill_category": "DevOps & Tools"}, {"skills": ["MS SQL", "PostgreSQL", "Redis", "NoSQL"], "skill_category": "Databases"}, {"skills": ["Figma", "Cursor"], "skill_category": "Other Tools"}]}, "summary": {"short_summary": "I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using.NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.", "professional_title": "Software Engineering Student"}, "projects": [{"role": "Co-founder and Leader", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "As Co-founder and leader, managed 15+ students and delivered 5+ real-world software projects, including AI-powered and disaster communication systems. Guided the team to the Teknofest Finals.", "achievements": ["Delivered 5+ real-world software projects.", "Developed award-winning tech projects like AAIA.", "Achieved a national 5th place ranking in Teknofest Finals through innovation and teamwork."], "project_name": "LOOP Software & Idea Development Team Projects (including AAIA, AI-powered and disaster communication systems)", "technologies": ["AI-powered systems", "Disaster communication systems"]}], "education": [{"gpa": "", "degree": "BSc.", "thesis": "Focusing on full-stack development, software architecture, and DevOps practices.", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2022-06", "institution": "Doğuş University", "field_of_study": "Software Engineering"}, {"gpa": "", "degree": "Program", "thesis": "Completed an intensive English preparation program, enhancing academic and professional communication skills.", "courses": [], "end_date": "2022-06", "is_current": false, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "English Preparation"}], "publications": [], "volunteering": [{"role": "Co-founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "LOOP Software & Idea Development Team", "responsibilities": ["Managed 15+ students.", "Delivered 5+ real-world software projects, including AI-powered and disaster communication systems.", "Guided the team to the Teknofest Finals, achieving a national 5th place ranking."]}, {"role": "Chairman", "end_date": "", "is_current": false, "start_date": "", "organization": "Largest university club (500+ active members)", "responsibilities": ["Organized 10+ technical and career events and increasing engagement by 40%.", "Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community."]}], "certifications": [], "work_experience": [{"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2025-04", "location": {"city": "", "country": ""}, "job_title": "Software Development Intern", "is_current": true, "start_date": "2024-10", "achievements": [], "employment_type": "Internship", "responsibilities": ["Developed full-stack applications using .NET, React, and Azure DevOps.", "Collaborated with QA and DevOps teams to enhance software scalability."], "technologies_used": [".NET", "React", "Azure DevOps"]}, {"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2024-10", "location": {"city": "", "country": ""}, "job_title": "Product Owner Intern", "is_current": false, "start_date": "2024-06", "achievements": ["Contributed to on-time delivery of key product features."], "employment_type": "Internship", "responsibilities": ["Managed product backlog and prioritized tasks using Agile development methodologies.", "Defined user stories and acceptance criteria to align development with business goals.", "Facilitated communication between stakeholders and technical teams.", "Contributed to on-time delivery of key product features."], "technologies_used": ["Agile"]}], "personal_information": {"email": "furkanulutas054@gmail.com", "phone": "+90 5399225570", "gender": "", "github": "@furkanulutas0", "address": {"city": "", "street": "", "country": "", "postal_code": ""}, "website": "", "linkedin": "@Furkan-Ulutas", "full_name": "Furkan Ulutaş", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": ["Abc", "bca", "dba"], "availability": "Immediately", "driving_license": "Class B", "military_status": "Completed", "willing_to_travel": false, "willing_to_relocate": true}}, "certifications_count": 0, "professional_summary": "I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using.NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.", "total_experience_years": 1.5}	2025-12-20 14:07:54.362886+00
5	EMP-1766252302499	{"awards": [], "skills": {"languages": [{"language": "English", "proficiency": ""}], "soft_skills": ["Open to learning new technologies", "Team-oriented", "Responsible and disciplined", "Eager to learn and develop"], "technical_skills": [{"skills": ["Java", "Spring", "C#", ".NET", "Python"], "skill_category": "Backend"}, {"skills": ["HTML", "CSS", "Javascript"], "skill_category": "Frontend"}, {"skills": ["React", "Next.js", "Node.js"], "skill_category": "Framework"}, {"skills": ["React Native"], "skill_category": "Mobile App"}, {"skills": ["PostgreSQL"], "skill_category": "DB"}, {"skills": ["Jira", "Github"], "skill_category": "DevOps"}]}, "summary": {"short_summary": "I am a fourth-year Computer Engineering student at Doğuş University. I started my software journey with university courses in C++, C#, Java, and Python, building a strong programming foundation. I also completed a two-year associate degree in Web Design and Coding, independently learning HTML, CSS, and JavaScript to create and customize websites. To strengthen my backend and full-stack skills, I studied .NET, Next.js, Node.js, and PostgreSQL, gaining hands-on experience through various projects. I completed my first two internships at Akgün Group and my third internship at Depauli Systems, working on diverse projects and gaining valuable industry experience. Currently, I am an active member of DOU LOOP, our university's software and idea development team, where collaborating on team projects has been invaluable for my career growth and technical development.", "professional_title": "STUDENT OF COMPUTER ENGINEERING"}, "projects": [{"role": "Mobile Application - ReactNative", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "AAIA is a React Native mobile application developed to assist people during disaster situations, integrated with our custom-built modem. I actively contributed to both the software development and system enhancement processes. The application aims to ensure reliable communication and coordinated assistance in emergencies.", "achievements": ["achieved 5th place at Teknofest"], "project_name": "AAIA", "technologies": ["React Native"]}, {"role": "Mobile Application", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "DietAl is an AI-powered nutrition recommendation system designed to provide personalized meal plans and health suggestions by analyzing user data. I took part in the development of this platform, focusing on delivering accurate recommendations through intelligent algorithms.", "achievements": [], "project_name": "Dietal", "technologies": ["AI"]}, {"role": "Web Application - Gemini AI, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a web-based micro ERP system for SMEs to manage inventory, customer relations, and orders. Built with .NET (C#), Next.js, and PostgreSQL, and integrated Gemini-based AI modules for sales forecasting, price optimization, automated content generation, and trend analysis.", "achievements": [], "project_name": "Smart Micro ERP System", "technologies": [".NET", "C#", "Next.js", "PostgreSQL", "Gemini AI"]}, {"role": "Web Application - Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed an informational website for a law firm as a freelance project, using Next.js to deliver a fast, responsive, and SEO-friendly user experience.", "achievements": [], "project_name": "Law Firm Website", "technologies": ["Next.js"]}, {"role": "Web Application - Gemini AI, Cohere AI, ChatGPT, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a user-friendly platform with .NET C# (backend) and Next.js (frontend) that integrates three AI models in a single panel, enabling sequential prompt chaining and streamlined workflow management.", "achievements": [], "project_name": "Prompt Bridge", "technologies": [".NET C#", "Next.js", "Gemini AI", "Cohere AI", "ChatGPT"]}], "education": [{"gpa": "", "degree": "Bachelor's Degree", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering (%100 English)"}, {"gpa": "", "degree": "Associate Degree", "thesis": "", "courses": [], "end_date": "2023-06", "is_current": false, "start_date": "2021-09", "institution": "Anadolu University (Second University)", "field_of_study": "Web Design and Coding"}], "publications": [], "volunteering": [], "certifications": [{"name": "Pearson Assured Accreditation Certificate", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Pearson"}, {"name": "Data Analysis School - Artificial Intelligence Module", "issue_date": "2025-10-01", "credential_id": "", "credential_url": "", "expiration_date": "2026-04-30", "issuing_organization": "Marmara University (with the support of ITU, ODTU and Boğaziçi)"}], "work_experience": [{"company": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "end_date": "", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Software Developer", "is_current": true, "start_date": "2024-04", "achievements": [], "employment_type": "", "responsibilities": ["In addition to developing modern and scalable web projects using React, TypeScript, and Next.js, we design and implement innovative mobile applications with React Native and various other technologies.", "By participating in hackathons and various software competitions with our projects, we showcase our skills, enhance our teamwork, and improve our problem-solving abilities."], "technologies_used": ["React", "TypeScript", "Next.js", "React Native"]}, {"company": "Akgün Group", "end_date": "2024-09", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2024-08", "achievements": [], "employment_type": "", "responsibilities": ["Gaining experience with PostgreSQL databases, I developed web projects using React and Next.js.", "Throughout this process, I had the opportunity to gain industry insight and hands-on experience."], "technologies_used": ["PostgreSQL", "React", "Next.js"]}, {"company": "Akgün Group", "end_date": "2025-08", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-07", "achievements": [], "employment_type": "", "responsibilities": ["I developed a web-based micro ERP system using .NET (C#), Next.js, and PostgreSQL.", "Integrated Gemini AI modules to enable sales forecasting, price optimization, automated product content generation, and market trend analysis."], "technologies_used": [".NET", "C#", "Next.js", "PostgreSQL", "Gemini AI"]}, {"company": "Depauli Systems", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "", "responsibilities": ["During my internship, I developed Prompt Bridge a user-friendly platform using .NET C# (backend) and Next.js (frontend).", "The system integrates three different AI models into a single panel, enabling a sequential structure where the output of one model automatically becomes the input of the next."], "technologies_used": [".NET C#", "Next.js", "AI models"]}], "personal_information": {"email": "zeynepnurgungor@icloud.com", "phone": "0533 390 36 83", "gender": "", "github": "github.com/Zypgungorr", "address": {"city": "Istanbul", "street": "", "country": "Turkey", "postal_code": ""}, "website": "", "linkedin": "linkedin.com/in/zeynepgngr/", "full_name": "ZEYNEPNUR GÜNGÖR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}	{"email": "zeynepnurgungor@icloud.com", "phone": "05333903683", "source": "CV Upload - AI Parsed", "location": "Istanbul, Turkey", "projects": [{"role": "Mobile Application - ReactNative", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "AAIA is a React Native mobile application developed to assist people during disaster situations, integrated with our custom-built modem. I actively contributed to both the software development and system enhancement processes. The application aims to ensure reliable communication and coordinated assistance in emergencies.", "achievements": ["achieved 5th place at Teknofest"], "project_name": "AAIA", "technologies": ["React Native"]}, {"role": "Mobile Application", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "DietAl is an AI-powered nutrition recommendation system designed to provide personalized meal plans and health suggestions by analyzing user data. I took part in the development of this platform, focusing on delivering accurate recommendations through intelligent algorithms.", "achievements": [], "project_name": "Dietal", "technologies": ["AI"]}, {"role": "Web Application - Gemini AI, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a web-based micro ERP system for SMEs to manage inventory, customer relations, and orders. Built with .NET (C#), Next.js, and PostgreSQL, and integrated Gemini-based AI modules for sales forecasting, price optimization, automated content generation, and trend analysis.", "achievements": [], "project_name": "Smart Micro ERP System", "technologies": [".NET", "C#", "Next.js", "PostgreSQL", "Gemini AI"]}, {"role": "Web Application - Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed an informational website for a law firm as a freelance project, using Next.js to deliver a fast, responsive, and SEO-friendly user experience.", "achievements": [], "project_name": "Law Firm Website", "technologies": ["Next.js"]}, {"role": "Web Application - Gemini AI, Cohere AI, ChatGPT, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a user-friendly platform with .NET C# (backend) and Next.js (frontend) that integrates three AI models in a single panel, enabling sequential prompt chaining and streamlined workflow management.", "achievements": [], "project_name": "Prompt Bridge", "technologies": [".NET C#", "Next.js", "Gemini AI", "Cohere AI", "ChatGPT"]}], "full_name": "ZEYNEPNUR GÜNGÖR", "languages": "English", "timestamp": "2025-12-20T17:38:22.499Z", "github_url": "https://github.com/github.com/Zypgungorr", "employee_id": "EMP-1766252302499", "institution": "Dogus University", "soft_skills": "Open to learning new technologies, Team-oriented, Responsible and disciplined, Eager to learn and develop", "last_updated": "2025-12-20T17:38:22.500Z", "linkedin_url": "https://linkedin.com/in/linkedin.com/in/zeynepgngr/", "volunteering": [], "certifications": "Pearson Assured Accreditation Certificate, Data Analysis School - Artificial Intelligence Module", "field_of_study": "Computer Engineering (%100 English)", "highest_degree": "Bachelor's Degree", "processed_date": "2025-12-20T17:38:22.500Z", "profile_status": "Complete", "projects_count": 5, "current_company": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "work_experience": [{"company": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "end_date": "", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Software Developer", "is_current": true, "start_date": "2024-04", "achievements": [], "employment_type": "", "responsibilities": ["In addition to developing modern and scalable web projects using React, TypeScript, and Next.js, we design and implement innovative mobile applications with React Native and various other technologies.", "By participating in hackathons and various software competitions with our projects, we showcase our skills, enhance our teamwork, and improve our problem-solving abilities."], "technologies_used": ["React", "TypeScript", "Next.js", "React Native"]}, {"company": "Akgün Group", "end_date": "2024-09", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2024-08", "achievements": [], "employment_type": "", "responsibilities": ["Gaining experience with PostgreSQL databases, I developed web projects using React and Next.js.", "Throughout this process, I had the opportunity to gain industry insight and hands-on experience."], "technologies_used": ["PostgreSQL", "React", "Next.js"]}, {"company": "Akgün Group", "end_date": "2025-08", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-07", "achievements": [], "employment_type": "", "responsibilities": ["I developed a web-based micro ERP system using .NET (C#), Next.js, and PostgreSQL.", "Integrated Gemini AI modules to enable sales forecasting, price optimization, automated product content generation, and market trend analysis."], "technologies_used": [".NET", "C#", "Next.js", "PostgreSQL", "Gemini AI"]}, {"company": "Depauli Systems", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "", "responsibilities": ["During my internship, I developed Prompt Bridge a user-friendly platform using .NET C# (backend) and Next.js (frontend).", "The system integrates three different AI models into a single panel, enabling a sequential structure where the output of one model automatically becomes the input of the next."], "technologies_used": [".NET C#", "Next.js", "AI models"]}], "current_position": "Software Developer", "technical_skills": "Java, Spring, C#, .NET, Python, HTML, CSS, Javascript, React, Next.js, Node.js, React Native, PostgreSQL, Jira, Github", "education_details": [{"gpa": "", "degree": "Bachelor's Degree", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering (%100 English)"}, {"gpa": "", "degree": "Associate Degree", "thesis": "", "courses": [], "end_date": "2023-06", "is_current": false, "start_date": "2021-09", "institution": "Anadolu University (Second University)", "field_of_study": "Web Design and Coding"}], "original_filename": "unknown.pdf", "completeness_score": 100, "professional_title": "STUDENT OF COMPUTER ENGINEERING", "volunteering_count": 0, "raw_structured_data": {"awards": [], "skills": {"languages": [{"language": "English", "proficiency": ""}], "soft_skills": ["Open to learning new technologies", "Team-oriented", "Responsible and disciplined", "Eager to learn and develop"], "technical_skills": [{"skills": ["Java", "Spring", "C#", ".NET", "Python"], "skill_category": "Backend"}, {"skills": ["HTML", "CSS", "Javascript"], "skill_category": "Frontend"}, {"skills": ["React", "Next.js", "Node.js"], "skill_category": "Framework"}, {"skills": ["React Native"], "skill_category": "Mobile App"}, {"skills": ["PostgreSQL"], "skill_category": "DB"}, {"skills": ["Jira", "Github"], "skill_category": "DevOps"}]}, "summary": {"short_summary": "I am a fourth-year Computer Engineering student at Doğuş University. I started my software journey with university courses in C++, C#, Java, and Python, building a strong programming foundation. I also completed a two-year associate degree in Web Design and Coding, independently learning HTML, CSS, and JavaScript to create and customize websites. To strengthen my backend and full-stack skills, I studied .NET, Next.js, Node.js, and PostgreSQL, gaining hands-on experience through various projects. I completed my first two internships at Akgün Group and my third internship at Depauli Systems, working on diverse projects and gaining valuable industry experience. Currently, I am an active member of DOU LOOP, our university's software and idea development team, where collaborating on team projects has been invaluable for my career growth and technical development.", "professional_title": "STUDENT OF COMPUTER ENGINEERING"}, "projects": [{"role": "Mobile Application - ReactNative", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "AAIA is a React Native mobile application developed to assist people during disaster situations, integrated with our custom-built modem. I actively contributed to both the software development and system enhancement processes. The application aims to ensure reliable communication and coordinated assistance in emergencies.", "achievements": ["achieved 5th place at Teknofest"], "project_name": "AAIA", "technologies": ["React Native"]}, {"role": "Mobile Application", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "DietAl is an AI-powered nutrition recommendation system designed to provide personalized meal plans and health suggestions by analyzing user data. I took part in the development of this platform, focusing on delivering accurate recommendations through intelligent algorithms.", "achievements": [], "project_name": "Dietal", "technologies": ["AI"]}, {"role": "Web Application - Gemini AI, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a web-based micro ERP system for SMEs to manage inventory, customer relations, and orders. Built with .NET (C#), Next.js, and PostgreSQL, and integrated Gemini-based AI modules for sales forecasting, price optimization, automated content generation, and trend analysis.", "achievements": [], "project_name": "Smart Micro ERP System", "technologies": [".NET", "C#", "Next.js", "PostgreSQL", "Gemini AI"]}, {"role": "Web Application - Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed an informational website for a law firm as a freelance project, using Next.js to deliver a fast, responsive, and SEO-friendly user experience.", "achievements": [], "project_name": "Law Firm Website", "technologies": ["Next.js"]}, {"role": "Web Application - Gemini AI, Cohere AI, ChatGPT, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a user-friendly platform with .NET C# (backend) and Next.js (frontend) that integrates three AI models in a single panel, enabling sequential prompt chaining and streamlined workflow management.", "achievements": [], "project_name": "Prompt Bridge", "technologies": [".NET C#", "Next.js", "Gemini AI", "Cohere AI", "ChatGPT"]}], "education": [{"gpa": "", "degree": "Bachelor's Degree", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering (%100 English)"}, {"gpa": "", "degree": "Associate Degree", "thesis": "", "courses": [], "end_date": "2023-06", "is_current": false, "start_date": "2021-09", "institution": "Anadolu University (Second University)", "field_of_study": "Web Design and Coding"}], "publications": [], "volunteering": [], "certifications": [{"name": "Pearson Assured Accreditation Certificate", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Pearson"}, {"name": "Data Analysis School - Artificial Intelligence Module", "issue_date": "2025-10-01", "credential_id": "", "credential_url": "", "expiration_date": "2026-04-30", "issuing_organization": "Marmara University (with the support of ITU, ODTU and Boğaziçi)"}], "work_experience": [{"company": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "end_date": "", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Software Developer", "is_current": true, "start_date": "2024-04", "achievements": [], "employment_type": "", "responsibilities": ["In addition to developing modern and scalable web projects using React, TypeScript, and Next.js, we design and implement innovative mobile applications with React Native and various other technologies.", "By participating in hackathons and various software competitions with our projects, we showcase our skills, enhance our teamwork, and improve our problem-solving abilities."], "technologies_used": ["React", "TypeScript", "Next.js", "React Native"]}, {"company": "Akgün Group", "end_date": "2024-09", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2024-08", "achievements": [], "employment_type": "", "responsibilities": ["Gaining experience with PostgreSQL databases, I developed web projects using React and Next.js.", "Throughout this process, I had the opportunity to gain industry insight and hands-on experience."], "technologies_used": ["PostgreSQL", "React", "Next.js"]}, {"company": "Akgün Group", "end_date": "2025-08", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-07", "achievements": [], "employment_type": "", "responsibilities": ["I developed a web-based micro ERP system using .NET (C#), Next.js, and PostgreSQL.", "Integrated Gemini AI modules to enable sales forecasting, price optimization, automated product content generation, and market trend analysis."], "technologies_used": [".NET", "C#", "Next.js", "PostgreSQL", "Gemini AI"]}, {"company": "Depauli Systems", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "", "responsibilities": ["During my internship, I developed Prompt Bridge a user-friendly platform using .NET C# (backend) and Next.js (frontend).", "The system integrates three different AI models into a single panel, enabling a sequential structure where the output of one model automatically becomes the input of the next."], "technologies_used": [".NET C#", "Next.js", "AI models"]}], "personal_information": {"email": "zeynepnurgungor@icloud.com", "phone": "0533 390 36 83", "gender": "", "github": "github.com/Zypgungorr", "address": {"city": "Istanbul", "street": "", "country": "Turkey", "postal_code": ""}, "website": "", "linkedin": "linkedin.com/in/zeynepgngr/", "full_name": "ZEYNEPNUR GÜNGÖR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}, "certifications_count": 2, "professional_summary": "I am a fourth-year Computer Engineering student at Doğuş University. I started my software journey with university courses in C++, C#, Java, and Python, building a strong programming foundation. I also completed a two-year associate degree in Web Design and Coding, independently learning HTML, CSS, and JavaScript to create and customize websites. To strengthen my backend and full-stack skills, I studied .NET, Next.js, Node.js, and PostgreSQL, gaining hands-on experience through various projects. I completed my first two internships at Akgün Group and my third internship at Depauli Systems, working on diverse projects and gaining valuable industry experience. Currently, I am an active member of DOU LOOP, our university's software and idea development team, where collaborating on team projects has been invaluable for my career growth and technical development.", "total_experience_years": 1.9}	2025-12-20 17:38:20.827172+00
6	EMP-1766254966950	{"awards": [], "skills": {"languages": [{"language": "English", "proficiency": ""}], "soft_skills": ["Open to learning new technologies", "Team-oriented", "Responsible and disciplined", "Eager to learn and develop"], "technical_skills": [{"skills": ["Java", "Spring", "C#", ".NET", "Python"], "skill_category": "Backend"}, {"skills": ["HTML", "CSS", "Javascript"], "skill_category": "Frontend"}, {"skills": ["React", "Next.js", "Node.js"], "skill_category": "Framework"}, {"skills": ["React Native"], "skill_category": "Mobile App"}, {"skills": ["PostgreSQL"], "skill_category": "DB"}, {"skills": ["Jira", "Github"], "skill_category": "DevOps"}]}, "summary": {"short_summary": "I am a fourth-year Computer Engineering student at Doğuş University. I started my software journey with university courses in C++, C#, Java, and Python, building a strong programming foundation. I also completed a two-year associate degree in Web Design and Coding, independently learning HTML, CSS, and JavaScript to create and customize websites. To strengthen my backend and full-stack skills, I studied .NET, Next.js, Node.js, and PostgreSQL, gaining hands-on experience through various projects. I completed my first two internships at Akgün Group and my third internship at Depauli Systems, working on diverse projects and gaining valuable industry experience. Currently, I am an active member of DOU LOOP, our university's software and idea development team, where collaborating on team projects has been invaluable for my career growth and technical development.", "professional_title": "STUDENT OF COMPUTER ENGINEERING"}, "projects": [{"role": "Mobile Application - ReactNative", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "AAIA is a React Native mobile application developed to assist people during disaster situations, integrated with our custom-built modem. I actively contributed to both the software development and system enhancement processes. The application aims to ensure reliable communication and coordinated assistance in emergencies.", "achievements": ["achieved 5th place at Teknofest"], "project_name": "AAIA", "technologies": ["React Native"]}, {"role": "Mobile Application", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "DietAl is an AI-powered nutrition recommendation system designed to provide personalized meal plans and health suggestions by analyzing user data. I took part in the development of this platform, focusing on delivering accurate recommendations through intelligent algorithms.", "achievements": [], "project_name": "DietAl", "technologies": ["AI"]}, {"role": "Web Application - Gemini AI, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a web-based micro ERP system for SMEs to manage inventory, customer relations, and orders. Built with .NET (C#), Next.js, and PostgreSQL, and integrated Gemini-based AI modules for sales forecasting, price optimization, automated content generation, and trend analysis.", "achievements": [], "project_name": "Smart Micro ERP System", "technologies": [".NET (C#)", "Next.js", "PostgreSQL", "Gemini AI"]}, {"role": "Web Application - Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed an informational website for a law firm as a freelance project, using Next.js to deliver a fast, responsive, and SEO-friendly user experience.", "achievements": [], "project_name": "Law Firm Website", "technologies": ["Next.js"]}, {"role": "Web Application - Gemini AI, Cohere AI, ChatGPT, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a user-friendly platform with .NET C# (backend) and Next.js (frontend) that integrates three AI models in a single panel, enabling sequential prompt chaining and streamlined workflow management.", "achievements": [], "project_name": "Prompt Bridge", "technologies": [".NET C#", "Next.js", "Gemini AI", "Cohere AI", "ChatGPT"]}], "education": [{"gpa": "", "degree": "Bachelor", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}, {"gpa": "", "degree": "Associate Degree", "thesis": "", "courses": [], "end_date": "2023-06", "is_current": false, "start_date": "2021-09", "institution": "Anadolu University", "field_of_study": "Web Design and Coding"}], "publications": [], "volunteering": [], "certifications": [{"name": "Pearson Assured Accreditation Certificate", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Pearson"}, {"name": "Data Analysis School - Artificial Intelligence Module", "issue_date": "2025-10-01", "credential_id": "", "credential_url": "", "expiration_date": "2026-04-30", "issuing_organization": "Marmara University (with the support of ITU, ODTU and Boğaziçi)"}], "work_experience": [{"company": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "Software Developer", "is_current": true, "start_date": "2024-04", "achievements": [], "employment_type": "", "responsibilities": ["In addition to developing modern and scalable web projects using React, TypeScript, and Next.js, we design and implement innovative mobile applications with React Native and various other technologies.", "By participating in hackathons and various software competitions with our projects, we showcase our skills, enhance our teamwork, and improve our problem-solving abilities."], "technologies_used": ["React", "TypeScript", "Next.js", "React Native"]}, {"company": "Akgün Group", "end_date": "2024-09", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2024-08", "achievements": [], "employment_type": "", "responsibilities": ["Gaining experience with PostgreSQL databases, I developed web projects using React and Next.js.", "Throughout this process, I had the opportunity to gain industry insight and hands-on experience."], "technologies_used": ["PostgreSQL", "React", "Next.js"]}, {"company": "Akgün Group", "end_date": "2025-08", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-07", "achievements": [], "employment_type": "", "responsibilities": ["I developed a web-based micro ERP system using .NET (C#), Next.js, and PostgreSQL.", "Integrated Gemini AI modules to enable sales forecasting, price optimization, automated product content generation, and market trend analysis."], "technologies_used": [".NET (C#)", "Next.js", "PostgreSQL", "Gemini AI"]}, {"company": "Depauli Systems", "end_date": "2025-09", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "", "responsibilities": ["During my internship, I developed Prompt Bridge a user-friendly platform using .NET C# (backend) and Next.js (frontend).", "The system integrates three different AI models into a single panel, enabling a sequential structure where the output of one model automatically becomes the input of the next."], "technologies_used": [".NET C#", "Next.js"]}], "personal_information": {"email": "zeynepnurgungor@icloud.com", "phone": "0533 390 36 83", "gender": "", "github": "github.com/Zypgungorr", "address": {"city": "Istanbul", "street": "", "country": "Turkey", "postal_code": ""}, "website": "", "linkedin": "linkedin.com/in/zeynepgngr/", "full_name": "ZEYNEPNUR GÜNGÖR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}	{"email": "zeynepnurgungor@icloud.com", "phone": "05333903683", "source": "CV Upload - AI Parsed", "location": "Istanbul, Turkey", "projects": [{"role": "Mobile Application - ReactNative", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "AAIA is a React Native mobile application developed to assist people during disaster situations, integrated with our custom-built modem. I actively contributed to both the software development and system enhancement processes. The application aims to ensure reliable communication and coordinated assistance in emergencies.", "achievements": ["achieved 5th place at Teknofest"], "project_name": "AAIA", "technologies": ["React Native"]}, {"role": "Mobile Application", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "DietAl is an AI-powered nutrition recommendation system designed to provide personalized meal plans and health suggestions by analyzing user data. I took part in the development of this platform, focusing on delivering accurate recommendations through intelligent algorithms.", "achievements": [], "project_name": "DietAl", "technologies": ["AI"]}, {"role": "Web Application - Gemini AI, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a web-based micro ERP system for SMEs to manage inventory, customer relations, and orders. Built with .NET (C#), Next.js, and PostgreSQL, and integrated Gemini-based AI modules for sales forecasting, price optimization, automated content generation, and trend analysis.", "achievements": [], "project_name": "Smart Micro ERP System", "technologies": [".NET (C#)", "Next.js", "PostgreSQL", "Gemini AI"]}, {"role": "Web Application - Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed an informational website for a law firm as a freelance project, using Next.js to deliver a fast, responsive, and SEO-friendly user experience.", "achievements": [], "project_name": "Law Firm Website", "technologies": ["Next.js"]}, {"role": "Web Application - Gemini AI, Cohere AI, ChatGPT, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a user-friendly platform with .NET C# (backend) and Next.js (frontend) that integrates three AI models in a single panel, enabling sequential prompt chaining and streamlined workflow management.", "achievements": [], "project_name": "Prompt Bridge", "technologies": [".NET C#", "Next.js", "Gemini AI", "Cohere AI", "ChatGPT"]}], "full_name": "ZEYNEPNUR GÜNGÖR", "languages": "English", "timestamp": "2025-12-20T18:22:46.950Z", "github_url": "https://github.com/github.com/Zypgungorr", "employee_id": "EMP-1766254966950", "institution": "Dogus University", "soft_skills": "Open to learning new technologies, Team-oriented, Responsible and disciplined, Eager to learn and develop", "last_updated": "2025-12-20T18:22:46.950Z", "linkedin_url": "https://linkedin.com/in/linkedin.com/in/zeynepgngr/", "volunteering": [], "certifications": "Pearson Assured Accreditation Certificate, Data Analysis School - Artificial Intelligence Module", "field_of_study": "Computer Engineering", "highest_degree": "Bachelor", "processed_date": "2025-12-20T18:22:46.950Z", "profile_status": "Complete", "projects_count": 5, "current_company": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "work_experience": [{"company": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "Software Developer", "is_current": true, "start_date": "2024-04", "achievements": [], "employment_type": "", "responsibilities": ["In addition to developing modern and scalable web projects using React, TypeScript, and Next.js, we design and implement innovative mobile applications with React Native and various other technologies.", "By participating in hackathons and various software competitions with our projects, we showcase our skills, enhance our teamwork, and improve our problem-solving abilities."], "technologies_used": ["React", "TypeScript", "Next.js", "React Native"]}, {"company": "Akgün Group", "end_date": "2024-09", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2024-08", "achievements": [], "employment_type": "", "responsibilities": ["Gaining experience with PostgreSQL databases, I developed web projects using React and Next.js.", "Throughout this process, I had the opportunity to gain industry insight and hands-on experience."], "technologies_used": ["PostgreSQL", "React", "Next.js"]}, {"company": "Akgün Group", "end_date": "2025-08", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-07", "achievements": [], "employment_type": "", "responsibilities": ["I developed a web-based micro ERP system using .NET (C#), Next.js, and PostgreSQL.", "Integrated Gemini AI modules to enable sales forecasting, price optimization, automated product content generation, and market trend analysis."], "technologies_used": [".NET (C#)", "Next.js", "PostgreSQL", "Gemini AI"]}, {"company": "Depauli Systems", "end_date": "2025-09", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "", "responsibilities": ["During my internship, I developed Prompt Bridge a user-friendly platform using .NET C# (backend) and Next.js (frontend).", "The system integrates three different AI models into a single panel, enabling a sequential structure where the output of one model automatically becomes the input of the next."], "technologies_used": [".NET C#", "Next.js"]}], "current_position": "Software Developer", "technical_skills": "Java, Spring, C#, .NET, Python, HTML, CSS, Javascript, React, Next.js, Node.js, React Native, PostgreSQL, Jira, Github", "education_details": [{"gpa": "", "degree": "Bachelor", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}, {"gpa": "", "degree": "Associate Degree", "thesis": "", "courses": [], "end_date": "2023-06", "is_current": false, "start_date": "2021-09", "institution": "Anadolu University", "field_of_study": "Web Design and Coding"}], "original_filename": "unknown.pdf", "completeness_score": 100, "professional_title": "STUDENT OF COMPUTER ENGINEERING", "volunteering_count": 0, "raw_structured_data": {"awards": [], "skills": {"languages": [{"language": "English", "proficiency": ""}], "soft_skills": ["Open to learning new technologies", "Team-oriented", "Responsible and disciplined", "Eager to learn and develop"], "technical_skills": [{"skills": ["Java", "Spring", "C#", ".NET", "Python"], "skill_category": "Backend"}, {"skills": ["HTML", "CSS", "Javascript"], "skill_category": "Frontend"}, {"skills": ["React", "Next.js", "Node.js"], "skill_category": "Framework"}, {"skills": ["React Native"], "skill_category": "Mobile App"}, {"skills": ["PostgreSQL"], "skill_category": "DB"}, {"skills": ["Jira", "Github"], "skill_category": "DevOps"}]}, "summary": {"short_summary": "I am a fourth-year Computer Engineering student at Doğuş University. I started my software journey with university courses in C++, C#, Java, and Python, building a strong programming foundation. I also completed a two-year associate degree in Web Design and Coding, independently learning HTML, CSS, and JavaScript to create and customize websites. To strengthen my backend and full-stack skills, I studied .NET, Next.js, Node.js, and PostgreSQL, gaining hands-on experience through various projects. I completed my first two internships at Akgün Group and my third internship at Depauli Systems, working on diverse projects and gaining valuable industry experience. Currently, I am an active member of DOU LOOP, our university's software and idea development team, where collaborating on team projects has been invaluable for my career growth and technical development.", "professional_title": "STUDENT OF COMPUTER ENGINEERING"}, "projects": [{"role": "Mobile Application - ReactNative", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "AAIA is a React Native mobile application developed to assist people during disaster situations, integrated with our custom-built modem. I actively contributed to both the software development and system enhancement processes. The application aims to ensure reliable communication and coordinated assistance in emergencies.", "achievements": ["achieved 5th place at Teknofest"], "project_name": "AAIA", "technologies": ["React Native"]}, {"role": "Mobile Application", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "DietAl is an AI-powered nutrition recommendation system designed to provide personalized meal plans and health suggestions by analyzing user data. I took part in the development of this platform, focusing on delivering accurate recommendations through intelligent algorithms.", "achievements": [], "project_name": "DietAl", "technologies": ["AI"]}, {"role": "Web Application - Gemini AI, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a web-based micro ERP system for SMEs to manage inventory, customer relations, and orders. Built with .NET (C#), Next.js, and PostgreSQL, and integrated Gemini-based AI modules for sales forecasting, price optimization, automated content generation, and trend analysis.", "achievements": [], "project_name": "Smart Micro ERP System", "technologies": [".NET (C#)", "Next.js", "PostgreSQL", "Gemini AI"]}, {"role": "Web Application - Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed an informational website for a law firm as a freelance project, using Next.js to deliver a fast, responsive, and SEO-friendly user experience.", "achievements": [], "project_name": "Law Firm Website", "technologies": ["Next.js"]}, {"role": "Web Application - Gemini AI, Cohere AI, ChatGPT, .NET, Next.js", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Developed a user-friendly platform with .NET C# (backend) and Next.js (frontend) that integrates three AI models in a single panel, enabling sequential prompt chaining and streamlined workflow management.", "achievements": [], "project_name": "Prompt Bridge", "technologies": [".NET C#", "Next.js", "Gemini AI", "Cohere AI", "ChatGPT"]}], "education": [{"gpa": "", "degree": "Bachelor", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}, {"gpa": "", "degree": "Associate Degree", "thesis": "", "courses": [], "end_date": "2023-06", "is_current": false, "start_date": "2021-09", "institution": "Anadolu University", "field_of_study": "Web Design and Coding"}], "publications": [], "volunteering": [], "certifications": [{"name": "Pearson Assured Accreditation Certificate", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Pearson"}, {"name": "Data Analysis School - Artificial Intelligence Module", "issue_date": "2025-10-01", "credential_id": "", "credential_url": "", "expiration_date": "2026-04-30", "issuing_organization": "Marmara University (with the support of ITU, ODTU and Boğaziçi)"}], "work_experience": [{"company": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "Software Developer", "is_current": true, "start_date": "2024-04", "achievements": [], "employment_type": "", "responsibilities": ["In addition to developing modern and scalable web projects using React, TypeScript, and Next.js, we design and implement innovative mobile applications with React Native and various other technologies.", "By participating in hackathons and various software competitions with our projects, we showcase our skills, enhance our teamwork, and improve our problem-solving abilities."], "technologies_used": ["React", "TypeScript", "Next.js", "React Native"]}, {"company": "Akgün Group", "end_date": "2024-09", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2024-08", "achievements": [], "employment_type": "", "responsibilities": ["Gaining experience with PostgreSQL databases, I developed web projects using React and Next.js.", "Throughout this process, I had the opportunity to gain industry insight and hands-on experience."], "technologies_used": ["PostgreSQL", "React", "Next.js"]}, {"company": "Akgün Group", "end_date": "2025-08", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-07", "achievements": [], "employment_type": "", "responsibilities": ["I developed a web-based micro ERP system using .NET (C#), Next.js, and PostgreSQL.", "Integrated Gemini AI modules to enable sales forecasting, price optimization, automated product content generation, and market trend analysis."], "technologies_used": [".NET (C#)", "Next.js", "PostgreSQL", "Gemini AI"]}, {"company": "Depauli Systems", "end_date": "2025-09", "location": {"city": "Istanbul", "country": "Turkey"}, "job_title": "Intern Engineer", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "", "responsibilities": ["During my internship, I developed Prompt Bridge a user-friendly platform using .NET C# (backend) and Next.js (frontend).", "The system integrates three different AI models into a single panel, enabling a sequential structure where the output of one model automatically becomes the input of the next."], "technologies_used": [".NET C#", "Next.js"]}], "personal_information": {"email": "zeynepnurgungor@icloud.com", "phone": "0533 390 36 83", "gender": "", "github": "github.com/Zypgungorr", "address": {"city": "Istanbul", "street": "", "country": "Turkey", "postal_code": ""}, "website": "", "linkedin": "linkedin.com/in/zeynepgngr/", "full_name": "ZEYNEPNUR GÜNGÖR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}, "certifications_count": 2, "professional_summary": "I am a fourth-year Computer Engineering student at Doğuş University. I started my software journey with university courses in C++, C#, Java, and Python, building a strong programming foundation. I also completed a two-year associate degree in Web Design and Coding, independently learning HTML, CSS, and JavaScript to create and customize websites. To strengthen my backend and full-stack skills, I studied .NET, Next.js, Node.js, and PostgreSQL, gaining hands-on experience through various projects. I completed my first two internships at Akgün Group and my third internship at Depauli Systems, working on diverse projects and gaining valuable industry experience. Currently, I am an active member of DOU LOOP, our university's software and idea development team, where collaborating on team projects has been invaluable for my career growth and technical development.", "total_experience_years": 1.9}	2025-12-20 18:22:45.100317+00
7	EMP-1766255177864	{"awards": [{"date": "", "issuer": "Teknofest", "award_name": "National 5th Place Ranking", "description": "Achieved by guiding the LOOP Software & Idea Development Team to the Teknofest Finals through innovation and teamwork."}], "skills": {"languages": [], "soft_skills": ["Project & Team Management", "Communication & Coordination", "Design Thinking", "Troubleshooting", "Planning", "Team Player"], "technical_skills": [{"skills": ["C#", "TypeScript", "Python", "Java"], "skill_category": "Programming Languages"}, {"skills": [".NET", "ASP.NET", "React", "Next.js", "NestJS", "Node.js", "Expo"], "skill_category": "Frameworks & Libraries"}, {"skills": ["Azure DevOps", "GitHub Actions", "Docker", "SonarQube", "ELK Stack", "Grafana"], "skill_category": "DevOps & Tools"}, {"skills": ["MS SQL", "PostgreSQL", "Redis", "NoSQL"], "skill_category": "Databases"}, {"skills": ["Figma", "Cursor"], "skill_category": "Other Tools"}]}, "summary": {"short_summary": "I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using.NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.", "professional_title": "Software Engineering Student"}, "projects": [], "education": [{"gpa": "", "degree": "BSc.", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "Software Engineering"}, {"gpa": "", "degree": "Program", "thesis": "", "courses": [], "end_date": "2022-06", "is_current": false, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "English Preparation Program"}], "publications": [], "volunteering": [{"role": "Co-founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "LOOP Software & Idea Development Team", "responsibilities": ["Managed 15+ students", "Delivered 5+ real-world software projects, including AI-powered and disaster communication systems", "Guided the team to the Teknofest Finals, achieving a national 5th place ranking through innovation and teamwork."]}, {"role": "Chair", "end_date": "", "is_current": false, "start_date": "", "organization": "University Club", "responsibilities": ["Chaired one of the largest university clubs with 500+ active members", "Organized 10+ technical and career events", "Increased engagement by 40%", "Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community."]}], "certifications": [], "work_experience": [{"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2025-04", "location": {"city": "", "country": ""}, "job_title": "Software Development Intern", "is_current": false, "start_date": "2024-10", "achievements": [], "employment_type": "Internship", "responsibilities": ["Developed full-stack applications using .NET, React, and Azure DevOps.", "Collaborated with QA and DevOps teams to enhance software scalability."], "technologies_used": [".NET", "React", "Azure DevOps"]}, {"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2024-10", "location": {"city": "", "country": ""}, "job_title": "Product Owner Intern", "is_current": false, "start_date": "2024-06", "achievements": [], "employment_type": "Internship", "responsibilities": ["Managed product backlog and prioritized tasks using Agile development methodologies.", "Defined user stories and acceptance criteria to align development with business goals.", "Facilitated communication between stakeholders and technical teams.", "Contributed to on-time delivery of key product features."], "technologies_used": ["Agile"]}], "personal_information": {"email": "furkanulutas054@gmail.com", "phone": "+90 5399225570", "gender": "", "github": "https://github.com/furkanulutas0", "address": {"city": "", "street": "", "country": "", "postal_code": ""}, "website": "", "linkedin": "https://www.linkedin.com/in/Furkan-Ulutas", "full_name": "Furkan Ulutaş", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": ["aabb", "cc", "dd"], "availability": "Immediately", "driving_license": "Class B", "military_status": "Postponed", "willing_to_travel": false, "willing_to_relocate": true}}	{"email": "furkanulutas054@gmail.com", "phone": "+905399225570", "source": "CV Upload - AI Parsed", "location": "İstanbul, Türkiye", "projects": [], "full_name": "Furkan Ulutaş", "languages": "Türkçe", "timestamp": "2025-12-20T18:26:17.864Z", "github_url": "https://github.com/furkanulutas0", "employee_id": "EMP-1766255177864", "institution": "Doğuş University", "soft_skills": "Project & Team Management, Communication & Coordination, Design Thinking, Troubleshooting, Planning, Team Player", "last_updated": "2025-12-20T18:26:17.864Z", "linkedin_url": "https://www.linkedin.com/in/Furkan-Ulutas", "volunteering": [{"role": "Co-founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "LOOP Software & Idea Development Team", "responsibilities": ["Managed 15+ students", "Delivered 5+ real-world software projects, including AI-powered and disaster communication systems", "Guided the team to the Teknofest Finals, achieving a national 5th place ranking through innovation and teamwork."]}, {"role": "Chair", "end_date": "", "is_current": false, "start_date": "", "organization": "University Club", "responsibilities": ["Chaired one of the largest university clubs with 500+ active members", "Organized 10+ technical and career events", "Increased engagement by 40%", "Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community."]}], "certifications": "None", "field_of_study": "Software Engineering", "highest_degree": "BSc.", "processed_date": "2025-12-20T18:26:17.864Z", "profile_status": "Complete", "projects_count": 0, "current_company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "work_experience": [{"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2025-04", "location": {"city": "", "country": ""}, "job_title": "Software Development Intern", "is_current": false, "start_date": "2024-10", "achievements": [], "employment_type": "Internship", "responsibilities": ["Developed full-stack applications using .NET, React, and Azure DevOps.", "Collaborated with QA and DevOps teams to enhance software scalability."], "technologies_used": [".NET", "React", "Azure DevOps"]}, {"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2024-10", "location": {"city": "", "country": ""}, "job_title": "Product Owner Intern", "is_current": false, "start_date": "2024-06", "achievements": [], "employment_type": "Internship", "responsibilities": ["Managed product backlog and prioritized tasks using Agile development methodologies.", "Defined user stories and acceptance criteria to align development with business goals.", "Facilitated communication between stakeholders and technical teams.", "Contributed to on-time delivery of key product features."], "technologies_used": ["Agile"]}], "current_position": "Software Development Intern", "technical_skills": "C#, TypeScript, Python, Java, .NET, ASP.NET, React, Next.js, NestJS, Node.js, Expo, Azure DevOps, GitHub Actions, Docker, SonarQube, ELK Stack, Grafana, MS SQL, PostgreSQL, Redis, NoSQL, Figma, Cursor", "education_details": [{"gpa": "", "degree": "BSc.", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "Software Engineering"}, {"gpa": "", "degree": "Program", "thesis": "", "courses": [], "end_date": "2022-06", "is_current": false, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "English Preparation Program"}], "original_filename": "unknown.pdf", "completeness_score": 90, "professional_title": "Software Engineering Student", "volunteering_count": 2, "raw_structured_data": {"awards": [{"date": "", "issuer": "Teknofest", "award_name": "National 5th Place Ranking", "description": "Achieved by guiding the LOOP Software & Idea Development Team to the Teknofest Finals through innovation and teamwork."}], "skills": {"languages": [], "soft_skills": ["Project & Team Management", "Communication & Coordination", "Design Thinking", "Troubleshooting", "Planning", "Team Player"], "technical_skills": [{"skills": ["C#", "TypeScript", "Python", "Java"], "skill_category": "Programming Languages"}, {"skills": [".NET", "ASP.NET", "React", "Next.js", "NestJS", "Node.js", "Expo"], "skill_category": "Frameworks & Libraries"}, {"skills": ["Azure DevOps", "GitHub Actions", "Docker", "SonarQube", "ELK Stack", "Grafana"], "skill_category": "DevOps & Tools"}, {"skills": ["MS SQL", "PostgreSQL", "Redis", "NoSQL"], "skill_category": "Databases"}, {"skills": ["Figma", "Cursor"], "skill_category": "Other Tools"}]}, "summary": {"short_summary": "I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using.NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.", "professional_title": "Software Engineering Student"}, "projects": [], "education": [{"gpa": "", "degree": "BSc.", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "Software Engineering"}, {"gpa": "", "degree": "Program", "thesis": "", "courses": [], "end_date": "2022-06", "is_current": false, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "English Preparation Program"}], "publications": [], "volunteering": [{"role": "Co-founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "LOOP Software & Idea Development Team", "responsibilities": ["Managed 15+ students", "Delivered 5+ real-world software projects, including AI-powered and disaster communication systems", "Guided the team to the Teknofest Finals, achieving a national 5th place ranking through innovation and teamwork."]}, {"role": "Chair", "end_date": "", "is_current": false, "start_date": "", "organization": "University Club", "responsibilities": ["Chaired one of the largest university clubs with 500+ active members", "Organized 10+ technical and career events", "Increased engagement by 40%", "Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community."]}], "certifications": [], "work_experience": [{"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2025-04", "location": {"city": "", "country": ""}, "job_title": "Software Development Intern", "is_current": false, "start_date": "2024-10", "achievements": [], "employment_type": "Internship", "responsibilities": ["Developed full-stack applications using .NET, React, and Azure DevOps.", "Collaborated with QA and DevOps teams to enhance software scalability."], "technologies_used": [".NET", "React", "Azure DevOps"]}, {"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2024-10", "location": {"city": "", "country": ""}, "job_title": "Product Owner Intern", "is_current": false, "start_date": "2024-06", "achievements": [], "employment_type": "Internship", "responsibilities": ["Managed product backlog and prioritized tasks using Agile development methodologies.", "Defined user stories and acceptance criteria to align development with business goals.", "Facilitated communication between stakeholders and technical teams.", "Contributed to on-time delivery of key product features."], "technologies_used": ["Agile"]}], "personal_information": {"email": "furkanulutas054@gmail.com", "phone": "+90 5399225570", "gender": "", "github": "https://github.com/furkanulutas0", "address": {"city": "", "street": "", "country": "", "postal_code": ""}, "website": "", "linkedin": "https://www.linkedin.com/in/Furkan-Ulutas", "full_name": "Furkan Ulutaş", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": ["aabb", "cc", "dd"], "availability": "Immediately", "driving_license": "Class B", "military_status": "Postponed", "willing_to_travel": false, "willing_to_relocate": true}}, "certifications_count": 0, "professional_summary": "I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using.NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.", "total_experience_years": 0.8}	2025-12-20 18:26:15.919585+00
8	EMP-1766398835588	{"awards": [], "skills": {"languages": [{"language": "İngilizce", "proficiency": "Pre - Intermediate"}], "soft_skills": [], "technical_skills": [{"skills": ["C", "C++", "Java", "Python"], "skill_category": "Programming Languages"}, {"skills": ["SQL"], "skill_category": "Databases"}, {"skills": ["React Native", "Spring Boot", "React"], "skill_category": "Frameworks / Libraries"}, {"skills": ["HTML", "CSS"], "skill_category": "Web Technologies"}, {"skills": ["MS Office Programları"], "skill_category": "Software / Tools"}]}, "summary": {"short_summary": "2023 yılı itibariyle Doğuş Üniversitesi, Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.", "professional_title": "Yazılım Mühendisliği Öğrencisi"}, "projects": [{"role": "Yazılım Geliştirici", "links": [], "end_date": "", "is_current": true, "start_date": "2025-01", "description": "A Takımında yazılım geliştirici olarak aktif bir şekilde ve Java kullanarak projeler geliştiriyorum. Mevcut projelere katkı sağlıyorum. Takım içinde işbirliği yaparak, karşılaştığımız zorluklara yaratıcı çözümler geliştirmeye odaklanıyorum. Teknik becerilerimi ve problem çözme yeteneklerimi geliştiriyorum.", "achievements": [], "project_name": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "technologies": ["Java"]}, {"role": "Yazılım Geliştirme Core Team Üyesi", "links": [], "end_date": "2025-01", "is_current": false, "start_date": "2023-12", "description": "Core Team üyesi olarak yazılım projelerinde yer aldım. Yazılım mühendisliği bilgimi pratiğe dökme fırsatı bulurken, React Native öğrendim. Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim.", "achievements": [], "project_name": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "technologies": ["React Native"]}], "education": [{"gpa": "", "degree": "", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2023-09", "institution": "Doğuş Üniversitesi", "field_of_study": "Yazılım Mühendisliği"}], "publications": [], "volunteering": [{"role": "Başkan Yardımcısı", "end_date": "2025-11", "is_current": false, "start_date": "2025-01", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.", "Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı."]}, {"role": "Genel Sekreter", "end_date": "2025-01", "is_current": false, "start_date": "2024-09", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Kulübün idari işleyişini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.", "Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim."]}, {"role": "Koordinasyon Kurulu Üyesi", "end_date": "2024-09", "is_current": false, "start_date": "2024-01", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim."]}], "certifications": [{"name": "Turkcell Geleceği Yazanlar - Python 101 - 401", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Turkcell Geleceği Yazanlar"}, {"name": "Turkcell Geleceği Yazanlar - NLP", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Turkcell Geleceği Yazanlar"}, {"name": "Doğuş Üniversitesi - Mikroişlemci ve IoT 101", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Doğuş Üniversitesi"}, {"name": "Cisco - NDG Linux Unhatched", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Cisco - CyberOPS Associate", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Cisco - Introduction To Cybersecurity", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Cisco CCNA:Introduction to Networks", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}], "work_experience": [{"company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "end_date": "2024-09", "location": {"city": "", "country": ""}, "job_title": "Yapay Zeka Ar-Ge Stajyeri", "is_current": false, "start_date": "2024-07", "achievements": [], "employment_type": "Internship", "responsibilities": ["Bu staj sürecinde, Node.js ve Pythonla yapay zeka destekli bir LMS projesi geliştirdim.", "Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.", "Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.", "Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim."], "technologies_used": ["Node.js", "Python", "Yapay Zeka (AI)", "Chatbot"]}, {"company": "ETİYA BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Stajyeri", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "Internship", "responsibilities": ["Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.", "Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.", "Backend tarafında PostgreSQL kullanarak relational veritabanı tasarladım ve REST API'leri geliştirdim.", "Frontend tarafında React ile responsive bir arayüz oluşturdum.", "Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım."], "technologies_used": ["Spring Boot", "React", "JWT", "PostgreSQL", "REST API"]}], "personal_information": {"email": "elanurdemir100@gmail.com", "phone": "", "gender": "", "github": "", "address": {"city": "İstanbul", "street": "Üsküdar", "country": "", "postal_code": ""}, "website": "", "linkedin": "in/elanurdemir", "full_name": "ELANUR DEMİR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": ["mmmm"], "availability": "Immediately", "driving_license": "Class B", "military_status": "Not Applicable", "willing_to_travel": true, "willing_to_relocate": true}}	{"email": "elanurdemir100@gmail.com", "phone": "", "source": "CV Upload - AI Parsed", "location": "İstanbul", "projects": [{"role": "Yazılım Geliştirici", "links": [], "end_date": "", "is_current": true, "start_date": "2025-01", "description": "A Takımında yazılım geliştirici olarak aktif bir şekilde ve Java kullanarak projeler geliştiriyorum. Mevcut projelere katkı sağlıyorum. Takım içinde işbirliği yaparak, karşılaştığımız zorluklara yaratıcı çözümler geliştirmeye odaklanıyorum. Teknik becerilerimi ve problem çözme yeteneklerimi geliştiriyorum.", "achievements": [], "project_name": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "technologies": ["Java"]}, {"role": "Yazılım Geliştirme Core Team Üyesi", "links": [], "end_date": "2025-01", "is_current": false, "start_date": "2023-12", "description": "Core Team üyesi olarak yazılım projelerinde yer aldım. Yazılım mühendisliği bilgimi pratiğe dökme fırsatı bulurken, React Native öğrendim. Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim.", "achievements": [], "project_name": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "technologies": ["React Native"]}], "full_name": "ELANUR DEMİR", "languages": "İngilizce (Pre - Intermediate)", "timestamp": "2025-12-22T10:20:35.588Z", "github_url": "", "employee_id": "EMP-1766398835588", "institution": "Doğuş Üniversitesi", "soft_skills": "Not Specified", "last_updated": "2025-12-22T10:20:35.589Z", "linkedin_url": "https://linkedin.com/in/in/elanurdemir", "volunteering": [{"role": "Başkan Yardımcısı", "end_date": "2025-11", "is_current": false, "start_date": "2025-01", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.", "Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı."]}, {"role": "Genel Sekreter", "end_date": "2025-01", "is_current": false, "start_date": "2024-09", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Kulübün idari işleyişini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.", "Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim."]}, {"role": "Koordinasyon Kurulu Üyesi", "end_date": "2024-09", "is_current": false, "start_date": "2024-01", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim."]}], "certifications": "Turkcell Geleceği Yazanlar - Python 101 - 401, Turkcell Geleceği Yazanlar - NLP, Doğuş Üniversitesi - Mikroişlemci ve IoT 101, Cisco - NDG Linux Unhatched, Cisco - CyberOPS Associate, Cisco - Introduction To Cybersecurity, Cisco CCNA:Introduction to Networks", "field_of_study": "Yazılım Mühendisliği", "highest_degree": "Not Specified", "processed_date": "2025-12-22T10:20:35.589Z", "profile_status": "Complete", "projects_count": 2, "current_company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "work_experience": [{"company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "end_date": "2024-09", "location": {"city": "", "country": ""}, "job_title": "Yapay Zeka Ar-Ge Stajyeri", "is_current": false, "start_date": "2024-07", "achievements": [], "employment_type": "Internship", "responsibilities": ["Bu staj sürecinde, Node.js ve Pythonla yapay zeka destekli bir LMS projesi geliştirdim.", "Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.", "Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.", "Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim."], "technologies_used": ["Node.js", "Python", "Yapay Zeka (AI)", "Chatbot"]}, {"company": "ETİYA BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Stajyeri", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "Internship", "responsibilities": ["Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.", "Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.", "Backend tarafında PostgreSQL kullanarak relational veritabanı tasarladım ve REST API'leri geliştirdim.", "Frontend tarafında React ile responsive bir arayüz oluşturdum.", "Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım."], "technologies_used": ["Spring Boot", "React", "JWT", "PostgreSQL", "REST API"]}], "current_position": "Yapay Zeka Ar-Ge Stajyeri", "technical_skills": "C, C++, Java, Python, SQL, React Native, Spring Boot, React, HTML, CSS, MS Office Programları", "education_details": [{"gpa": "", "degree": "", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2023-09", "institution": "Doğuş Üniversitesi", "field_of_study": "Yazılım Mühendisliği"}], "original_filename": "unknown.pdf", "completeness_score": 90, "professional_title": "Yazılım Mühendisliği Öğrencisi", "volunteering_count": 3, "raw_structured_data": {"awards": [], "skills": {"languages": [{"language": "İngilizce", "proficiency": "Pre - Intermediate"}], "soft_skills": [], "technical_skills": [{"skills": ["C", "C++", "Java", "Python"], "skill_category": "Programming Languages"}, {"skills": ["SQL"], "skill_category": "Databases"}, {"skills": ["React Native", "Spring Boot", "React"], "skill_category": "Frameworks / Libraries"}, {"skills": ["HTML", "CSS"], "skill_category": "Web Technologies"}, {"skills": ["MS Office Programları"], "skill_category": "Software / Tools"}]}, "summary": {"short_summary": "2023 yılı itibariyle Doğuş Üniversitesi, Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.", "professional_title": "Yazılım Mühendisliği Öğrencisi"}, "projects": [{"role": "Yazılım Geliştirici", "links": [], "end_date": "", "is_current": true, "start_date": "2025-01", "description": "A Takımında yazılım geliştirici olarak aktif bir şekilde ve Java kullanarak projeler geliştiriyorum. Mevcut projelere katkı sağlıyorum. Takım içinde işbirliği yaparak, karşılaştığımız zorluklara yaratıcı çözümler geliştirmeye odaklanıyorum. Teknik becerilerimi ve problem çözme yeteneklerimi geliştiriyorum.", "achievements": [], "project_name": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "technologies": ["Java"]}, {"role": "Yazılım Geliştirme Core Team Üyesi", "links": [], "end_date": "2025-01", "is_current": false, "start_date": "2023-12", "description": "Core Team üyesi olarak yazılım projelerinde yer aldım. Yazılım mühendisliği bilgimi pratiğe dökme fırsatı bulurken, React Native öğrendim. Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim.", "achievements": [], "project_name": "DOU LOOP \\"Yazılım ve Fikir Geliştirme\\" Takımı", "technologies": ["React Native"]}], "education": [{"gpa": "", "degree": "", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2023-09", "institution": "Doğuş Üniversitesi", "field_of_study": "Yazılım Mühendisliği"}], "publications": [], "volunteering": [{"role": "Başkan Yardımcısı", "end_date": "2025-11", "is_current": false, "start_date": "2025-01", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.", "Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı."]}, {"role": "Genel Sekreter", "end_date": "2025-01", "is_current": false, "start_date": "2024-09", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Kulübün idari işleyişini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.", "Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim."]}, {"role": "Koordinasyon Kurulu Üyesi", "end_date": "2024-09", "is_current": false, "start_date": "2024-01", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim."]}], "certifications": [{"name": "Turkcell Geleceği Yazanlar - Python 101 - 401", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Turkcell Geleceği Yazanlar"}, {"name": "Turkcell Geleceği Yazanlar - NLP", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Turkcell Geleceği Yazanlar"}, {"name": "Doğuş Üniversitesi - Mikroişlemci ve IoT 101", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Doğuş Üniversitesi"}, {"name": "Cisco - NDG Linux Unhatched", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Cisco - CyberOPS Associate", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Cisco - Introduction To Cybersecurity", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Cisco CCNA:Introduction to Networks", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}], "work_experience": [{"company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "end_date": "2024-09", "location": {"city": "", "country": ""}, "job_title": "Yapay Zeka Ar-Ge Stajyeri", "is_current": false, "start_date": "2024-07", "achievements": [], "employment_type": "Internship", "responsibilities": ["Bu staj sürecinde, Node.js ve Pythonla yapay zeka destekli bir LMS projesi geliştirdim.", "Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.", "Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.", "Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim."], "technologies_used": ["Node.js", "Python", "Yapay Zeka (AI)", "Chatbot"]}, {"company": "ETİYA BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Stajyeri", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "Internship", "responsibilities": ["Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.", "Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.", "Backend tarafında PostgreSQL kullanarak relational veritabanı tasarladım ve REST API'leri geliştirdim.", "Frontend tarafında React ile responsive bir arayüz oluşturdum.", "Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım."], "technologies_used": ["Spring Boot", "React", "JWT", "PostgreSQL", "REST API"]}], "personal_information": {"email": "elanurdemir100@gmail.com", "phone": "", "gender": "", "github": "", "address": {"city": "İstanbul", "street": "Üsküdar", "country": "", "postal_code": ""}, "website": "", "linkedin": "in/elanurdemir", "full_name": "ELANUR DEMİR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": ["mmmm"], "availability": "Immediately", "driving_license": "Class B", "military_status": "Not Applicable", "willing_to_travel": true, "willing_to_relocate": true}}, "certifications_count": 7, "professional_summary": "2023 yılı itibariyle Doğuş Üniversitesi, Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.", "total_experience_years": 0.3}	2025-12-22 10:20:33.930098+00
9	EMP-1766436935343	{"awards": [], "skills": {"languages": [{"language": "İngilizce", "proficiency": "Pre - Intermediate"}], "soft_skills": ["Takım çalışması", "Etkili iletişim", "Araştırma", "Öğrenme", "Planlama", "Azim", "Problem çözme"], "technical_skills": [{"skills": ["C", "C++", "Java", "Python", "SQL"], "skill_category": "Programming Languages"}, {"skills": ["React Native", "Spring Boot", "React"], "skill_category": "Frameworks/Libraries"}, {"skills": ["HTML", "CSS", "REST API", "JWT"], "skill_category": "Web Technologies"}, {"skills": ["PostgreSQL"], "skill_category": "Databases"}, {"skills": ["Linux"], "skill_category": "Operating Systems"}, {"skills": ["MS Office Programs"], "skill_category": "Tools & Software"}, {"skills": ["CyberOPS", "Introduction To Cybersecurity"], "skill_category": "Cybersecurity"}, {"skills": ["Yapay Zeka (AI)"], "skill_category": "AI/ML"}, {"skills": ["Mikroişlemci ve IoT"], "skill_category": "IoT"}, {"skills": ["CCNA:Introduction to Networks"], "skill_category": "Networking"}]}, "summary": {"short_summary": "2023 yılı itibariyle Doğuş Üniversitesi, Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.", "professional_title": "YAZILIM MÜHENDİSLİĞİ ÖĞRENCİSİ"}, "projects": [{"role": "Yazılım Geliştirici", "links": [], "end_date": "", "is_current": true, "start_date": "2025-01", "description": "A Takımında yazılım geliştirici olarak aktif bir şekilde ve Java kullanarak projeler geliştiriyorum. Mevcut projelere katkı sağlıyorum. Takım içinde işbirliği yaparak, karşılaştığımız zorluklara yaratıcı çözümler geliştirmeye odaklanıyorum. Teknik becerilerimi ve problem çözme yeteneklerimi geliştiriyorum.", "achievements": [], "project_name": "Yazılım ve Fikir Geliştirme Takımı", "technologies": ["Java"]}, {"role": "Yazılım Geliştirme Core Team Üyesi", "links": [], "end_date": "2025-01", "is_current": false, "start_date": "2023-04", "description": "Core Team üyesi olarak yazılım projelerinde yer aldım. Yazılım mühendisliği bilgimi pratiğe dökme fırsatı bulurken, React Native öğrendim. Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim.", "achievements": [], "project_name": "Yazılım ve Fikir Geliştirme Takımı", "technologies": ["React Native"]}], "education": [{"gpa": "", "degree": "Lisans", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2023-XX", "institution": "Doğuş Üniversitesi", "field_of_study": "Yazılım Mühendisliği"}], "publications": [], "volunteering": [{"role": "Başkan Yardımcısı", "end_date": "2025-11", "is_current": false, "start_date": "2025-10", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.", "Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı."]}, {"role": "Genel Sekreter", "end_date": "2025-01", "is_current": false, "start_date": "2024-09", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Kulübün idari işleyişini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.", "Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim."]}, {"role": "Koordinasyon Kurulu Üyesi", "end_date": "2024-09", "is_current": false, "start_date": "2024-01", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim."]}], "certifications": [{"name": "Python 101 - 401", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Turkcell Geleceği Yazanlar"}, {"name": "NLP", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Turkcell Geleceği Yazanlar"}, {"name": "NDG Linux Unhatched", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Mikroişlemci ve IoT 101", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Doğuş Üniversitesi"}, {"name": "CyberOPS Associate", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Introduction To Cybersecurity", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "CCNA:Introduction to Networks", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}], "work_experience": [{"company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "end_date": "2024-09", "location": {"city": "", "country": ""}, "job_title": "Yapay Zeka Ar-Ge Stajyeri", "is_current": false, "start_date": "2024-07", "achievements": [], "employment_type": "Internship", "responsibilities": ["Bu staj sürecinde, Node.js ve Pythonla yapay zeka destekli bir LMS projesi geliştirdim.", "Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.", "Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.", "Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim."], "technologies_used": ["Node.js", "Python", "Yapay Zeka"]}, {"company": "ETİYA BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Stajyeri", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "Internship", "responsibilities": ["Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.", "Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.", "Backend tarafında PostgreSQL kullanarak relational veritabanı tasarladım ve REST API'leri geliştirdim.", "Frontend tarafında React ile responsive bir arayüz oluşturdum.", "Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım."], "technologies_used": ["Spring Boot", "React", "JWT", "PostgreSQL", "REST API"]}], "personal_information": {"email": "elanurdemir100@gmail.com", "phone": "", "gender": "", "github": "", "address": {"city": "İstanbul", "street": "Üsküdar", "country": "Turkey", "postal_code": ""}, "website": "", "linkedin": "in/elanurdemir", "full_name": "ELANUR DEMİR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}	{"email": "elanurdemir100@gmail.com", "phone": "", "source": "CV Upload - AI Parsed", "location": "İstanbul, Turkey", "projects": [{"role": "Yazılım Geliştirici", "links": [], "end_date": "", "is_current": true, "start_date": "2025-01", "description": "A Takımında yazılım geliştirici olarak aktif bir şekilde ve Java kullanarak projeler geliştiriyorum. Mevcut projelere katkı sağlıyorum. Takım içinde işbirliği yaparak, karşılaştığımız zorluklara yaratıcı çözümler geliştirmeye odaklanıyorum. Teknik becerilerimi ve problem çözme yeteneklerimi geliştiriyorum.", "achievements": [], "project_name": "Yazılım ve Fikir Geliştirme Takımı", "technologies": ["Java"]}, {"role": "Yazılım Geliştirme Core Team Üyesi", "links": [], "end_date": "2025-01", "is_current": false, "start_date": "2023-04", "description": "Core Team üyesi olarak yazılım projelerinde yer aldım. Yazılım mühendisliği bilgimi pratiğe dökme fırsatı bulurken, React Native öğrendim. Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim.", "achievements": [], "project_name": "Yazılım ve Fikir Geliştirme Takımı", "technologies": ["React Native"]}], "full_name": "ELANUR DEMİR", "languages": "İngilizce (Pre - Intermediate)", "timestamp": "2025-12-22T20:55:35.343Z", "github_url": "", "employee_id": "EMP-1766436935343", "institution": "Doğuş Üniversitesi", "soft_skills": "Takım çalışması, Etkili iletişim, Araştırma, Öğrenme, Planlama, Azim, Problem çözme", "last_updated": "2025-12-22T20:55:35.344Z", "linkedin_url": "https://linkedin.com/in/in/elanurdemir", "volunteering": [{"role": "Başkan Yardımcısı", "end_date": "2025-11", "is_current": false, "start_date": "2025-10", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.", "Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı."]}, {"role": "Genel Sekreter", "end_date": "2025-01", "is_current": false, "start_date": "2024-09", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Kulübün idari işleyişini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.", "Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim."]}, {"role": "Koordinasyon Kurulu Üyesi", "end_date": "2024-09", "is_current": false, "start_date": "2024-01", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim."]}], "certifications": "Python 101 - 401, NLP, NDG Linux Unhatched, Mikroişlemci ve IoT 101, CyberOPS Associate, Introduction To Cybersecurity, CCNA:Introduction to Networks", "field_of_study": "Yazılım Mühendisliği", "highest_degree": "Lisans", "processed_date": "2025-12-22T20:55:35.344Z", "profile_status": "Complete", "projects_count": 2, "current_company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "work_experience": [{"company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "end_date": "2024-09", "location": {"city": "", "country": ""}, "job_title": "Yapay Zeka Ar-Ge Stajyeri", "is_current": false, "start_date": "2024-07", "achievements": [], "employment_type": "Internship", "responsibilities": ["Bu staj sürecinde, Node.js ve Pythonla yapay zeka destekli bir LMS projesi geliştirdim.", "Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.", "Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.", "Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim."], "technologies_used": ["Node.js", "Python", "Yapay Zeka"]}, {"company": "ETİYA BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Stajyeri", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "Internship", "responsibilities": ["Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.", "Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.", "Backend tarafında PostgreSQL kullanarak relational veritabanı tasarladım ve REST API'leri geliştirdim.", "Frontend tarafında React ile responsive bir arayüz oluşturdum.", "Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım."], "technologies_used": ["Spring Boot", "React", "JWT", "PostgreSQL", "REST API"]}], "current_position": "Yapay Zeka Ar-Ge Stajyeri", "technical_skills": "C, C++, Java, Python, SQL, React Native, Spring Boot, React, HTML, CSS, REST API, JWT, PostgreSQL, Linux, MS Office Programs, CyberOPS, Introduction To Cybersecurity, Yapay Zeka (AI), Mikroişlemci ve IoT, CCNA:Introduction to Networks", "education_details": [{"gpa": "", "degree": "Lisans", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2023-XX", "institution": "Doğuş Üniversitesi", "field_of_study": "Yazılım Mühendisliği"}], "original_filename": "unknown.pdf", "completeness_score": 95, "professional_title": "YAZILIM MÜHENDİSLİĞİ ÖĞRENCİSİ", "volunteering_count": 3, "raw_structured_data": {"awards": [], "skills": {"languages": [{"language": "İngilizce", "proficiency": "Pre - Intermediate"}], "soft_skills": ["Takım çalışması", "Etkili iletişim", "Araştırma", "Öğrenme", "Planlama", "Azim", "Problem çözme"], "technical_skills": [{"skills": ["C", "C++", "Java", "Python", "SQL"], "skill_category": "Programming Languages"}, {"skills": ["React Native", "Spring Boot", "React"], "skill_category": "Frameworks/Libraries"}, {"skills": ["HTML", "CSS", "REST API", "JWT"], "skill_category": "Web Technologies"}, {"skills": ["PostgreSQL"], "skill_category": "Databases"}, {"skills": ["Linux"], "skill_category": "Operating Systems"}, {"skills": ["MS Office Programs"], "skill_category": "Tools & Software"}, {"skills": ["CyberOPS", "Introduction To Cybersecurity"], "skill_category": "Cybersecurity"}, {"skills": ["Yapay Zeka (AI)"], "skill_category": "AI/ML"}, {"skills": ["Mikroişlemci ve IoT"], "skill_category": "IoT"}, {"skills": ["CCNA:Introduction to Networks"], "skill_category": "Networking"}]}, "summary": {"short_summary": "2023 yılı itibariyle Doğuş Üniversitesi, Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.", "professional_title": "YAZILIM MÜHENDİSLİĞİ ÖĞRENCİSİ"}, "projects": [{"role": "Yazılım Geliştirici", "links": [], "end_date": "", "is_current": true, "start_date": "2025-01", "description": "A Takımında yazılım geliştirici olarak aktif bir şekilde ve Java kullanarak projeler geliştiriyorum. Mevcut projelere katkı sağlıyorum. Takım içinde işbirliği yaparak, karşılaştığımız zorluklara yaratıcı çözümler geliştirmeye odaklanıyorum. Teknik becerilerimi ve problem çözme yeteneklerimi geliştiriyorum.", "achievements": [], "project_name": "Yazılım ve Fikir Geliştirme Takımı", "technologies": ["Java"]}, {"role": "Yazılım Geliştirme Core Team Üyesi", "links": [], "end_date": "2025-01", "is_current": false, "start_date": "2023-04", "description": "Core Team üyesi olarak yazılım projelerinde yer aldım. Yazılım mühendisliği bilgimi pratiğe dökme fırsatı bulurken, React Native öğrendim. Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim.", "achievements": [], "project_name": "Yazılım ve Fikir Geliştirme Takımı", "technologies": ["React Native"]}], "education": [{"gpa": "", "degree": "Lisans", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2023-XX", "institution": "Doğuş Üniversitesi", "field_of_study": "Yazılım Mühendisliği"}], "publications": [], "volunteering": [{"role": "Başkan Yardımcısı", "end_date": "2025-11", "is_current": false, "start_date": "2025-10", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.", "Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı."]}, {"role": "Genel Sekreter", "end_date": "2025-01", "is_current": false, "start_date": "2024-09", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Kulübün idari işleyişini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.", "Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim."]}, {"role": "Koordinasyon Kurulu Üyesi", "end_date": "2024-09", "is_current": false, "start_date": "2024-01", "organization": "DOU Mühendis Beyinler Kulübü", "responsibilities": ["Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim."]}], "certifications": [{"name": "Python 101 - 401", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Turkcell Geleceği Yazanlar"}, {"name": "NLP", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Turkcell Geleceği Yazanlar"}, {"name": "NDG Linux Unhatched", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Mikroişlemci ve IoT 101", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Doğuş Üniversitesi"}, {"name": "CyberOPS Associate", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "Introduction To Cybersecurity", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "CCNA:Introduction to Networks", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}], "work_experience": [{"company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "end_date": "2024-09", "location": {"city": "", "country": ""}, "job_title": "Yapay Zeka Ar-Ge Stajyeri", "is_current": false, "start_date": "2024-07", "achievements": [], "employment_type": "Internship", "responsibilities": ["Bu staj sürecinde, Node.js ve Pythonla yapay zeka destekli bir LMS projesi geliştirdim.", "Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.", "Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.", "Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim."], "technologies_used": ["Node.js", "Python", "Yapay Zeka"]}, {"company": "ETİYA BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Stajyeri", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "Internship", "responsibilities": ["Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.", "Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.", "Backend tarafında PostgreSQL kullanarak relational veritabanı tasarladım ve REST API'leri geliştirdim.", "Frontend tarafında React ile responsive bir arayüz oluşturdum.", "Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım."], "technologies_used": ["Spring Boot", "React", "JWT", "PostgreSQL", "REST API"]}], "personal_information": {"email": "elanurdemir100@gmail.com", "phone": "", "gender": "", "github": "", "address": {"city": "İstanbul", "street": "Üsküdar", "country": "Turkey", "postal_code": ""}, "website": "", "linkedin": "in/elanurdemir", "full_name": "ELANUR DEMİR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}, "certifications_count": 7, "professional_summary": "2023 yılı itibariyle Doğuş Üniversitesi, Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.", "total_experience_years": 0.3}	2025-12-22 20:55:33.328939+00
10	EMP-1766519202434	{"awards": [], "skills": {"languages": [], "soft_skills": ["Takım Çalışması", "Etkili İletişim", "Araştırma", "Öğrenme Odaklılık", "Planlama", "Azimli"], "technical_skills": [{"skills": ["C++", "C#", "Java", "Python", "SQL", "React Native", "HTML/CSS"], "skill_category": "Programlama Dilleri"}, {"skills": ["Spring Boot", "React", "React.js", "Node.js"], "skill_category": "Frameworks & Libraries"}, {"skills": ["PostgreSQL"], "skill_category": "Veritabanları"}, {"skills": ["MS Office Programları", "JWT", "REST API", "Yapay Zeka", "Chatbot"], "skill_category": "Araçlar & Teknolojiler"}, {"skills": ["Linux"], "skill_category": "İşletim Sistemleri"}]}, "summary": {"short_summary": "2023 yılı itibarıyla Doğuş Üniversitesi Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.", "professional_title": "YAZILIM MÜHENDİSLİĞİ ÖĞRENCİSİ"}, "projects": [], "education": [{"gpa": "", "degree": "Lisans", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2021-09", "institution": "Doğuş Üniversitesi", "field_of_study": "Yazılım Mühendisliği"}], "publications": [], "volunteering": [{"role": "Başkan Yardımcısı", "end_date": "2025-05", "is_current": false, "start_date": "2025-02", "organization": "Dönemeyim Mühendisler Kulübü", "responsibilities": ["Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.", "Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı."]}, {"role": "Genel Sekreter", "end_date": "2024-05", "is_current": false, "start_date": "2024-02", "organization": "Dönemeyim Mühendisler Kulübü", "responsibilities": ["Kulübün idari işlevini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.", "Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim."]}, {"role": "Koordinasyon Kurulu Üyesi", "end_date": "2024-05", "is_current": false, "start_date": "2024-02", "organization": "Doğuş Üniversitesi Yazılım Mühendisliği", "responsibilities": ["Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim."]}], "certifications": [{"name": "Python 101 - 401", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Türkcell Geleceği Yazanlar"}, {"name": "NLP", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Türkcell Geleceği Yazanlar"}, {"name": "Mikroişlemci ve IoT 101", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Doğuş Üniversitesi"}, {"name": "Introduction To Cybersecurity", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "CCNA Introduction to Networks", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "NDG Linux Unhatched", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "CyberOps Associate", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}], "work_experience": [{"company": "ETKİ YERİ BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Stajyeri", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "Stajyer", "responsibilities": ["Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.", "Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.", "Back-end tarafında PostgreSQL relational database kullandım ve REST API'leri geliştirdim.", "Frontend tarafında ise React.js ile responsive arayüz oluşturdum.", "Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım."], "technologies_used": ["Spring Boot", "React", "JWT", "PostgreSQL", "REST API", "React.js"]}, {"company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "end_date": "2024-09", "location": {"city": "", "country": ""}, "job_title": "Yapay Zeka Ar-Ge Stajyeri", "is_current": false, "start_date": "2024-07", "achievements": [], "employment_type": "Stajyer", "responsibilities": ["Bu staj sürecinde, Node.js ve Python'la yapay zeka destekli bir LMS projesi geliştirdim.", "Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.", "Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.", "Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim."], "technologies_used": ["Node.js", "Python", "Yapay Zeka", "Chatbot"]}, {"company": "DOĞUŞ LOUP 'Yazılım ve Fikir Geliştirme' Takımı", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Core Team Üyesi", "is_current": true, "start_date": "2023-04", "achievements": [], "employment_type": "Part-time", "responsibilities": ["Yazılım Mühendisliği projelerinde yer aldım.", "Yazılım mühendisliği bilimi pratiğe dökme fırsatı bulurken, React Native öğreniyorum.", "Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim."], "technologies_used": ["React Native"]}], "personal_information": {"email": "elanurdemirr1000@gmail.com", "phone": "+90 547 650 80 13", "gender": "", "github": "", "address": {"city": "İstanbul", "street": "", "country": "Türkiye", "postal_code": ""}, "website": "", "linkedin": "linkedin.com/in/elanurdemirr", "full_name": "ELANUR DEMİR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}	{"email": "elanurdemirr1000@gmail.com", "phone": "+905476508013", "source": "CV Upload - AI Parsed", "location": "İstanbul, Türkiye", "projects": [], "full_name": "ELANUR DEMİR", "languages": "Not Specified", "timestamp": "2025-12-23T19:46:42.435Z", "github_url": "", "employee_id": "EMP-1766519202434", "institution": "Doğuş Üniversitesi", "soft_skills": "Takım Çalışması, Etkili İletişim, Araştırma, Öğrenme Odaklılık, Planlama, Azimli", "last_updated": "2025-12-23T19:46:42.436Z", "linkedin_url": "https://linkedin.com/in/linkedin.com/in/elanurdemirr", "volunteering": [{"role": "Başkan Yardımcısı", "end_date": "2025-05", "is_current": false, "start_date": "2025-02", "organization": "Dönemeyim Mühendisler Kulübü", "responsibilities": ["Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.", "Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı."]}, {"role": "Genel Sekreter", "end_date": "2024-05", "is_current": false, "start_date": "2024-02", "organization": "Dönemeyim Mühendisler Kulübü", "responsibilities": ["Kulübün idari işlevini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.", "Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim."]}, {"role": "Koordinasyon Kurulu Üyesi", "end_date": "2024-05", "is_current": false, "start_date": "2024-02", "organization": "Doğuş Üniversitesi Yazılım Mühendisliği", "responsibilities": ["Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim."]}], "certifications": "Python 101 - 401, NLP, Mikroişlemci ve IoT 101, Introduction To Cybersecurity, CCNA Introduction to Networks, NDG Linux Unhatched, CyberOps Associate", "field_of_study": "Yazılım Mühendisliği", "highest_degree": "Lisans", "processed_date": "2025-12-23T19:46:42.436Z", "profile_status": "Complete", "projects_count": 0, "current_company": "DOĞUŞ LOUP 'Yazılım ve Fikir Geliştirme' Takımı", "work_experience": [{"company": "ETKİ YERİ BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Stajyeri", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "Stajyer", "responsibilities": ["Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.", "Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.", "Back-end tarafında PostgreSQL relational database kullandım ve REST API'leri geliştirdim.", "Frontend tarafında ise React.js ile responsive arayüz oluşturdum.", "Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım."], "technologies_used": ["Spring Boot", "React", "JWT", "PostgreSQL", "REST API", "React.js"]}, {"company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "end_date": "2024-09", "location": {"city": "", "country": ""}, "job_title": "Yapay Zeka Ar-Ge Stajyeri", "is_current": false, "start_date": "2024-07", "achievements": [], "employment_type": "Stajyer", "responsibilities": ["Bu staj sürecinde, Node.js ve Python'la yapay zeka destekli bir LMS projesi geliştirdim.", "Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.", "Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.", "Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim."], "technologies_used": ["Node.js", "Python", "Yapay Zeka", "Chatbot"]}, {"company": "DOĞUŞ LOUP 'Yazılım ve Fikir Geliştirme' Takımı", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Core Team Üyesi", "is_current": true, "start_date": "2023-04", "achievements": [], "employment_type": "Part-time", "responsibilities": ["Yazılım Mühendisliği projelerinde yer aldım.", "Yazılım mühendisliği bilimi pratiğe dökme fırsatı bulurken, React Native öğreniyorum.", "Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim."], "technologies_used": ["React Native"]}], "current_position": "Yazılım Geliştirme Core Team Üyesi", "technical_skills": "C++, C#, Java, Python, SQL, React Native, HTML/CSS, Spring Boot, React, React.js, Node.js, PostgreSQL, MS Office Programları, JWT, REST API, Yapay Zeka, Chatbot, Linux", "education_details": [{"gpa": "", "degree": "Lisans", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2021-09", "institution": "Doğuş Üniversitesi", "field_of_study": "Yazılım Mühendisliği"}], "original_filename": "unknown.pdf", "completeness_score": 95, "professional_title": "YAZILIM MÜHENDİSLİĞİ ÖĞRENCİSİ", "volunteering_count": 3, "raw_structured_data": {"awards": [], "skills": {"languages": [], "soft_skills": ["Takım Çalışması", "Etkili İletişim", "Araştırma", "Öğrenme Odaklılık", "Planlama", "Azimli"], "technical_skills": [{"skills": ["C++", "C#", "Java", "Python", "SQL", "React Native", "HTML/CSS"], "skill_category": "Programlama Dilleri"}, {"skills": ["Spring Boot", "React", "React.js", "Node.js"], "skill_category": "Frameworks & Libraries"}, {"skills": ["PostgreSQL"], "skill_category": "Veritabanları"}, {"skills": ["MS Office Programları", "JWT", "REST API", "Yapay Zeka", "Chatbot"], "skill_category": "Araçlar & Teknolojiler"}, {"skills": ["Linux"], "skill_category": "İşletim Sistemleri"}]}, "summary": {"short_summary": "2023 yılı itibarıyla Doğuş Üniversitesi Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.", "professional_title": "YAZILIM MÜHENDİSLİĞİ ÖĞRENCİSİ"}, "projects": [], "education": [{"gpa": "", "degree": "Lisans", "thesis": "", "courses": [], "end_date": "", "is_current": true, "start_date": "2021-09", "institution": "Doğuş Üniversitesi", "field_of_study": "Yazılım Mühendisliği"}], "publications": [], "volunteering": [{"role": "Başkan Yardımcısı", "end_date": "2025-05", "is_current": false, "start_date": "2025-02", "organization": "Dönemeyim Mühendisler Kulübü", "responsibilities": ["Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.", "Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı."]}, {"role": "Genel Sekreter", "end_date": "2024-05", "is_current": false, "start_date": "2024-02", "organization": "Dönemeyim Mühendisler Kulübü", "responsibilities": ["Kulübün idari işlevini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.", "Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim."]}, {"role": "Koordinasyon Kurulu Üyesi", "end_date": "2024-05", "is_current": false, "start_date": "2024-02", "organization": "Doğuş Üniversitesi Yazılım Mühendisliği", "responsibilities": ["Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim."]}], "certifications": [{"name": "Python 101 - 401", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Türkcell Geleceği Yazanlar"}, {"name": "NLP", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Türkcell Geleceği Yazanlar"}, {"name": "Mikroişlemci ve IoT 101", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Doğuş Üniversitesi"}, {"name": "Introduction To Cybersecurity", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "CCNA Introduction to Networks", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "NDG Linux Unhatched", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}, {"name": "CyberOps Associate", "issue_date": "2023-11", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": "Cisco"}], "work_experience": [{"company": "ETKİ YERİ BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.", "end_date": "2025-09", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Stajyeri", "is_current": false, "start_date": "2025-08", "achievements": [], "employment_type": "Stajyer", "responsibilities": ["Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.", "Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.", "Back-end tarafında PostgreSQL relational database kullandım ve REST API'leri geliştirdim.", "Frontend tarafında ise React.js ile responsive arayüz oluşturdum.", "Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım."], "technologies_used": ["Spring Boot", "React", "JWT", "PostgreSQL", "REST API", "React.js"]}, {"company": "ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.", "end_date": "2024-09", "location": {"city": "", "country": ""}, "job_title": "Yapay Zeka Ar-Ge Stajyeri", "is_current": false, "start_date": "2024-07", "achievements": [], "employment_type": "Stajyer", "responsibilities": ["Bu staj sürecinde, Node.js ve Python'la yapay zeka destekli bir LMS projesi geliştirdim.", "Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.", "Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.", "Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim."], "technologies_used": ["Node.js", "Python", "Yapay Zeka", "Chatbot"]}, {"company": "DOĞUŞ LOUP 'Yazılım ve Fikir Geliştirme' Takımı", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "Yazılım Geliştirme Core Team Üyesi", "is_current": true, "start_date": "2023-04", "achievements": [], "employment_type": "Part-time", "responsibilities": ["Yazılım Mühendisliği projelerinde yer aldım.", "Yazılım mühendisliği bilimi pratiğe dökme fırsatı bulurken, React Native öğreniyorum.", "Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim."], "technologies_used": ["React Native"]}], "personal_information": {"email": "elanurdemirr1000@gmail.com", "phone": "+90 547 650 80 13", "gender": "", "github": "", "address": {"city": "İstanbul", "street": "", "country": "Türkiye", "postal_code": ""}, "website": "", "linkedin": "linkedin.com/in/elanurdemirr", "full_name": "ELANUR DEMİR", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}, "certifications_count": 7, "professional_summary": "2023 yılı itibarıyla Doğuş Üniversitesi Yazılım Mühendisliği bölümünde 3. Sınıf öğrencisiyim. Takım çalışmasını seven, etkili iletişim kurabilen bir öğrenciyim. Hem bireysel hem de grup projelerinde aktif olarak yer almayı seviyorum. Araştırmayı, öğrenmeyi seven, planlı ve her zaman azimli olmanın mutlak başarı ile sonuçlanacağına inanan bir yazılım mühendisi adayıyım. Özgeçmişim doğrultusunda; Öğrenmeye devam edebileceğim, sorumluluk alabileceğim ve değer katabileceğim bir iş veya staj fırsatı arıyorum.", "total_experience_years": 2.9}	2025-12-23 19:46:40.044516+00
11	EMP-1766519616749	{"awards": [{"date": "", "issuer": "Teknofest Finals", "award_name": "National 5th Place Ranking", "description": "Achieved through innovation and teamwork while guiding the LOOP Software & Idea Development Team."}], "skills": {"languages": [{"language": "English", "proficiency": "Proficient"}], "soft_skills": ["Project & Team Management", "Communication & Coordination", "Design Thinking", "Troubleshooting", "Planning", "Team Player"], "technical_skills": [{"skills": ["C#", "TypeScript", "Python", "Java"], "skill_category": "Programming Languages"}, {"skills": [".NET", "ASP.NET", "React", "Next.js", "NestJS", "Node.js", "Expo"], "skill_category": "Frameworks & Libraries"}, {"skills": ["Azure DevOps", "GitHub Actions", "Docker", "SonarQube", "ELK Stack", "Grafana"], "skill_category": "DevOps & Tools"}, {"skills": ["MS SQL", "PostgreSQL", "Redis", "NoSQL"], "skill_category": "Databases"}, {"skills": ["Figma", "Cursor"], "skill_category": "Other Tools"}]}, "summary": {"short_summary": "I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using .NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.", "professional_title": "Software Engineering Student"}, "projects": [{"role": "Co-founder, Team Leader", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Co-founded and led the LOOP Software & Idea Development Team, managing 15+ students and delivering 5+ real-world software projects, including AI-powered and disaster communication systems. Guided the team to the Teknofest Finals.", "achievements": ["Delivered 5+ real-world software projects", "Achieved a national 5th place ranking at the Teknofest Finals through innovation and teamwork"], "project_name": "LOOP Software & Idea Development Team Initiatives (including AAIA)", "technologies": ["AI", "disaster communication systems"]}], "education": [{"gpa": "", "degree": "Bachelor's degree", "thesis": "", "courses": ["full-stack development", "software architecture", "DevOps practices"], "end_date": "2026-06", "is_current": true, "start_date": "2022-06", "institution": "Doğuş University", "field_of_study": "Software Engineering"}, {"gpa": "", "degree": "Program Completion", "thesis": "", "courses": [], "end_date": "2022-06", "is_current": false, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "English Language"}], "publications": [], "volunteering": [{"role": "Club Chair", "end_date": "", "is_current": false, "start_date": "", "organization": "University Club", "responsibilities": ["Chaired one of the largest university clubs with 500+ active members", "Organized 10+ technical and career events", "Increased engagement by 40%", "Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community"]}], "certifications": [], "work_experience": [{"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2025-04", "location": {"city": "", "country": ""}, "job_title": "Software Development Intern", "is_current": false, "start_date": "2024-10", "achievements": [], "employment_type": "Internship", "responsibilities": ["Developed full-stack applications using .NET, React, and Azure DevOps.", "Collaborated with QA and DevOps teams to enhance software scalability."], "technologies_used": [".NET", "React", "Azure DevOps"]}, {"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2024-10", "location": {"city": "", "country": ""}, "job_title": "Product Owner Intern", "is_current": false, "start_date": "2024-06", "achievements": [], "employment_type": "Internship", "responsibilities": ["Managed product backlog and prioritized tasks using Agile development methodologies.", "Defined user stories and acceptance criteria to align development with business goals.", "Facilitated communication between stakeholders and technical teams.", "Contributed to on-time delivery of key product features."], "technologies_used": []}], "personal_information": {"email": "furkanulutas054@gmail.com", "phone": "+90 5399225570", "gender": "", "github": "https://github.com/furkanulutas0", "address": {"city": "", "street": "", "country": "", "postal_code": ""}, "website": "", "linkedin": "https://www.linkedin.com/in/furkan-ulutas", "full_name": "Furkan Ulutaş", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}	{"email": "furkanulutas054@gmail.com", "phone": "+905399225570", "source": "CV Upload - AI Parsed", "location": "Not Specified", "projects": [{"role": "Co-founder, Team Leader", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Co-founded and led the LOOP Software & Idea Development Team, managing 15+ students and delivering 5+ real-world software projects, including AI-powered and disaster communication systems. Guided the team to the Teknofest Finals.", "achievements": ["Delivered 5+ real-world software projects", "Achieved a national 5th place ranking at the Teknofest Finals through innovation and teamwork"], "project_name": "LOOP Software & Idea Development Team Initiatives (including AAIA)", "technologies": ["AI", "disaster communication systems"]}], "full_name": "Furkan Ulutaş", "languages": "English (Proficient)", "timestamp": "2025-12-23T19:53:36.749Z", "github_url": "https://github.com/furkanulutas0", "employee_id": "EMP-1766519616749", "institution": "Doğuş University", "soft_skills": "Project & Team Management, Communication & Coordination, Design Thinking, Troubleshooting, Planning, Team Player", "last_updated": "2025-12-23T19:53:36.758Z", "linkedin_url": "https://www.linkedin.com/in/furkan-ulutas", "volunteering": [{"role": "Club Chair", "end_date": "", "is_current": false, "start_date": "", "organization": "University Club", "responsibilities": ["Chaired one of the largest university clubs with 500+ active members", "Organized 10+ technical and career events", "Increased engagement by 40%", "Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community"]}], "certifications": "None", "field_of_study": "Software Engineering", "highest_degree": "Bachelor's degree", "processed_date": "2025-12-23T19:53:36.758Z", "profile_status": "Complete", "projects_count": 1, "current_company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "work_experience": [{"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2025-04", "location": {"city": "", "country": ""}, "job_title": "Software Development Intern", "is_current": false, "start_date": "2024-10", "achievements": [], "employment_type": "Internship", "responsibilities": ["Developed full-stack applications using .NET, React, and Azure DevOps.", "Collaborated with QA and DevOps teams to enhance software scalability."], "technologies_used": [".NET", "React", "Azure DevOps"]}, {"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2024-10", "location": {"city": "", "country": ""}, "job_title": "Product Owner Intern", "is_current": false, "start_date": "2024-06", "achievements": [], "employment_type": "Internship", "responsibilities": ["Managed product backlog and prioritized tasks using Agile development methodologies.", "Defined user stories and acceptance criteria to align development with business goals.", "Facilitated communication between stakeholders and technical teams.", "Contributed to on-time delivery of key product features."], "technologies_used": []}], "current_position": "Software Development Intern", "technical_skills": "C#, TypeScript, Python, Java, .NET, ASP.NET, React, Next.js, NestJS, Node.js, Expo, Azure DevOps, GitHub Actions, Docker, SonarQube, ELK Stack, Grafana, MS SQL, PostgreSQL, Redis, NoSQL, Figma, Cursor", "education_details": [{"gpa": "", "degree": "Bachelor's degree", "thesis": "", "courses": ["full-stack development", "software architecture", "DevOps practices"], "end_date": "2026-06", "is_current": true, "start_date": "2022-06", "institution": "Doğuş University", "field_of_study": "Software Engineering"}, {"gpa": "", "degree": "Program Completion", "thesis": "", "courses": [], "end_date": "2022-06", "is_current": false, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "English Language"}], "original_filename": "unknown.pdf", "completeness_score": 95, "professional_title": "Software Engineering Student", "volunteering_count": 1, "raw_structured_data": {"awards": [{"date": "", "issuer": "Teknofest Finals", "award_name": "National 5th Place Ranking", "description": "Achieved through innovation and teamwork while guiding the LOOP Software & Idea Development Team."}], "skills": {"languages": [{"language": "English", "proficiency": "Proficient"}], "soft_skills": ["Project & Team Management", "Communication & Coordination", "Design Thinking", "Troubleshooting", "Planning", "Team Player"], "technical_skills": [{"skills": ["C#", "TypeScript", "Python", "Java"], "skill_category": "Programming Languages"}, {"skills": [".NET", "ASP.NET", "React", "Next.js", "NestJS", "Node.js", "Expo"], "skill_category": "Frameworks & Libraries"}, {"skills": ["Azure DevOps", "GitHub Actions", "Docker", "SonarQube", "ELK Stack", "Grafana"], "skill_category": "DevOps & Tools"}, {"skills": ["MS SQL", "PostgreSQL", "Redis", "NoSQL"], "skill_category": "Databases"}, {"skills": ["Figma", "Cursor"], "skill_category": "Other Tools"}]}, "summary": {"short_summary": "I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using .NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.", "professional_title": "Software Engineering Student"}, "projects": [{"role": "Co-founder, Team Leader", "links": [], "end_date": "", "is_current": false, "start_date": "", "description": "Co-founded and led the LOOP Software & Idea Development Team, managing 15+ students and delivering 5+ real-world software projects, including AI-powered and disaster communication systems. Guided the team to the Teknofest Finals.", "achievements": ["Delivered 5+ real-world software projects", "Achieved a national 5th place ranking at the Teknofest Finals through innovation and teamwork"], "project_name": "LOOP Software & Idea Development Team Initiatives (including AAIA)", "technologies": ["AI", "disaster communication systems"]}], "education": [{"gpa": "", "degree": "Bachelor's degree", "thesis": "", "courses": ["full-stack development", "software architecture", "DevOps practices"], "end_date": "2026-06", "is_current": true, "start_date": "2022-06", "institution": "Doğuş University", "field_of_study": "Software Engineering"}, {"gpa": "", "degree": "Program Completion", "thesis": "", "courses": [], "end_date": "2022-06", "is_current": false, "start_date": "2021-10", "institution": "Doğuş University", "field_of_study": "English Language"}], "publications": [], "volunteering": [{"role": "Club Chair", "end_date": "", "is_current": false, "start_date": "", "organization": "University Club", "responsibilities": ["Chaired one of the largest university clubs with 500+ active members", "Organized 10+ technical and career events", "Increased engagement by 40%", "Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community"]}], "certifications": [], "work_experience": [{"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2025-04", "location": {"city": "", "country": ""}, "job_title": "Software Development Intern", "is_current": false, "start_date": "2024-10", "achievements": [], "employment_type": "Internship", "responsibilities": ["Developed full-stack applications using .NET, React, and Azure DevOps.", "Collaborated with QA and DevOps teams to enhance software scalability."], "technologies_used": [".NET", "React", "Azure DevOps"]}, {"company": "Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)", "end_date": "2024-10", "location": {"city": "", "country": ""}, "job_title": "Product Owner Intern", "is_current": false, "start_date": "2024-06", "achievements": [], "employment_type": "Internship", "responsibilities": ["Managed product backlog and prioritized tasks using Agile development methodologies.", "Defined user stories and acceptance criteria to align development with business goals.", "Facilitated communication between stakeholders and technical teams.", "Contributed to on-time delivery of key product features."], "technologies_used": []}], "personal_information": {"email": "furkanulutas054@gmail.com", "phone": "+90 5399225570", "gender": "", "github": "https://github.com/furkanulutas0", "address": {"city": "", "street": "", "country": "", "postal_code": ""}, "website": "", "linkedin": "https://www.linkedin.com/in/furkan-ulutas", "full_name": "Furkan Ulutaş", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}, "certifications_count": 0, "professional_summary": "I'm a Software Engineering student with experience in full-stack development, DevOps, and product management. During my internship at Doğuş Teknoloji, I worked on real projects using .NET, React, and Azure. I also take active roles outside the classroom-as the President of a student club and Co-Founder of LOOP, where we developed award-winning tech projects like AAIA. I enjoy working in teams and building useful software that solves real problems. My goal is to become a versatile software engineer who can lead both development and product strategy in large-scale technology teams.", "total_experience_years": 0.8}	2025-12-23 19:53:34.266207+00
13	EMP-1766519936675	{"awards": [], "skills": {"languages": [{"language": "Turkish", "proficiency": "native"}, {"language": "English", "proficiency": "upper int."}], "soft_skills": ["Team management", "Cross-functional communication", "Event moderation", "Problem-solving"], "technical_skills": [{"skills": ["IBM CICS", "IBM MQ", "JCL", "RabbitMQ", "SSRS", "MS SQL"], "skill_category": "Platforms/Tools"}]}, "summary": {"short_summary": "As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.", "professional_title": "System Engineer Assistant"}, "projects": [], "education": [{"gpa": "", "degree": "Bachelor of Science", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}], "publications": [], "volunteering": [{"role": "Founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "Dogus University's first hackathon/ideathon team", "responsibilities": ["Founded and led the university's first hackathon/ideathon team."]}, {"role": "Chairman", "end_date": "", "is_current": false, "start_date": "", "organization": "Mühendis Beyinler Club", "responsibilities": ["Overseeing operations and student engagement.", "Organized technical events, workshops, and seminars to support practical skill development."]}], "certifications": [{"name": "IBM z/OS Introduction", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "SQL Server", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "IT Service Management", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "Java Basics", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}], "work_experience": [{"company": "Garanti BBVA Technology", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "System Engineer Assistant", "is_current": true, "start_date": "2023-06", "achievements": [], "employment_type": "", "responsibilities": ["Created initial definitions for CICS environments systems.", "Performed process monitoring, error handling, and basic configuration on IBM CICS.", "Worked with queue and channel structures on IBM MQ, monitoring message flows.", "Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.", "Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.", "Generated internal reports from daily log data using SSRS.", "Collaborated with cross-functional teams (network, application, and database) to resolve system issues.", "Tracked job logs, analyzed system messages, and conducted initial error analysis.", "Wrote entry-level JCL scripts to initiate and monitor basic batch jobs."], "technologies_used": ["IBM CICS", "IBM MQ", "OMEGAMON", "SSRS", "JCL"]}], "personal_information": {"email": "muhammed.cihan@hotmail.com", "phone": "+90 (535) 065 95 95", "gender": "", "github": "", "address": {"city": "Istanbul", "street": "", "country": "Turkiye", "postal_code": ""}, "website": "", "linkedin": "https://www.linkedin.com/in/muhammedcihan", "full_name": "MUHAMMED CIHAN", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}	{"email": "muhammed.cihan@hotmail.com", "phone": "+905350659595", "source": "CV Upload - AI Parsed", "location": "Istanbul, Turkiye", "projects": [], "full_name": "MUHAMMED CIHAN", "languages": "Turkish (native), English (upper int.)", "timestamp": "2025-12-23T19:58:56.676Z", "github_url": "", "employee_id": "EMP-1766519936675", "institution": "Dogus University", "saved_to_db": true, "soft_skills": "Team management, Cross-functional communication, Event moderation, Problem-solving", "last_updated": "2025-12-23T19:58:56.676Z", "linkedin_url": "https://www.linkedin.com/in/muhammedcihan", "volunteering": [{"role": "Founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "Dogus University's first hackathon/ideathon team", "responsibilities": ["Founded and led the university's first hackathon/ideathon team."]}, {"role": "Chairman", "end_date": "", "is_current": false, "start_date": "", "organization": "Mühendis Beyinler Club", "responsibilities": ["Overseeing operations and student engagement.", "Organized technical events, workshops, and seminars to support practical skill development."]}], "certifications": "IBM z/OS Introduction, SQL Server, IT Service Management, Java Basics", "field_of_study": "Computer Engineering", "highest_degree": "Bachelor of Science", "processed_date": "2025-12-23T19:58:56.676Z", "profile_status": "Complete", "projects_count": 0, "current_company": "Garanti BBVA Technology", "db_candidate_id": "EMP-1766519936675", "work_experience": [{"company": "Garanti BBVA Technology", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "System Engineer Assistant", "is_current": true, "start_date": "2023-06", "achievements": [], "employment_type": "", "responsibilities": ["Created initial definitions for CICS environments systems.", "Performed process monitoring, error handling, and basic configuration on IBM CICS.", "Worked with queue and channel structures on IBM MQ, monitoring message flows.", "Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.", "Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.", "Generated internal reports from daily log data using SSRS.", "Collaborated with cross-functional teams (network, application, and database) to resolve system issues.", "Tracked job logs, analyzed system messages, and conducted initial error analysis.", "Wrote entry-level JCL scripts to initiate and monitor basic batch jobs."], "technologies_used": ["IBM CICS", "IBM MQ", "OMEGAMON", "SSRS", "JCL"]}], "current_position": "System Engineer Assistant", "technical_skills": "IBM CICS, IBM MQ, JCL, RabbitMQ, SSRS, MS SQL", "education_details": [{"gpa": "", "degree": "Bachelor of Science", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}], "original_filename": "unknown.pdf", "completeness_score": 95, "professional_title": "System Engineer Assistant", "volunteering_count": 2, "raw_structured_data": {"awards": [], "skills": {"languages": [{"language": "Turkish", "proficiency": "native"}, {"language": "English", "proficiency": "upper int."}], "soft_skills": ["Team management", "Cross-functional communication", "Event moderation", "Problem-solving"], "technical_skills": [{"skills": ["IBM CICS", "IBM MQ", "JCL", "RabbitMQ", "SSRS", "MS SQL"], "skill_category": "Platforms/Tools"}]}, "summary": {"short_summary": "As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.", "professional_title": "System Engineer Assistant"}, "projects": [], "education": [{"gpa": "", "degree": "Bachelor of Science", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}], "publications": [], "volunteering": [{"role": "Founder and Leader", "end_date": "", "is_current": false, "start_date": "", "organization": "Dogus University's first hackathon/ideathon team", "responsibilities": ["Founded and led the university's first hackathon/ideathon team."]}, {"role": "Chairman", "end_date": "", "is_current": false, "start_date": "", "organization": "Mühendis Beyinler Club", "responsibilities": ["Overseeing operations and student engagement.", "Organized technical events, workshops, and seminars to support practical skill development."]}], "certifications": [{"name": "IBM z/OS Introduction", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "SQL Server", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "IT Service Management", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "Java Basics", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}], "work_experience": [{"company": "Garanti BBVA Technology", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "System Engineer Assistant", "is_current": true, "start_date": "2023-06", "achievements": [], "employment_type": "", "responsibilities": ["Created initial definitions for CICS environments systems.", "Performed process monitoring, error handling, and basic configuration on IBM CICS.", "Worked with queue and channel structures on IBM MQ, monitoring message flows.", "Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.", "Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.", "Generated internal reports from daily log data using SSRS.", "Collaborated with cross-functional teams (network, application, and database) to resolve system issues.", "Tracked job logs, analyzed system messages, and conducted initial error analysis.", "Wrote entry-level JCL scripts to initiate and monitor basic batch jobs."], "technologies_used": ["IBM CICS", "IBM MQ", "OMEGAMON", "SSRS", "JCL"]}], "personal_information": {"email": "muhammed.cihan@hotmail.com", "phone": "+90 (535) 065 95 95", "gender": "", "github": "", "address": {"city": "Istanbul", "street": "", "country": "Turkiye", "postal_code": ""}, "website": "", "linkedin": "https://www.linkedin.com/in/muhammedcihan", "full_name": "MUHAMMED CIHAN", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}, "certifications_count": 4, "professional_summary": "As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.", "total_experience_years": 2.5}	2025-12-23 19:58:54.584036+00
15	EMP-1766521577842	{"awards": [], "skills": {"languages": [{"language": "Turkish", "proficiency": "native"}, {"language": "English", "proficiency": "upper int."}], "soft_skills": ["Team management", "cross-functional communication", "event moderation", "problem-solving"], "technical_skills": [{"skills": ["IBM CICS", "IBM MQ", "JCL (entry-level)", "RabbitMQ (entry-level)", "SSRS", "MS SQL"], "skill_category": ""}]}, "summary": {"short_summary": "As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.", "professional_title": "System Engineer Assistant"}, "projects": [], "education": [{"gpa": "", "degree": "Bachelor of Science", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}], "publications": [], "volunteering": [{"role": "Founder and Leader of the university's first hackathon/ideathon team", "end_date": "", "is_current": false, "start_date": "", "organization": "Dogus University", "responsibilities": []}, {"role": "Chairman of the Mühendis Beyinler Club", "end_date": "", "is_current": false, "start_date": "", "organization": "Dogus University", "responsibilities": ["Overseeing operations and student engagement.", "Organized technical events, workshops, and seminars to support practical skill development."]}], "certifications": [{"name": "IBM z/OS Introduction", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "SQL Server", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "IT Service Management", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "Java Basics", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}], "work_experience": [{"company": "Garanti BBVA Technology", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "System Engineer Assistant", "is_current": true, "start_date": "2023-06", "achievements": [], "employment_type": "", "responsibilities": ["Created initial definitions for CICS environments systems.", "Performed process monitoring, error handling, and basic configuration on IBM CICS.", "Worked with queue and channel structures on IBM MQ, monitoring message flows.", "Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.", "Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.", "Generated internal reports from daily log data using SSRS.", "Collaborated with cross-functional teams (network, application, and database) to resolve system issues.", "Tracked job logs, analyzed system messages, and conducted initial error analysis.", "Wrote entry-level JCL scripts to initiate and monitor basic batch jobs"], "technologies_used": []}], "personal_information": {"email": "muhammed.cihan@hotmail.com", "phone": "+90 (535) 065 95 95", "gender": "", "github": "", "address": {"city": "Istanbul", "street": "", "country": "Turkiye", "postal_code": ""}, "website": "", "linkedin": "@muhammedcihan", "full_name": "MUHAMMED CIHAN", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}	{"email": "muhammed.cihan@hotmail.com", "phone": "+905350659595", "source": "CV Upload - AI Parsed", "location": "Istanbul, Turkiye", "projects": [], "full_name": "MUHAMMED CIHAN", "languages": "Turkish (native), English (upper int.)", "timestamp": "2025-12-23T20:26:17.842Z", "github_url": "", "employee_id": "EMP-1766521577842", "institution": "Dogus University", "saved_to_db": true, "soft_skills": "Team management, cross-functional communication, event moderation, problem-solving", "last_updated": "2025-12-23T20:26:17.843Z", "linkedin_url": "https://linkedin.com/in/muhammedcihan", "volunteering": [{"role": "Founder and Leader of the university's first hackathon/ideathon team", "end_date": "", "is_current": false, "start_date": "", "organization": "Dogus University", "responsibilities": []}, {"role": "Chairman of the Mühendis Beyinler Club", "end_date": "", "is_current": false, "start_date": "", "organization": "Dogus University", "responsibilities": ["Overseeing operations and student engagement.", "Organized technical events, workshops, and seminars to support practical skill development."]}], "certifications": "IBM z/OS Introduction, SQL Server, IT Service Management, Java Basics", "field_of_study": "Computer Engineering", "highest_degree": "Bachelor of Science", "processed_date": "2025-12-23T20:26:17.843Z", "profile_status": "Complete", "projects_count": 0, "current_company": "Garanti BBVA Technology", "db_candidate_id": "EMP-1766521577842", "work_experience": [{"company": "Garanti BBVA Technology", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "System Engineer Assistant", "is_current": true, "start_date": "2023-06", "achievements": [], "employment_type": "", "responsibilities": ["Created initial definitions for CICS environments systems.", "Performed process monitoring, error handling, and basic configuration on IBM CICS.", "Worked with queue and channel structures on IBM MQ, monitoring message flows.", "Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.", "Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.", "Generated internal reports from daily log data using SSRS.", "Collaborated with cross-functional teams (network, application, and database) to resolve system issues.", "Tracked job logs, analyzed system messages, and conducted initial error analysis.", "Wrote entry-level JCL scripts to initiate and monitor basic batch jobs"], "technologies_used": []}], "current_position": "System Engineer Assistant", "technical_skills": "IBM CICS, IBM MQ, JCL (entry-level), RabbitMQ (entry-level), SSRS, MS SQL", "education_details": [{"gpa": "", "degree": "Bachelor of Science", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}], "original_filename": "unknown.pdf", "completeness_score": 95, "professional_title": "System Engineer Assistant", "volunteering_count": 2, "raw_structured_data": {"awards": [], "skills": {"languages": [{"language": "Turkish", "proficiency": "native"}, {"language": "English", "proficiency": "upper int."}], "soft_skills": ["Team management", "cross-functional communication", "event moderation", "problem-solving"], "technical_skills": [{"skills": ["IBM CICS", "IBM MQ", "JCL (entry-level)", "RabbitMQ (entry-level)", "SSRS", "MS SQL"], "skill_category": ""}]}, "summary": {"short_summary": "As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.", "professional_title": "System Engineer Assistant"}, "projects": [], "education": [{"gpa": "", "degree": "Bachelor of Science", "thesis": "", "courses": [], "end_date": "2026-06", "is_current": true, "start_date": "2021-09", "institution": "Dogus University", "field_of_study": "Computer Engineering"}], "publications": [], "volunteering": [{"role": "Founder and Leader of the university's first hackathon/ideathon team", "end_date": "", "is_current": false, "start_date": "", "organization": "Dogus University", "responsibilities": []}, {"role": "Chairman of the Mühendis Beyinler Club", "end_date": "", "is_current": false, "start_date": "", "organization": "Dogus University", "responsibilities": ["Overseeing operations and student engagement.", "Organized technical events, workshops, and seminars to support practical skill development."]}], "certifications": [{"name": "IBM z/OS Introduction", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "SQL Server", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "IT Service Management", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}, {"name": "Java Basics", "issue_date": "", "credential_id": "", "credential_url": "", "expiration_date": "", "issuing_organization": ""}], "work_experience": [{"company": "Garanti BBVA Technology", "end_date": "", "location": {"city": "", "country": ""}, "job_title": "System Engineer Assistant", "is_current": true, "start_date": "2023-06", "achievements": [], "employment_type": "", "responsibilities": ["Created initial definitions for CICS environments systems.", "Performed process monitoring, error handling, and basic configuration on IBM CICS.", "Worked with queue and channel structures on IBM MQ, monitoring message flows.", "Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.", "Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.", "Generated internal reports from daily log data using SSRS.", "Collaborated with cross-functional teams (network, application, and database) to resolve system issues.", "Tracked job logs, analyzed system messages, and conducted initial error analysis.", "Wrote entry-level JCL scripts to initiate and monitor basic batch jobs"], "technologies_used": []}], "personal_information": {"email": "muhammed.cihan@hotmail.com", "phone": "+90 (535) 065 95 95", "gender": "", "github": "", "address": {"city": "Istanbul", "street": "", "country": "Turkiye", "postal_code": ""}, "website": "", "linkedin": "@muhammedcihan", "full_name": "MUHAMMED CIHAN", "birth_date": "", "nationality": ""}, "additional_information": {"hobbies": [], "availability": "", "driving_license": "", "military_status": "", "willing_to_travel": false, "willing_to_relocate": false}}, "certifications_count": 4, "professional_summary": "As a systems engineer assistant, I mainly support infrastructure and middleware operations across non-production and production environments. My focus is on middleware platforms, where I assist with monitoring, message flows, queue tracking, and basic issue resolution. I'm also involved in backend processes, job tracking, and team coordination to ensure system stability. Currently in the final year of my Computer Engineering degree, I apply my academic background to practical, real-world scenarios.", "total_experience_years": 2.5}	2025-12-23 20:26:15.628619+00
\.


--
-- Data for Name: candidate_soft_skills; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_soft_skills (id, candidate_id, skill_name, created_at) FROM stdin;
1	EMP-TEST-123456	Leadership	2025-12-19 10:28:09.601007+00
2	EMP-TEST-123456	Communication	2025-12-19 10:28:09.601007+00
3	EMP-TEST-123456	Problem Solving	2025-12-19 10:28:09.601007+00
4	EMP-1766239092988	Team management	2025-12-20 13:58:10.850979+00
5	EMP-1766239092988	Cross-functional communication	2025-12-20 13:58:10.850979+00
6	EMP-1766239092988	Event moderation	2025-12-20 13:58:10.850979+00
7	EMP-1766239092988	Problem-solving	2025-12-20 13:58:10.850979+00
8	EMP-1766239676620	Project & Team Management	2025-12-20 14:07:54.362886+00
9	EMP-1766239676620	Communication & Coordination	2025-12-20 14:07:54.362886+00
10	EMP-1766239676620	Design Thinking	2025-12-20 14:07:54.362886+00
11	EMP-1766239676620	Troubleshooting	2025-12-20 14:07:54.362886+00
12	EMP-1766239676620	Planning	2025-12-20 14:07:54.362886+00
13	EMP-1766239676620	Team Player	2025-12-20 14:07:54.362886+00
14	EMP-1766252302499	Open to learning new technologies	2025-12-20 17:38:20.827172+00
15	EMP-1766252302499	Team-oriented	2025-12-20 17:38:20.827172+00
16	EMP-1766252302499	Responsible and disciplined	2025-12-20 17:38:20.827172+00
17	EMP-1766252302499	Eager to learn and develop	2025-12-20 17:38:20.827172+00
18	EMP-1766254966950	Open to learning new technologies	2025-12-20 18:22:45.100317+00
19	EMP-1766254966950	Team-oriented	2025-12-20 18:22:45.100317+00
20	EMP-1766254966950	Responsible and disciplined	2025-12-20 18:22:45.100317+00
21	EMP-1766254966950	Eager to learn and develop	2025-12-20 18:22:45.100317+00
22	EMP-1766255177864	Project & Team Management	2025-12-20 18:26:15.919585+00
23	EMP-1766255177864	Communication & Coordination	2025-12-20 18:26:15.919585+00
24	EMP-1766255177864	Design Thinking	2025-12-20 18:26:15.919585+00
25	EMP-1766255177864	Troubleshooting	2025-12-20 18:26:15.919585+00
26	EMP-1766255177864	Planning	2025-12-20 18:26:15.919585+00
27	EMP-1766255177864	Team Player	2025-12-20 18:26:15.919585+00
28	EMP-1766436935343	Takım çalışması	2025-12-22 20:55:33.328939+00
29	EMP-1766436935343	Etkili iletişim	2025-12-22 20:55:33.328939+00
30	EMP-1766436935343	Araştırma	2025-12-22 20:55:33.328939+00
31	EMP-1766436935343	Öğrenme	2025-12-22 20:55:33.328939+00
32	EMP-1766436935343	Planlama	2025-12-22 20:55:33.328939+00
33	EMP-1766436935343	Azim	2025-12-22 20:55:33.328939+00
34	EMP-1766436935343	Problem çözme	2025-12-22 20:55:33.328939+00
35	EMP-1766519202434	Takım Çalışması	2025-12-23 19:46:40.044516+00
36	EMP-1766519202434	Etkili İletişim	2025-12-23 19:46:40.044516+00
37	EMP-1766519202434	Araştırma	2025-12-23 19:46:40.044516+00
38	EMP-1766519202434	Öğrenme Odaklılık	2025-12-23 19:46:40.044516+00
39	EMP-1766519202434	Planlama	2025-12-23 19:46:40.044516+00
40	EMP-1766519202434	Azimli	2025-12-23 19:46:40.044516+00
41	EMP-1766519616749	Project & Team Management	2025-12-23 19:53:34.266207+00
42	EMP-1766519616749	Communication & Coordination	2025-12-23 19:53:34.266207+00
43	EMP-1766519616749	Design Thinking	2025-12-23 19:53:34.266207+00
44	EMP-1766519616749	Troubleshooting	2025-12-23 19:53:34.266207+00
45	EMP-1766519616749	Planning	2025-12-23 19:53:34.266207+00
46	EMP-1766519616749	Team Player	2025-12-23 19:53:34.266207+00
51	EMP-1766519936675	Team management	2025-12-23 19:58:54.584036+00
52	EMP-1766519936675	Cross-functional communication	2025-12-23 19:58:54.584036+00
53	EMP-1766519936675	Event moderation	2025-12-23 19:58:54.584036+00
54	EMP-1766519936675	Problem-solving	2025-12-23 19:58:54.584036+00
59	EMP-1766521577842	Team management	2025-12-23 20:26:15.628619+00
60	EMP-1766521577842	cross-functional communication	2025-12-23 20:26:15.628619+00
61	EMP-1766521577842	event moderation	2025-12-23 20:26:15.628619+00
62	EMP-1766521577842	problem-solving	2025-12-23 20:26:15.628619+00
\.


--
-- Data for Name: candidate_technical_skills; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_technical_skills (id, candidate_id, skill_category_id, skill_name, proficiency_level, years_of_experience, created_at, updated_at) FROM stdin;
1	EMP-TEST-123456	\N	Python	\N	\N	2025-12-19 10:28:09.601007+00	\N
2	EMP-TEST-123456	\N	JavaScript	\N	\N	2025-12-19 10:28:09.601007+00	\N
3	EMP-TEST-123456	\N	React	\N	\N	2025-12-19 10:28:09.601007+00	\N
4	EMP-TEST-123456	\N	FastAPI	\N	\N	2025-12-19 10:28:09.601007+00	\N
5	EMP-1766141328216	\N	Java	\N	\N	2025-12-19 12:30:15.325018+00	\N
6	EMP-1766141328216	\N	Python	\N	\N	2025-12-19 12:30:15.325018+00	\N
7	EMP-1766141328216	\N	C++	\N	\N	2025-12-19 12:30:15.325018+00	\N
8	EMP-1766141328216	\N	JavaScript	\N	\N	2025-12-19 12:30:15.325018+00	\N
9	EMP-1766141328216	\N	TypeScript	\N	\N	2025-12-19 12:30:15.325018+00	\N
10	EMP-1766141328216	\N	MATLAB	\N	\N	2025-12-19 12:30:15.325018+00	\N
11	EMP-1766141328216	\N	React	\N	\N	2025-12-19 12:30:15.325018+00	\N
12	EMP-1766141328216	\N	React Native	\N	\N	2025-12-19 12:30:15.325018+00	\N
13	EMP-1766141328216	\N	HTML5	\N	\N	2025-12-19 12:30:15.325018+00	\N
14	EMP-1766141328216	\N	CSS3	\N	\N	2025-12-19 12:30:15.325018+00	\N
15	EMP-1766141328216	\N	Tailwind CSS	\N	\N	2025-12-19 12:30:15.325018+00	\N
16	EMP-1766141328216	\N	Bootstrap	\N	\N	2025-12-19 12:30:15.325018+00	\N
17	EMP-1766141328216	\N	Node.js	\N	\N	2025-12-19 12:30:15.325018+00	\N
18	EMP-1766141328216	\N	Express.js	\N	\N	2025-12-19 12:30:15.325018+00	\N
19	EMP-1766141328216	\N	NestJS	\N	\N	2025-12-19 12:30:15.325018+00	\N
20	EMP-1766141328216	\N	.NET	\N	\N	2025-12-19 12:30:15.325018+00	\N
21	EMP-1766141328216	\N	PostgreSQL	\N	\N	2025-12-19 12:30:15.325018+00	\N
22	EMP-1766141328216	\N	MySQL	\N	\N	2025-12-19 12:30:15.325018+00	\N
23	EMP-1766141328216	\N	MongoDB	\N	\N	2025-12-19 12:30:15.325018+00	\N
24	EMP-1766141328216	\N	Firebase	\N	\N	2025-12-19 12:30:15.325018+00	\N
25	EMP-1766141328216	\N	Git	\N	\N	2025-12-19 12:30:15.325018+00	\N
26	EMP-1766141328216	\N	GitHub	\N	\N	2025-12-19 12:30:15.325018+00	\N
27	EMP-1766141328216	\N	Jira	\N	\N	2025-12-19 12:30:15.325018+00	\N
28	EMP-1766141328216	\N	Figma	\N	\N	2025-12-19 12:30:15.325018+00	\N
29	EMP-1766141328216	\N	Android Studio	\N	\N	2025-12-19 12:30:15.325018+00	\N
30	EMP-1766141328216	\N	Selenium	\N	\N	2025-12-19 12:30:15.325018+00	\N
31	EMP-1766239092988	\N	IBM CICS	\N	\N	2025-12-20 13:58:10.850979+00	\N
32	EMP-1766239092988	\N	IBM MQ	\N	\N	2025-12-20 13:58:10.850979+00	\N
33	EMP-1766239092988	\N	JCL	\N	\N	2025-12-20 13:58:10.850979+00	\N
34	EMP-1766239092988	\N	RabbitMQ	\N	\N	2025-12-20 13:58:10.850979+00	\N
35	EMP-1766239092988	\N	SSRS	\N	\N	2025-12-20 13:58:10.850979+00	\N
36	EMP-1766239092988	\N	MS SQL	\N	\N	2025-12-20 13:58:10.850979+00	\N
37	EMP-1766239676620	\N	C#	\N	\N	2025-12-20 14:07:54.362886+00	\N
38	EMP-1766239676620	\N	TypeScript	\N	\N	2025-12-20 14:07:54.362886+00	\N
39	EMP-1766239676620	\N	Python	\N	\N	2025-12-20 14:07:54.362886+00	\N
40	EMP-1766239676620	\N	Java	\N	\N	2025-12-20 14:07:54.362886+00	\N
41	EMP-1766239676620	\N	.NET	\N	\N	2025-12-20 14:07:54.362886+00	\N
42	EMP-1766239676620	\N	ASP.NET	\N	\N	2025-12-20 14:07:54.362886+00	\N
43	EMP-1766239676620	\N	React	\N	\N	2025-12-20 14:07:54.362886+00	\N
44	EMP-1766239676620	\N	Next.js	\N	\N	2025-12-20 14:07:54.362886+00	\N
45	EMP-1766239676620	\N	NestJS	\N	\N	2025-12-20 14:07:54.362886+00	\N
46	EMP-1766239676620	\N	Node.js	\N	\N	2025-12-20 14:07:54.362886+00	\N
47	EMP-1766239676620	\N	Expo	\N	\N	2025-12-20 14:07:54.362886+00	\N
48	EMP-1766239676620	\N	Azure DevOps	\N	\N	2025-12-20 14:07:54.362886+00	\N
49	EMP-1766239676620	\N	GitHub Actions	\N	\N	2025-12-20 14:07:54.362886+00	\N
50	EMP-1766239676620	\N	Docker	\N	\N	2025-12-20 14:07:54.362886+00	\N
51	EMP-1766239676620	\N	SonarQube	\N	\N	2025-12-20 14:07:54.362886+00	\N
52	EMP-1766239676620	\N	ELK Stack	\N	\N	2025-12-20 14:07:54.362886+00	\N
53	EMP-1766239676620	\N	Grafana	\N	\N	2025-12-20 14:07:54.362886+00	\N
54	EMP-1766239676620	\N	MS SQL	\N	\N	2025-12-20 14:07:54.362886+00	\N
55	EMP-1766239676620	\N	PostgreSQL	\N	\N	2025-12-20 14:07:54.362886+00	\N
56	EMP-1766239676620	\N	Redis	\N	\N	2025-12-20 14:07:54.362886+00	\N
57	EMP-1766239676620	\N	NoSQL	\N	\N	2025-12-20 14:07:54.362886+00	\N
58	EMP-1766239676620	\N	Figma	\N	\N	2025-12-20 14:07:54.362886+00	\N
59	EMP-1766239676620	\N	Cursor	\N	\N	2025-12-20 14:07:54.362886+00	\N
60	EMP-1766252302499	\N	Java	\N	\N	2025-12-20 17:38:20.827172+00	\N
61	EMP-1766252302499	\N	Spring	\N	\N	2025-12-20 17:38:20.827172+00	\N
62	EMP-1766252302499	\N	C#	\N	\N	2025-12-20 17:38:20.827172+00	\N
63	EMP-1766252302499	\N	.NET	\N	\N	2025-12-20 17:38:20.827172+00	\N
64	EMP-1766252302499	\N	Python	\N	\N	2025-12-20 17:38:20.827172+00	\N
65	EMP-1766252302499	\N	HTML	\N	\N	2025-12-20 17:38:20.827172+00	\N
66	EMP-1766252302499	\N	CSS	\N	\N	2025-12-20 17:38:20.827172+00	\N
67	EMP-1766252302499	\N	Javascript	\N	\N	2025-12-20 17:38:20.827172+00	\N
68	EMP-1766252302499	\N	React	\N	\N	2025-12-20 17:38:20.827172+00	\N
69	EMP-1766252302499	\N	Next.js	\N	\N	2025-12-20 17:38:20.827172+00	\N
70	EMP-1766252302499	\N	Node.js	\N	\N	2025-12-20 17:38:20.827172+00	\N
71	EMP-1766252302499	\N	React Native	\N	\N	2025-12-20 17:38:20.827172+00	\N
72	EMP-1766252302499	\N	PostgreSQL	\N	\N	2025-12-20 17:38:20.827172+00	\N
73	EMP-1766252302499	\N	Jira	\N	\N	2025-12-20 17:38:20.827172+00	\N
74	EMP-1766252302499	\N	Github	\N	\N	2025-12-20 17:38:20.827172+00	\N
75	EMP-1766254966950	\N	Java	\N	\N	2025-12-20 18:22:45.100317+00	\N
76	EMP-1766254966950	\N	Spring	\N	\N	2025-12-20 18:22:45.100317+00	\N
77	EMP-1766254966950	\N	C#	\N	\N	2025-12-20 18:22:45.100317+00	\N
78	EMP-1766254966950	\N	.NET	\N	\N	2025-12-20 18:22:45.100317+00	\N
79	EMP-1766254966950	\N	Python	\N	\N	2025-12-20 18:22:45.100317+00	\N
80	EMP-1766254966950	\N	HTML	\N	\N	2025-12-20 18:22:45.100317+00	\N
81	EMP-1766254966950	\N	CSS	\N	\N	2025-12-20 18:22:45.100317+00	\N
82	EMP-1766254966950	\N	Javascript	\N	\N	2025-12-20 18:22:45.100317+00	\N
83	EMP-1766254966950	\N	React	\N	\N	2025-12-20 18:22:45.100317+00	\N
84	EMP-1766254966950	\N	Next.js	\N	\N	2025-12-20 18:22:45.100317+00	\N
85	EMP-1766254966950	\N	Node.js	\N	\N	2025-12-20 18:22:45.100317+00	\N
86	EMP-1766254966950	\N	React Native	\N	\N	2025-12-20 18:22:45.100317+00	\N
87	EMP-1766254966950	\N	PostgreSQL	\N	\N	2025-12-20 18:22:45.100317+00	\N
88	EMP-1766254966950	\N	Jira	\N	\N	2025-12-20 18:22:45.100317+00	\N
89	EMP-1766254966950	\N	Github	\N	\N	2025-12-20 18:22:45.100317+00	\N
90	EMP-1766255177864	\N	C#	\N	\N	2025-12-20 18:26:15.919585+00	\N
91	EMP-1766255177864	\N	TypeScript	\N	\N	2025-12-20 18:26:15.919585+00	\N
92	EMP-1766255177864	\N	Python	\N	\N	2025-12-20 18:26:15.919585+00	\N
93	EMP-1766255177864	\N	Java	\N	\N	2025-12-20 18:26:15.919585+00	\N
94	EMP-1766255177864	\N	.NET	\N	\N	2025-12-20 18:26:15.919585+00	\N
95	EMP-1766255177864	\N	ASP.NET	\N	\N	2025-12-20 18:26:15.919585+00	\N
96	EMP-1766255177864	\N	React	\N	\N	2025-12-20 18:26:15.919585+00	\N
97	EMP-1766255177864	\N	Next.js	\N	\N	2025-12-20 18:26:15.919585+00	\N
98	EMP-1766255177864	\N	NestJS	\N	\N	2025-12-20 18:26:15.919585+00	\N
99	EMP-1766255177864	\N	Node.js	\N	\N	2025-12-20 18:26:15.919585+00	\N
100	EMP-1766255177864	\N	Expo	\N	\N	2025-12-20 18:26:15.919585+00	\N
101	EMP-1766255177864	\N	Azure DevOps	\N	\N	2025-12-20 18:26:15.919585+00	\N
102	EMP-1766255177864	\N	GitHub Actions	\N	\N	2025-12-20 18:26:15.919585+00	\N
103	EMP-1766255177864	\N	Docker	\N	\N	2025-12-20 18:26:15.919585+00	\N
104	EMP-1766255177864	\N	SonarQube	\N	\N	2025-12-20 18:26:15.919585+00	\N
105	EMP-1766255177864	\N	ELK Stack	\N	\N	2025-12-20 18:26:15.919585+00	\N
106	EMP-1766255177864	\N	Grafana	\N	\N	2025-12-20 18:26:15.919585+00	\N
107	EMP-1766255177864	\N	MS SQL	\N	\N	2025-12-20 18:26:15.919585+00	\N
108	EMP-1766255177864	\N	PostgreSQL	\N	\N	2025-12-20 18:26:15.919585+00	\N
109	EMP-1766255177864	\N	Redis	\N	\N	2025-12-20 18:26:15.919585+00	\N
110	EMP-1766255177864	\N	NoSQL	\N	\N	2025-12-20 18:26:15.919585+00	\N
111	EMP-1766255177864	\N	Figma	\N	\N	2025-12-20 18:26:15.919585+00	\N
112	EMP-1766255177864	\N	Cursor	\N	\N	2025-12-20 18:26:15.919585+00	\N
113	EMP-1766398835588	\N	C	\N	\N	2025-12-22 10:20:33.930098+00	\N
114	EMP-1766398835588	\N	C++	\N	\N	2025-12-22 10:20:33.930098+00	\N
115	EMP-1766398835588	\N	Java	\N	\N	2025-12-22 10:20:33.930098+00	\N
116	EMP-1766398835588	\N	Python	\N	\N	2025-12-22 10:20:33.930098+00	\N
117	EMP-1766398835588	\N	SQL	\N	\N	2025-12-22 10:20:33.930098+00	\N
118	EMP-1766398835588	\N	React Native	\N	\N	2025-12-22 10:20:33.930098+00	\N
119	EMP-1766398835588	\N	Spring Boot	\N	\N	2025-12-22 10:20:33.930098+00	\N
120	EMP-1766398835588	\N	React	\N	\N	2025-12-22 10:20:33.930098+00	\N
121	EMP-1766398835588	\N	HTML	\N	\N	2025-12-22 10:20:33.930098+00	\N
122	EMP-1766398835588	\N	CSS	\N	\N	2025-12-22 10:20:33.930098+00	\N
123	EMP-1766398835588	\N	MS Office Programları	\N	\N	2025-12-22 10:20:33.930098+00	\N
124	EMP-1766436935343	\N	C	\N	\N	2025-12-22 20:55:33.328939+00	\N
125	EMP-1766436935343	\N	C++	\N	\N	2025-12-22 20:55:33.328939+00	\N
126	EMP-1766436935343	\N	Java	\N	\N	2025-12-22 20:55:33.328939+00	\N
127	EMP-1766436935343	\N	Python	\N	\N	2025-12-22 20:55:33.328939+00	\N
128	EMP-1766436935343	\N	SQL	\N	\N	2025-12-22 20:55:33.328939+00	\N
129	EMP-1766436935343	\N	React Native	\N	\N	2025-12-22 20:55:33.328939+00	\N
130	EMP-1766436935343	\N	Spring Boot	\N	\N	2025-12-22 20:55:33.328939+00	\N
131	EMP-1766436935343	\N	React	\N	\N	2025-12-22 20:55:33.328939+00	\N
132	EMP-1766436935343	\N	HTML	\N	\N	2025-12-22 20:55:33.328939+00	\N
133	EMP-1766436935343	\N	CSS	\N	\N	2025-12-22 20:55:33.328939+00	\N
134	EMP-1766436935343	\N	REST API	\N	\N	2025-12-22 20:55:33.328939+00	\N
135	EMP-1766436935343	\N	JWT	\N	\N	2025-12-22 20:55:33.328939+00	\N
136	EMP-1766436935343	\N	PostgreSQL	\N	\N	2025-12-22 20:55:33.328939+00	\N
137	EMP-1766436935343	\N	Linux	\N	\N	2025-12-22 20:55:33.328939+00	\N
138	EMP-1766436935343	\N	MS Office Programs	\N	\N	2025-12-22 20:55:33.328939+00	\N
139	EMP-1766436935343	\N	CyberOPS	\N	\N	2025-12-22 20:55:33.328939+00	\N
140	EMP-1766436935343	\N	Introduction To Cybersecurity	\N	\N	2025-12-22 20:55:33.328939+00	\N
141	EMP-1766436935343	\N	Yapay Zeka (AI)	\N	\N	2025-12-22 20:55:33.328939+00	\N
142	EMP-1766436935343	\N	Mikroişlemci ve IoT	\N	\N	2025-12-22 20:55:33.328939+00	\N
143	EMP-1766436935343	\N	CCNA:Introduction to Networks	\N	\N	2025-12-22 20:55:33.328939+00	\N
144	EMP-1766519202434	\N	C++	\N	\N	2025-12-23 19:46:40.044516+00	\N
145	EMP-1766519202434	\N	C#	\N	\N	2025-12-23 19:46:40.044516+00	\N
146	EMP-1766519202434	\N	Java	\N	\N	2025-12-23 19:46:40.044516+00	\N
147	EMP-1766519202434	\N	Python	\N	\N	2025-12-23 19:46:40.044516+00	\N
148	EMP-1766519202434	\N	SQL	\N	\N	2025-12-23 19:46:40.044516+00	\N
149	EMP-1766519202434	\N	React Native	\N	\N	2025-12-23 19:46:40.044516+00	\N
150	EMP-1766519202434	\N	HTML/CSS	\N	\N	2025-12-23 19:46:40.044516+00	\N
151	EMP-1766519202434	\N	Spring Boot	\N	\N	2025-12-23 19:46:40.044516+00	\N
152	EMP-1766519202434	\N	React	\N	\N	2025-12-23 19:46:40.044516+00	\N
153	EMP-1766519202434	\N	React.js	\N	\N	2025-12-23 19:46:40.044516+00	\N
154	EMP-1766519202434	\N	Node.js	\N	\N	2025-12-23 19:46:40.044516+00	\N
155	EMP-1766519202434	\N	PostgreSQL	\N	\N	2025-12-23 19:46:40.044516+00	\N
156	EMP-1766519202434	\N	MS Office Programları	\N	\N	2025-12-23 19:46:40.044516+00	\N
157	EMP-1766519202434	\N	JWT	\N	\N	2025-12-23 19:46:40.044516+00	\N
158	EMP-1766519202434	\N	REST API	\N	\N	2025-12-23 19:46:40.044516+00	\N
159	EMP-1766519202434	\N	Yapay Zeka	\N	\N	2025-12-23 19:46:40.044516+00	\N
160	EMP-1766519202434	\N	Chatbot	\N	\N	2025-12-23 19:46:40.044516+00	\N
161	EMP-1766519202434	\N	Linux	\N	\N	2025-12-23 19:46:40.044516+00	\N
162	EMP-1766519616749	\N	C#	\N	\N	2025-12-23 19:53:34.266207+00	\N
163	EMP-1766519616749	\N	TypeScript	\N	\N	2025-12-23 19:53:34.266207+00	\N
164	EMP-1766519616749	\N	Python	\N	\N	2025-12-23 19:53:34.266207+00	\N
165	EMP-1766519616749	\N	Java	\N	\N	2025-12-23 19:53:34.266207+00	\N
166	EMP-1766519616749	\N	.NET	\N	\N	2025-12-23 19:53:34.266207+00	\N
167	EMP-1766519616749	\N	ASP.NET	\N	\N	2025-12-23 19:53:34.266207+00	\N
168	EMP-1766519616749	\N	React	\N	\N	2025-12-23 19:53:34.266207+00	\N
169	EMP-1766519616749	\N	Next.js	\N	\N	2025-12-23 19:53:34.266207+00	\N
170	EMP-1766519616749	\N	NestJS	\N	\N	2025-12-23 19:53:34.266207+00	\N
171	EMP-1766519616749	\N	Node.js	\N	\N	2025-12-23 19:53:34.266207+00	\N
172	EMP-1766519616749	\N	Expo	\N	\N	2025-12-23 19:53:34.266207+00	\N
173	EMP-1766519616749	\N	Azure DevOps	\N	\N	2025-12-23 19:53:34.266207+00	\N
174	EMP-1766519616749	\N	GitHub Actions	\N	\N	2025-12-23 19:53:34.266207+00	\N
175	EMP-1766519616749	\N	Docker	\N	\N	2025-12-23 19:53:34.266207+00	\N
176	EMP-1766519616749	\N	SonarQube	\N	\N	2025-12-23 19:53:34.266207+00	\N
177	EMP-1766519616749	\N	ELK Stack	\N	\N	2025-12-23 19:53:34.266207+00	\N
178	EMP-1766519616749	\N	Grafana	\N	\N	2025-12-23 19:53:34.266207+00	\N
179	EMP-1766519616749	\N	MS SQL	\N	\N	2025-12-23 19:53:34.266207+00	\N
180	EMP-1766519616749	\N	PostgreSQL	\N	\N	2025-12-23 19:53:34.266207+00	\N
181	EMP-1766519616749	\N	Redis	\N	\N	2025-12-23 19:53:34.266207+00	\N
182	EMP-1766519616749	\N	NoSQL	\N	\N	2025-12-23 19:53:34.266207+00	\N
183	EMP-1766519616749	\N	Figma	\N	\N	2025-12-23 19:53:34.266207+00	\N
184	EMP-1766519616749	\N	Cursor	\N	\N	2025-12-23 19:53:34.266207+00	\N
191	EMP-1766519936675	\N	IBM CICS	\N	\N	2025-12-23 19:58:54.584036+00	\N
192	EMP-1766519936675	\N	IBM MQ	\N	\N	2025-12-23 19:58:54.584036+00	\N
193	EMP-1766519936675	\N	JCL	\N	\N	2025-12-23 19:58:54.584036+00	\N
194	EMP-1766519936675	\N	RabbitMQ	\N	\N	2025-12-23 19:58:54.584036+00	\N
195	EMP-1766519936675	\N	SSRS	\N	\N	2025-12-23 19:58:54.584036+00	\N
196	EMP-1766519936675	\N	MS SQL	\N	\N	2025-12-23 19:58:54.584036+00	\N
203	EMP-1766521577842	\N	IBM CICS	\N	\N	2025-12-23 20:26:15.628619+00	\N
204	EMP-1766521577842	\N	IBM MQ	\N	\N	2025-12-23 20:26:15.628619+00	\N
205	EMP-1766521577842	\N	JCL (entry-level)	\N	\N	2025-12-23 20:26:15.628619+00	\N
206	EMP-1766521577842	\N	RabbitMQ (entry-level)	\N	\N	2025-12-23 20:26:15.628619+00	\N
207	EMP-1766521577842	\N	SSRS	\N	\N	2025-12-23 20:26:15.628619+00	\N
208	EMP-1766521577842	\N	MS SQL	\N	\N	2025-12-23 20:26:15.628619+00	\N
\.


--
-- Data for Name: candidate_volunteering; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_volunteering (id, candidate_id, role, organization, start_date, end_date, is_current, created_at, updated_at) FROM stdin;
1	EMP-1766239092988	Founder and Leader	University's first hackathon/ideathon team	\N	\N	f	2025-12-20 13:58:10.850979+00	\N
2	EMP-1766239092988	Chairman	Mühendis Beyinler Club	\N	\N	f	2025-12-20 13:58:10.850979+00	\N
3	EMP-1766239676620	Co-founder and Leader	LOOP Software & Idea Development Team	\N	\N	f	2025-12-20 14:07:54.362886+00	\N
4	EMP-1766239676620	Chairman	Largest university club (500+ active members)	\N	\N	f	2025-12-20 14:07:54.362886+00	\N
5	EMP-1766255177864	Co-founder and Leader	LOOP Software & Idea Development Team	\N	\N	f	2025-12-20 18:26:15.919585+00	\N
6	EMP-1766255177864	Chair	University Club	\N	\N	f	2025-12-20 18:26:15.919585+00	\N
7	EMP-1766398835588	Başkan Yardımcısı	DOU Mühendis Beyinler Kulübü	2025-01-01	2025-11-01	f	2025-12-22 10:20:33.930098+00	\N
8	EMP-1766398835588	Genel Sekreter	DOU Mühendis Beyinler Kulübü	2024-09-01	2025-01-01	f	2025-12-22 10:20:33.930098+00	\N
9	EMP-1766398835588	Koordinasyon Kurulu Üyesi	DOU Mühendis Beyinler Kulübü	2024-01-01	2024-09-01	f	2025-12-22 10:20:33.930098+00	\N
10	EMP-1766436935343	Başkan Yardımcısı	DOU Mühendis Beyinler Kulübü	2025-10-01	2025-11-01	f	2025-12-22 20:55:33.328939+00	\N
11	EMP-1766436935343	Genel Sekreter	DOU Mühendis Beyinler Kulübü	2024-09-01	2025-01-01	f	2025-12-22 20:55:33.328939+00	\N
12	EMP-1766436935343	Koordinasyon Kurulu Üyesi	DOU Mühendis Beyinler Kulübü	2024-01-01	2024-09-01	f	2025-12-22 20:55:33.328939+00	\N
13	EMP-1766519202434	Başkan Yardımcısı	Dönemeyim Mühendisler Kulübü	2025-02-01	2025-05-01	f	2025-12-23 19:46:40.044516+00	\N
14	EMP-1766519202434	Genel Sekreter	Dönemeyim Mühendisler Kulübü	2024-02-01	2024-05-01	f	2025-12-23 19:46:40.044516+00	\N
15	EMP-1766519202434	Koordinasyon Kurulu Üyesi	Doğuş Üniversitesi Yazılım Mühendisliği	2024-02-01	2024-05-01	f	2025-12-23 19:46:40.044516+00	\N
16	EMP-1766519616749	Club Chair	University Club	\N	\N	f	2025-12-23 19:53:34.266207+00	\N
19	EMP-1766519936675	Founder and Leader	Dogus University's first hackathon/ideathon team	\N	\N	f	2025-12-23 19:58:54.584036+00	\N
20	EMP-1766519936675	Chairman	Mühendis Beyinler Club	\N	\N	f	2025-12-23 19:58:54.584036+00	\N
23	EMP-1766521577842	Founder and Leader of the university's first hackathon/ideathon team	Dogus University	\N	\N	f	2025-12-23 20:26:15.628619+00	\N
24	EMP-1766521577842	Chairman of the Mühendis Beyinler Club	Dogus University	\N	\N	f	2025-12-23 20:26:15.628619+00	\N
\.


--
-- Data for Name: candidate_volunteering_responsibilities; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_volunteering_responsibilities (id, volunteering_id, responsibility) FROM stdin;
1	1	Founded and led the university's first hackathon/ideathon team.
2	2	Overseeing operations and student engagement.
3	2	Organized technical events, workshops, and seminars to support practical skill development.
4	3	Managed 15+ students.
5	3	Delivered 5+ real-world software projects, including AI-powered and disaster communication systems.
6	3	Guided the team to the Teknofest Finals, achieving a national 5th place ranking.
7	4	Organized 10+ technical and career events and increasing engagement by 40%.
8	4	Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community.
9	5	Managed 15+ students
10	5	Delivered 5+ real-world software projects, including AI-powered and disaster communication systems
11	5	Guided the team to the Teknofest Finals, achieving a national 5th place ranking through innovation and teamwork.
12	6	Chaired one of the largest university clubs with 500+ active members
13	6	Organized 10+ technical and career events
14	6	Increased engagement by 40%
15	6	Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community.
16	7	Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.
17	7	Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı.
18	8	Kulübün idari işleyişini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.
19	8	Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim.
20	9	Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim.
21	10	Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.
22	10	Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı.
23	11	Kulübün idari işleyişini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.
24	11	Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim.
25	12	Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim.
26	13	Stratejik planlamada, etkinliklerin organizasyonunda ve ekiplerin yönetiminde önemli sorumluluklar üstlendim.
27	13	Üyeler arası koordinasyonu sağlamak, projelerin etkin şekilde yürütülmesine destek olmak ve kulübün gelişimi için yeni fırsatlar yaratmak öncelikli görevlerim arasındaydı.
28	14	Kulübün idari işlevini düzenleyerek etkinlik süreçlerinin verimli ilerlemesini sağladım.
29	14	Resmi yazışmalar, toplantı organizasyonları ve kulüp içi iletişimi yöneterek birimler arası koordinasyonu güçlendirdim.
30	15	Bu süreçte etkinliklerin düzenlenmesi ve projelerin yönetiminde önemli sorumluluklar üstlendim.
31	16	Chaired one of the largest university clubs with 500+ active members
32	16	Organized 10+ technical and career events
33	16	Increased engagement by 40%
34	16	Established industry collaborations and sponsorships, enhancing project sustainability and visibility across the tech community
38	19	Founded and led the university's first hackathon/ideathon team.
39	20	Overseeing operations and student engagement.
40	20	Organized technical events, workshops, and seminars to support practical skill development.
43	24	Overseeing operations and student engagement.
44	24	Organized technical events, workshops, and seminars to support practical skill development.
\.


--
-- Data for Name: candidate_work_experience; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_work_experience (id, candidate_id, job_title, company, employment_type, country, city, start_date, end_date, is_current, description, created_at, updated_at) FROM stdin;
1	EMP-TEST-123456	Senior Software Engineer	Tech Company Inc.	Full-time	Turkey	Istanbul	2020-01-01	\N	t	\N	2025-12-19 10:28:09.601007+00	\N
2	EMP-1766141328216	Chairman of the Board	Mühendis Beyinler Kulübü (Engineer Brains Club)				2025-02-01	\N	t	\N	2025-12-19 12:30:15.325018+00	\N
3	EMP-1766141328216	Junior Software Developer	Loop "Yazılım ve Fikir Geliştirme" Team				2025-01-01	\N	t	\N	2025-12-19 12:30:15.325018+00	\N
4	EMP-1766239092988	System Engineer Assistant	Garanti BBVA Technology		Turkiye	Istanbul	2023-06-01	\N	t	\N	2025-12-20 13:58:10.850979+00	\N
5	EMP-1766239676620	Software Development Intern	Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)	Internship			2024-10-01	2025-04-01	t	\N	2025-12-20 14:07:54.362886+00	\N
6	EMP-1766239676620	Product Owner Intern	Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)	Internship			2024-06-01	2024-10-01	f	\N	2025-12-20 14:07:54.362886+00	\N
7	EMP-1766252302499	Software Developer	DOU LOOP "Yazılım ve Fikir Geliştirme" Takımı		Turkey	Istanbul	2024-04-01	\N	t	\N	2025-12-20 17:38:20.827172+00	\N
8	EMP-1766252302499	Intern Engineer	Akgün Group		Turkey	Istanbul	2024-08-01	2024-09-01	f	\N	2025-12-20 17:38:20.827172+00	\N
9	EMP-1766252302499	Intern Engineer	Akgün Group		Turkey	Istanbul	2025-07-01	2025-08-01	f	\N	2025-12-20 17:38:20.827172+00	\N
10	EMP-1766252302499	Intern Engineer	Depauli Systems				2025-08-01	2025-09-01	f	\N	2025-12-20 17:38:20.827172+00	\N
11	EMP-1766254966950	Software Developer	DOU LOOP "Yazılım ve Fikir Geliştirme" Takımı				2024-04-01	\N	t	\N	2025-12-20 18:22:45.100317+00	\N
12	EMP-1766254966950	Intern Engineer	Akgün Group		Turkey	Istanbul	2024-08-01	2024-09-01	f	\N	2025-12-20 18:22:45.100317+00	\N
13	EMP-1766254966950	Intern Engineer	Akgün Group		Turkey	Istanbul	2025-07-01	2025-08-01	f	\N	2025-12-20 18:22:45.100317+00	\N
14	EMP-1766254966950	Intern Engineer	Depauli Systems		Turkey	Istanbul	2025-08-01	2025-09-01	f	\N	2025-12-20 18:22:45.100317+00	\N
15	EMP-1766255177864	Software Development Intern	Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)	Internship			2024-10-01	2025-04-01	f	\N	2025-12-20 18:26:15.919585+00	\N
16	EMP-1766255177864	Product Owner Intern	Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)	Internship			2024-06-01	2024-10-01	f	\N	2025-12-20 18:26:15.919585+00	\N
17	EMP-1766398835588	Yapay Zeka Ar-Ge Stajyeri	ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.	Internship			2024-07-01	2024-09-01	f	\N	2025-12-22 10:20:33.930098+00	\N
18	EMP-1766398835588	Yazılım Geliştirme Stajyeri	ETİYA BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.	Internship			2025-08-01	2025-09-01	f	\N	2025-12-22 10:20:33.930098+00	\N
19	EMP-1766436935343	Yapay Zeka Ar-Ge Stajyeri	ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.	Internship			2024-07-01	2024-09-01	f	\N	2025-12-22 20:55:33.328939+00	\N
20	EMP-1766436935343	Yazılım Geliştirme Stajyeri	ETİYA BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.	Internship			2025-08-01	2025-09-01	f	\N	2025-12-22 20:55:33.328939+00	\N
21	EMP-1766519202434	Yazılım Geliştirme Stajyeri	ETKİ YERİ BİLGİ TEKNOLOJİLERİ YAZILIM SANAYİ VE TİCARET A.Ş.	Stajyer			2025-08-01	2025-09-01	f	\N	2025-12-23 19:46:40.044516+00	\N
22	EMP-1766519202434	Yapay Zeka Ar-Ge Stajyeri	ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.	Stajyer			2024-07-01	2024-09-01	f	\N	2025-12-23 19:46:40.044516+00	\N
23	EMP-1766519202434	Yazılım Geliştirme Core Team Üyesi	DOĞUŞ LOUP 'Yazılım ve Fikir Geliştirme' Takımı	Part-time			2023-04-01	\N	t	\N	2025-12-23 19:46:40.044516+00	\N
24	EMP-1766519616749	Software Development Intern	Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)	Internship			2024-10-01	2025-04-01	f	\N	2025-12-23 19:53:34.266207+00	\N
25	EMP-1766519616749	Product Owner Intern	Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)	Internship			2024-06-01	2024-10-01	f	\N	2025-12-23 19:53:34.266207+00	\N
27	EMP-1766519936675	System Engineer Assistant	Garanti BBVA Technology				2023-06-01	\N	t	\N	2025-12-23 19:58:54.584036+00	\N
29	EMP-1766521577842	System Engineer Assistant	Garanti BBVA Technology				2023-06-01	\N	t	\N	2025-12-23 20:26:15.628619+00	\N
\.


--
-- Data for Name: candidate_work_experience_achievements; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_work_experience_achievements (id, work_experience_id, achievement, display_order) FROM stdin;
1	1	Improved system performance by 40%	0
2	6	Contributed to on-time delivery of key product features.	0
\.


--
-- Data for Name: candidate_work_experience_responsibilities; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_work_experience_responsibilities (id, work_experience_id, responsibility, display_order) FROM stdin;
1	1	Led development of microservices architecture	0
2	1	Mentored junior developers	0
3	2	Served as the Chairman for the university's most active student community. Led and managed a 6-person executive team, establishing the club's annual strategic roadmap and event calendar.	0
4	2	Successfully managed the planning, budgeting, and operational processes for 20-25 annual events, including technical seminars, workshops, and social activities.	0
5	2	Strengthened communication between members and sub-committees, optimizing task allocation and performance tracking processes. Increased the number of active members through initiatives aimed at enhancing member engagement.	0
6	2	Managed corporate communications with industry professionals and sponsor companies, securing both financial and in-kind resources for the club.	0
7	3	Actively contributed to the front-end development of web-based projects, participating in all stages of the SDLC (analysis, coding, and testing).	0
8	3	Applied foundational knowledge of Python and Java to web projects, gaining hands-on experience with React. Focused on building modular architectures and ensuring code reusability.	0
9	3	Led internal brainstorming sessions to drive idea generation. Delivered creative solutions to technical challenges, ensuring projects were completed within deadlines.	0
10	4	Created initial definitions for CICS environments systems.	0
11	4	Performed process monitoring, error handling, and basic configuration on IBM CICS.	0
12	4	Worked with queue and channel structures on IBM MQ, monitoring message flows.	0
13	4	Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.	0
14	4	Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.	0
15	4	Generated internal reports from daily log data using SSRS.	0
16	4	Collaborated with cross-functional teams (network, application, and database) to resolve system issues.	0
17	4	Tracked job logs, analyzed system messages, and conducted initial error analysis.	0
18	4	Wrote entry-level JCL scripts to initiate and monitor basic batch jobs	0
19	5	Developed full-stack applications using .NET, React, and Azure DevOps.	0
20	5	Collaborated with QA and DevOps teams to enhance software scalability.	0
21	6	Managed product backlog and prioritized tasks using Agile development methodologies.	0
22	6	Defined user stories and acceptance criteria to align development with business goals.	0
23	6	Facilitated communication between stakeholders and technical teams.	0
24	6	Contributed to on-time delivery of key product features.	0
25	7	In addition to developing modern and scalable web projects using React, TypeScript, and Next.js, we design and implement innovative mobile applications with React Native and various other technologies.	0
26	7	By participating in hackathons and various software competitions with our projects, we showcase our skills, enhance our teamwork, and improve our problem-solving abilities.	0
27	8	Gaining experience with PostgreSQL databases, I developed web projects using React and Next.js.	0
28	8	Throughout this process, I had the opportunity to gain industry insight and hands-on experience.	0
29	9	I developed a web-based micro ERP system using .NET (C#), Next.js, and PostgreSQL.	0
30	9	Integrated Gemini AI modules to enable sales forecasting, price optimization, automated product content generation, and market trend analysis.	0
31	10	During my internship, I developed Prompt Bridge a user-friendly platform using .NET C# (backend) and Next.js (frontend).	0
32	10	The system integrates three different AI models into a single panel, enabling a sequential structure where the output of one model automatically becomes the input of the next.	0
33	11	In addition to developing modern and scalable web projects using React, TypeScript, and Next.js, we design and implement innovative mobile applications with React Native and various other technologies.	0
34	11	By participating in hackathons and various software competitions with our projects, we showcase our skills, enhance our teamwork, and improve our problem-solving abilities.	0
35	12	Gaining experience with PostgreSQL databases, I developed web projects using React and Next.js.	0
36	12	Throughout this process, I had the opportunity to gain industry insight and hands-on experience.	0
37	13	I developed a web-based micro ERP system using .NET (C#), Next.js, and PostgreSQL.	0
38	13	Integrated Gemini AI modules to enable sales forecasting, price optimization, automated product content generation, and market trend analysis.	0
39	14	During my internship, I developed Prompt Bridge a user-friendly platform using .NET C# (backend) and Next.js (frontend).	0
40	14	The system integrates three different AI models into a single panel, enabling a sequential structure where the output of one model automatically becomes the input of the next.	0
41	15	Developed full-stack applications using .NET, React, and Azure DevOps.	0
42	15	Collaborated with QA and DevOps teams to enhance software scalability.	0
43	16	Managed product backlog and prioritized tasks using Agile development methodologies.	0
44	16	Defined user stories and acceptance criteria to align development with business goals.	0
45	16	Facilitated communication between stakeholders and technical teams.	0
46	16	Contributed to on-time delivery of key product features.	0
47	17	Bu staj sürecinde, Node.js ve Pythonla yapay zeka destekli bir LMS projesi geliştirdim.	0
48	17	Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.	0
49	17	Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.	0
50	17	Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim.	0
51	18	Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.	0
52	18	Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.	0
53	18	Backend tarafında PostgreSQL kullanarak relational veritabanı tasarladım ve REST API'leri geliştirdim.	0
54	18	Frontend tarafında React ile responsive bir arayüz oluşturdum.	0
55	18	Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım.	0
56	19	Bu staj sürecinde, Node.js ve Pythonla yapay zeka destekli bir LMS projesi geliştirdim.	0
57	19	Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.	0
58	19	Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.	0
59	19	Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim.	0
60	20	Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.	0
61	20	Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.	0
62	20	Backend tarafında PostgreSQL kullanarak relational veritabanı tasarladım ve REST API'leri geliştirdim.	0
63	20	Frontend tarafında React ile responsive bir arayüz oluşturdum.	0
64	20	Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım.	0
65	21	Spring Boot ve React tabanlı bir telecom e-commerce platformu geliştirdim.	0
66	21	Kullanıcı kayıt/giriş, JWT tabanlı authentication, ürün listeleme & filtreleme, sepet ve sipariş yönetimi gibi modülleri implemente ettim.	0
67	21	Back-end tarafında PostgreSQL relational database kullandım ve REST API'leri geliştirdim.	0
68	21	Frontend tarafında ise React.js ile responsive arayüz oluşturdum.	0
69	21	Ayrıca admin paneli, rol yönetimi ve ürün CRUD fonksiyonlarını ekleyerek sistemin yönetimsel tarafını da tamamladım.	0
70	22	Bu staj sürecinde, Node.js ve Python'la yapay zeka destekli bir LMS projesi geliştirdim.	0
71	22	Öğrenme sürecini iyileştiren bir model geliştirmenin yanı sıra, yüz ve ses tanıma ile giriş sistemi ve chatbot entegrasyonu yaptım.	0
72	22	Yapay zeka algoritmalarının entegrasyonu, eğitim verilerinin analizi ve proje takibi gibi sorumluluklar üstlendim.	0
73	22	Bu süreçte yazılım geliştirme ve problem çözme becerilerimi derinleştirdim.	0
74	23	Yazılım Mühendisliği projelerinde yer aldım.	0
75	23	Yazılım mühendisliği bilimi pratiğe dökme fırsatı bulurken, React Native öğreniyorum.	0
76	23	Ayrıca, takım içinde işbirliği ve problem çözme becerilerimi geliştirdim.	0
77	24	Developed full-stack applications using .NET, React, and Azure DevOps.	0
78	24	Collaborated with QA and DevOps teams to enhance software scalability.	0
79	25	Managed product backlog and prioritized tasks using Agile development methodologies.	0
80	25	Defined user stories and acceptance criteria to align development with business goals.	0
81	25	Facilitated communication between stakeholders and technical teams.	0
82	25	Contributed to on-time delivery of key product features.	0
92	27	Created initial definitions for CICS environments systems.	0
93	27	Performed process monitoring, error handling, and basic configuration on IBM CICS.	0
94	27	Worked with queue and channel structures on IBM MQ, monitoring message flows.	0
95	27	Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.	0
96	27	Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.	0
97	27	Generated internal reports from daily log data using SSRS.	0
98	27	Collaborated with cross-functional teams (network, application, and database) to resolve system issues.	0
99	27	Tracked job logs, analyzed system messages, and conducted initial error analysis.	0
100	27	Wrote entry-level JCL scripts to initiate and monitor basic batch jobs.	0
110	29	Created initial definitions for CICS environments systems.	0
111	29	Performed process monitoring, error handling, and basic configuration on IBM CICS.	0
112	29	Worked with queue and channel structures on IBM MQ, monitoring message flows.	0
113	29	Supported the detection and resolution of MQ-related issues such as queue depth and connection problems.	0
114	29	Monitored system performance, transaction flows, and processing loads using tools such as OMEGAMON.	0
115	29	Generated internal reports from daily log data using SSRS.	0
116	29	Collaborated with cross-functional teams (network, application, and database) to resolve system issues.	0
117	29	Tracked job logs, analyzed system messages, and conducted initial error analysis.	0
118	29	Wrote entry-level JCL scripts to initiate and monitor basic batch jobs	0
\.


--
-- Data for Name: candidate_work_experience_technologies; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidate_work_experience_technologies (id, work_experience_id, technology) FROM stdin;
1	1	Python
2	1	FastAPI
3	1	PostgreSQL
4	1	Docker
5	3	Python
6	3	Java
7	3	React
8	4	IBM CICS
9	4	IBM MQ
10	4	OMEGAMON
11	4	SSRS
12	4	JCL
13	5	.NET
14	5	React
15	5	Azure DevOps
16	6	Agile
17	7	React
18	7	TypeScript
19	7	Next.js
20	7	React Native
21	8	PostgreSQL
22	8	React
23	8	Next.js
24	9	.NET
25	9	C#
26	9	Next.js
27	9	PostgreSQL
28	9	Gemini AI
29	10	.NET C#
30	10	Next.js
31	10	AI models
32	11	React
33	11	TypeScript
34	11	Next.js
35	11	React Native
36	12	PostgreSQL
37	12	React
38	12	Next.js
39	13	.NET (C#)
40	13	Next.js
41	13	PostgreSQL
42	13	Gemini AI
43	14	.NET C#
44	14	Next.js
45	15	.NET
46	15	React
47	15	Azure DevOps
48	16	Agile
49	17	Node.js
50	17	Python
51	17	Yapay Zeka (AI)
52	17	Chatbot
53	18	Spring Boot
54	18	React
55	18	JWT
56	18	PostgreSQL
57	18	REST API
58	19	Node.js
59	19	Python
60	19	Yapay Zeka
61	20	Spring Boot
62	20	React
63	20	JWT
64	20	PostgreSQL
65	20	REST API
66	21	Spring Boot
67	21	React
68	21	JWT
69	21	PostgreSQL
70	21	REST API
71	21	React.js
72	22	Node.js
73	22	Python
74	22	Yapay Zeka
75	22	Chatbot
76	23	React Native
77	24	.NET
78	24	React
79	24	Azure DevOps
85	27	IBM CICS
86	27	IBM MQ
87	27	OMEGAMON
88	27	SSRS
89	27	JCL
\.


--
-- Data for Name: candidates; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.candidates (id, candidate_id, full_name, email, phone, original_filename, file_url, source, completeness_score, profile_status, total_experience_years, current_position, current_company, highest_degree, field_of_study, institution, certifications_count, projects_count, volunteering_count, "timestamp", processed_date, last_updated, created_at, updated_at) FROM stdin;
1	EMP-TEST-123456	Test Candidate	test@example.com	+1234567890	test_cv.pdf	\N	CV Upload - AI Parsed	95	Complete	5.5	Senior Software Engineer	Tech Company Inc.	Bachelor's	Computer Science	Test University	0	1	0	2025-12-19 10:28:09.601007+00	2025-12-19 10:28:09.601007+00	2025-12-19 10:28:09.601007+00	2025-12-19 10:28:09.601007+00	\N
2	EMP-1766141328216	Muhammet Şahin Yıldırım	muhammetsahinyildirim@gmail.com	+905067002739	unknown.pdf	\N	CV Upload - AI Parsed	90	Complete	1.8	Chairman of the Board	Mühendis Beyinler Kulübü (Engineer Brains Club)	B.Sc.	Computer Engineering	Doğuş University	0	3	0	2025-12-19 12:30:15.325018+00	2025-12-19 12:30:15.325018+00	2025-12-19 12:30:15.325018+00	2025-12-19 12:30:15.325018+00	\N
3	EMP-1766239092988	MUHAMMED CIHAN	muhammed.cihan@hotmail.com	+905350659595	unknown.pdf	\N	CV Upload - AI Parsed	95	Complete	2.5	System Engineer Assistant	Garanti BBVA Technology	Bachelor of Science	Computer Engineering	Dogus University	4	0	2	2025-12-20 13:58:10.850979+00	2025-12-20 13:58:10.850979+00	2025-12-20 13:58:10.850979+00	2025-12-20 13:58:10.850979+00	\N
4	EMP-1766239676620	Furkan Ulutaş	furkanulutas054@gmail.com	+905399225570	unknown.pdf	\N	CV Upload - AI Parsed	95	Complete	1.5	Software Development Intern	Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)	BSc.	Software Engineering	Doğuş University	0	1	2	2025-12-20 14:07:54.362886+00	2025-12-20 14:07:54.362886+00	2025-12-20 14:07:54.362886+00	2025-12-20 14:07:54.362886+00	\N
5	EMP-1766252302499	ZEYNEPNUR GÜNGÖR	zeynepnurgungor@icloud.com	05333903683	unknown.pdf	\N	CV Upload - AI Parsed	100	Complete	1.9	Software Developer	DOU LOOP "Yazılım ve Fikir Geliştirme" Takımı	Bachelor's Degree	Computer Engineering (%100 English)	Dogus University	2	5	0	2025-12-20 17:38:20.827172+00	2025-12-20 17:38:20.827172+00	2025-12-20 17:38:20.827172+00	2025-12-20 17:38:20.827172+00	\N
6	EMP-1766254966950	ZEYNEPNUR GÜNGÖR	zeynepnurgungor@icloud.com	05333903683	unknown.pdf	\N	CV Upload - AI Parsed	100	Complete	1.9	Software Developer	DOU LOOP "Yazılım ve Fikir Geliştirme" Takımı	Bachelor	Computer Engineering	Dogus University	2	5	0	2025-12-20 18:22:45.100317+00	2025-12-20 18:22:45.100317+00	2025-12-20 18:22:45.100317+00	2025-12-20 18:22:45.100317+00	\N
7	EMP-1766255177864	Furkan Ulutaş	furkanulutas054@gmail.com	+905399225570	unknown.pdf	\N	CV Upload - AI Parsed	90	Complete	0.8	Software Development Intern	Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)	BSc.	Software Engineering	Doğuş University	0	0	2	2025-12-20 18:26:15.919585+00	2025-12-20 18:26:15.919585+00	2025-12-20 18:26:15.919585+00	2025-12-20 18:26:15.919585+00	\N
8	EMP-1766398835588	ELANUR DEMİR	elanurdemir100@gmail.com		unknown.pdf	\N	CV Upload - AI Parsed	90	Complete	0.3	Yapay Zeka Ar-Ge Stajyeri	ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.	Not Specified	Yazılım Mühendisliği	Doğuş Üniversitesi	7	2	3	2025-12-22 10:20:33.930098+00	2025-12-22 10:20:33.930098+00	2025-12-22 10:20:33.930098+00	2025-12-22 10:20:33.930098+00	\N
9	EMP-1766436935343	ELANUR DEMİR	elanurdemir100@gmail.com		unknown.pdf	\N	CV Upload - AI Parsed	95	Complete	0.3	Yapay Zeka Ar-Ge Stajyeri	ARVİS TEKNOLOJİ SANAYİ TİCARET A.Ş.	Lisans	Yazılım Mühendisliği	Doğuş Üniversitesi	7	2	3	2025-12-22 20:55:33.328939+00	2025-12-22 20:55:33.328939+00	2025-12-22 20:55:33.328939+00	2025-12-22 20:55:33.328939+00	\N
10	EMP-1766519202434	ELANUR DEMİR	elanurdemirr1000@gmail.com	+905476508013	unknown.pdf	\N	CV Upload - AI Parsed	95	Complete	2.9	Yazılım Geliştirme Core Team Üyesi	DOĞUŞ LOUP 'Yazılım ve Fikir Geliştirme' Takımı	Lisans	Yazılım Mühendisliği	Doğuş Üniversitesi	7	0	3	2025-12-23 19:46:40.044516+00	2025-12-23 19:46:40.044516+00	2025-12-23 19:46:40.044516+00	2025-12-23 19:46:40.044516+00	\N
11	EMP-1766519616749	Furkan Ulutaş	furkanulutas054@gmail.com	+905399225570	unknown.pdf	\N	CV Upload - AI Parsed	95	Complete	0.8	Software Development Intern	Doğuş Bilgi İşlem Ve Teknoloji Hizmetleri A.Ş. (Doğuş Teknoloji)	Bachelor's degree	Software Engineering	Doğuş University	0	1	1	2025-12-23 19:53:34.266207+00	2025-12-23 19:53:34.266207+00	2025-12-23 19:53:34.266207+00	2025-12-23 19:53:34.266207+00	\N
13	EMP-1766519936675	MUHAMMED CIHAN	muhammed.cihan@hotmail.com	+905350659595	unknown.pdf	\N	CV Upload - AI Parsed	95	Complete	2.5	System Engineer Assistant	Garanti BBVA Technology	Bachelor of Science	Computer Engineering	Dogus University	4	0	2	2025-12-23 19:58:54.262502+00	2025-12-23 19:58:54.262502+00	2025-12-23 19:58:54.262502+00	2025-12-23 19:58:54.262502+00	2025-12-23 19:58:54.606946+00
14	EMP-1766521577842	MUHAMMED CIHAN	muhammed.cihan@hotmail.com	+905350659595	unknown.pdf	\N	CV Upload - AI Parsed	95	Complete	2.5	System Engineer Assistant	Garanti BBVA Technology	Bachelor of Science	Computer Engineering	Dogus University	4	0	2	2025-12-23 20:26:15.391027+00	2025-12-23 20:26:15.391027+00	2025-12-23 20:26:15.391027+00	2025-12-23 20:26:15.391027+00	2025-12-23 20:26:15.647139+00
\.


--
-- Data for Name: education_courses; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.education_courses (id, education_id, course_name, display_order) FROM stdin;
1	1	Data Structures and Algorithms	1
2	1	Operating Systems	2
3	1	Database Systems	3
4	1	Computer Networks	4
5	1	Software Engineering	5
6	2	Distributed Systems	1
7	2	Cloud Computing	2
8	2	Machine Learning	3
9	2	Advanced Algorithms	4
10	4	Strategic Management	1
11	4	Financial Accounting	2
12	4	Marketing Management	3
13	4	Operations Management	4
14	8	Machine Learning	1
15	8	Statistical Learning Theory	2
16	8	Big Data Analytics	3
17	8	Natural Language Processing	4
\.


--
-- Data for Name: employee_additional_info; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_additional_info (id, employee_id, driving_license, military_status, availability, willing_to_relocate, willing_to_travel, created_at, updated_at) FROM stdin;
1	1	Class C	Not Applicable	Currently Employed	f	t	2025-12-08 09:51:41.068329+00	\N
2	2	Class C	Not Applicable	Currently Employed	t	t	2025-12-08 09:51:41.068329+00	\N
3	3	Class C	Not Applicable	Currently Employed	f	f	2025-12-08 09:51:41.068329+00	\N
4	4	Class C	Completed	Currently Employed	t	t	2025-12-08 09:51:41.068329+00	\N
5	5	Class C	Not Applicable	Currently Employed	f	t	2025-12-08 09:51:41.068329+00	\N
6	6	Class C	Not Applicable	Available Immediately	t	t	2025-12-08 09:51:41.068329+00	\N
7	7	Class C	Not Applicable	Currently Employed	f	f	2025-12-08 09:51:41.068329+00	\N
8	8	Class B	Not Applicable	Currently Employed	t	t	2025-12-08 09:51:41.068329+00	\N
\.


--
-- Data for Name: employee_addresses; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_addresses (id, employee_id, address_type, country, city, street, postal_code, is_current, created_at, updated_at) FROM stdin;
9	1	primary	United States	San Francisco	123 Market Street, Apt 4B	94102	t	2025-12-08 09:51:40.906927+00	\N
10	2	primary	United States	Seattle	456 Pine Avenue	98101	t	2025-12-08 09:51:40.906927+00	\N
11	3	primary	United States	Austin	789 Congress Ave, Unit 12	78701	t	2025-12-08 09:51:40.906927+00	\N
12	4	primary	United States	New York	321 Broadway, Floor 5	10007	t	2025-12-08 09:51:40.906927+00	\N
13	5	primary	United States	Boston	654 Commonwealth Ave	02215	t	2025-12-08 09:51:40.906927+00	\N
14	6	primary	United States	Chicago	987 Michigan Ave	60611	f	2025-12-08 09:51:40.906927+00	\N
15	7	primary	United States	Los Angeles	147 Sunset Blvd	90028	t	2025-12-08 09:51:40.906927+00	\N
16	8	primary	United States	Denver	258 16th Street	80202	t	2025-12-08 09:51:40.906927+00	\N
\.


--
-- Data for Name: employee_awards; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_awards (id, employee_id, award_name, issuer, award_date, description, created_at, updated_at) FROM stdin;
1	1	Engineer of the Year	Current Company	2022-12-15	Recognized for outstanding technical contributions and leadership	2025-12-08 09:51:41.053208+00	\N
2	1	Hackathon Winner	TechCorp Annual Hackathon	2018-11-20	First place for building innovative payment processing solution	2025-12-08 09:51:41.053208+00	\N
3	2	Product Excellence Award	Current Company	2022-12-15	Awarded for successful launch of mobile application	2025-12-08 09:51:41.053208+00	\N
4	3	Best Design Portfolio	Design Conference 2022	2022-06-10	Recognition for exceptional UX/UI work	2025-12-08 09:51:41.053208+00	\N
5	4	Best Paper Award	ICML 2021	2021-07-18	Received best paper award at International Conference on Machine Learning	2025-12-08 09:51:41.053208+00	\N
6	4	Outstanding Graduate Student	MIT	2018-05-20	Awarded for exceptional academic performance and research	2025-12-08 09:51:41.053208+00	\N
7	5	Innovation Award	Current Company	2021-12-10	Recognized for implementing cost-saving cloud infrastructure	2025-12-08 09:51:41.053208+00	\N
8	7	HR Leader of the Year	HR Excellence Awards	2020-10-15	Recognized for innovative HR programs and employee engagement initiatives	2025-12-08 09:51:41.053208+00	\N
\.


--
-- Data for Name: employee_certifications; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_certifications (id, employee_id, certification_name, issuing_organization, issue_date, expiration_date, credential_id, credential_url, does_not_expire, created_at, updated_at) FROM stdin;
1	1	AWS Certified Solutions Architect - Professional	Amazon Web Services	2022-06-15	2025-06-15	AWS-PSA-12345	https://aws.amazon.com/verification/12345	f	2025-12-08 09:51:41.015051+00	\N
2	1	Certified Kubernetes Administrator	Cloud Native Computing Foundation	2021-09-20	2024-09-20	CKA-67890	https://cncf.io/certification/cka/67890	f	2025-12-08 09:51:41.015051+00	\N
3	2	Certified Scrum Product Owner	Scrum Alliance	2020-03-10	\N	CSPO-54321	https://scrumalliance.org/54321	t	2025-12-08 09:51:41.015051+00	\N
4	2	Product Management Certificate	Product School	2019-11-05	\N	PM-98765	\N	t	2025-12-08 09:51:41.015051+00	\N
5	4	TensorFlow Developer Certificate	Google	2021-04-20	2024-04-20	TF-11111	https://developers.google.com/certification/11111	f	2025-12-08 09:51:41.015051+00	\N
6	4	AWS Certified Machine Learning - Specialty	Amazon Web Services	2022-08-15	2025-08-15	AWS-ML-22222	https://aws.amazon.com/verification/22222	f	2025-12-08 09:51:41.015051+00	\N
7	5	AWS Certified DevOps Engineer - Professional	Amazon Web Services	2021-07-10	2024-07-10	AWS-DOP-33333	https://aws.amazon.com/verification/33333	f	2025-12-08 09:51:41.015051+00	\N
8	5	Certified Kubernetes Security Specialist	Cloud Native Computing Foundation	2022-10-05	2025-10-05	CKS-44444	https://cncf.io/certification/cks/44444	f	2025-12-08 09:51:41.015051+00	\N
9	7	SHRM Senior Certified Professional	Society for Human Resource Management	2019-05-15	\N	SHRM-SCP-55555	https://shrm.org/certification/55555	t	2025-12-08 09:51:41.015051+00	\N
10	7	Professional in Human Resources	HR Certification Institute	2015-08-20	\N	PHR-66666	\N	t	2025-12-08 09:51:41.015051+00	\N
\.


--
-- Data for Name: employee_education; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_education (id, employee_id, institution, degree, field_of_study, gpa, start_date, end_date, is_current, thesis, created_at, updated_at) FROM stdin;
1	1	Stanford University	Bachelor of Science	Computer Science	3.85	2011-09-01	2015-06-15	f	\N	2025-12-08 09:51:40.963103+00	\N
2	1	Stanford University	Master of Science	Computer Science	3.92	2015-09-01	2017-06-15	f	Optimization Techniques for Distributed Systems	2025-12-08 09:51:40.963103+00	\N
3	2	University of Toronto	Bachelor of Commerce	Business Administration	3.75	2010-09-01	2014-06-30	f	\N	2025-12-08 09:51:40.963103+00	\N
4	2	Harvard Business School	Master of Business Administration	MBA	3.88	2015-09-01	2017-05-25	f	\N	2025-12-08 09:51:40.963103+00	\N
5	3	Universidad Nacional Autónoma de México	Bachelor of Fine Arts	Graphic Design	3.70	2013-08-15	2017-06-20	f	\N	2025-12-08 09:51:40.963103+00	\N
6	3	Rhode Island School of Design	Certificate	UX/UI Design	\N	2018-01-10	2018-12-20	f	\N	2025-12-08 09:51:40.963103+00	\N
7	4	Indian Institute of Technology Delhi	Bachelor of Technology	Computer Science	3.95	2012-07-01	2016-05-30	f	\N	2025-12-08 09:51:40.963103+00	\N
8	4	MIT	Master of Science	Data Science	4.00	2016-09-01	2018-05-20	f	Deep Learning Approaches for Natural Language Processing	2025-12-08 09:51:40.963103+00	\N
9	4	MIT	Doctor of Philosophy	Machine Learning	3.98	2018-09-01	2022-05-15	f	Novel Architectures for Transfer Learning in Computer Vision	2025-12-08 09:51:40.963103+00	\N
10	5	University of Manchester	Bachelor of Science	Information Technology	3.65	2010-09-01	2014-06-25	f	\N	2025-12-08 09:51:40.963103+00	\N
11	6	University of Illinois	Bachelor of Science	Marketing	3.60	2007-08-20	2011-05-15	f	\N	2025-12-08 09:51:40.963103+00	\N
12	7	UCLA	Bachelor of Arts	Psychology	3.72	2005-09-01	2009-06-10	f	\N	2025-12-08 09:51:40.963103+00	\N
13	7	Cornell University	Master of Science	Human Resources Management	3.85	2012-09-01	2014-05-20	f	\N	2025-12-08 09:51:40.963103+00	\N
14	8	Universidad Politécnica de Madrid	Bachelor of Science	Software Engineering	3.80	2014-09-01	2018-06-30	f	\N	2025-12-08 09:51:40.963103+00	\N
\.


--
-- Data for Name: employee_hobbies; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_hobbies (id, employee_id, hobby, created_at) FROM stdin;
1	1	Photography	2025-12-08 09:51:41.07463+00
2	1	Hiking	2025-12-08 09:51:41.07463+00
3	1	Reading Tech Blogs	2025-12-08 09:51:41.07463+00
4	1	Playing Guitar	2025-12-08 09:51:41.07463+00
5	2	Running Marathons	2025-12-08 09:51:41.07463+00
6	2	Chess	2025-12-08 09:51:41.07463+00
7	2	Reading Business Books	2025-12-08 09:51:41.07463+00
8	3	Painting	2025-12-08 09:51:41.07463+00
9	3	Yoga	2025-12-08 09:51:41.07463+00
10	3	Traveling	2025-12-08 09:51:41.07463+00
11	3	Cooking	2025-12-08 09:51:41.07463+00
12	4	Reading Research Papers	2025-12-08 09:51:41.07463+00
13	4	Cricket	2025-12-08 09:51:41.07463+00
14	4	Playing Piano	2025-12-08 09:51:41.07463+00
15	4	Meditation	2025-12-08 09:51:41.07463+00
16	5	Rock Climbing	2025-12-08 09:51:41.07463+00
17	5	Home Automation Projects	2025-12-08 09:51:41.07463+00
18	5	Cycling	2025-12-08 09:51:41.07463+00
19	6	Golf	2025-12-08 09:51:41.07463+00
20	6	Wine Tasting	2025-12-08 09:51:41.07463+00
21	6	Sailing	2025-12-08 09:51:41.07463+00
22	7	Gardening	2025-12-08 09:51:41.07463+00
23	7	Book Club	2025-12-08 09:51:41.07463+00
24	7	Volunteering	2025-12-08 09:51:41.07463+00
25	8	Soccer	2025-12-08 09:51:41.07463+00
26	8	Gaming	2025-12-08 09:51:41.07463+00
27	8	Photography	2025-12-08 09:51:41.07463+00
28	8	Learning New Languages	2025-12-08 09:51:41.07463+00
\.


--
-- Data for Name: employee_languages; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_languages (id, employee_id, language, proficiency, created_at, updated_at) FROM stdin;
1	1	English	Native	2025-12-08 09:51:41.009484+00	\N
2	1	Spanish	Intermediate	2025-12-08 09:51:41.009484+00	\N
3	2	English	Fluent	2025-12-08 09:51:41.009484+00	\N
4	2	Mandarin	Native	2025-12-08 09:51:41.009484+00	\N
5	2	French	Beginner	2025-12-08 09:51:41.009484+00	\N
6	3	Spanish	Native	2025-12-08 09:51:41.009484+00	\N
7	3	English	Fluent	2025-12-08 09:51:41.009484+00	\N
8	3	Portuguese	Intermediate	2025-12-08 09:51:41.009484+00	\N
9	4	English	Fluent	2025-12-08 09:51:41.009484+00	\N
10	4	Hindi	Native	2025-12-08 09:51:41.009484+00	\N
11	4	German	Intermediate	2025-12-08 09:51:41.009484+00	\N
12	5	English	Native	2025-12-08 09:51:41.009484+00	\N
13	5	French	Advanced	2025-12-08 09:51:41.009484+00	\N
14	6	English	Native	2025-12-08 09:51:41.009484+00	\N
15	7	English	Native	2025-12-08 09:51:41.009484+00	\N
16	7	Spanish	Beginner	2025-12-08 09:51:41.009484+00	\N
17	8	Spanish	Native	2025-12-08 09:51:41.009484+00	\N
18	8	English	Fluent	2025-12-08 09:51:41.009484+00	\N
19	8	Italian	Intermediate	2025-12-08 09:51:41.009484+00	\N
\.


--
-- Data for Name: employee_personal_info; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_personal_info (id, employee_id, birth_date, gender, nationality, email, phone, website, linkedin_url, github_url, professional_title, professional_summary, created_at, updated_at) FROM stdin;
9	1	1990-05-12	Female	American	sarah.johnson@email.com	+1-555-0101	https://sarahjohnson.dev	https://linkedin.com/in/sarahjohnson	https://github.com/sarahjdev	Senior Software Engineer	Passionate software engineer with 8+ years of experience in building scalable web applications. Specialized in React, Node.js, and cloud architecture. Strong advocate for clean code and agile methodologies.	2025-12-08 09:51:40.902273+00	\N
10	2	1988-11-23	Male	Canadian	michael.chen@email.com	+1-555-0102	https://michaelchen.com	https://linkedin.com/in/michaelchen	\N	Product Manager	Results-driven product manager with a proven track record of launching successful B2B and B2C products. Expert in product strategy, roadmap planning, and cross-functional team leadership.	2025-12-08 09:51:40.902273+00	\N
11	3	1993-08-07	Female	Mexican	emily.rodriguez@email.com	+1-555-0103	https://emilydesigns.portfolio	https://linkedin.com/in/emilyrodriguez	\N	UX/UI Designer	Creative designer with a passion for creating intuitive and beautiful user experiences. Experienced in user research, wireframing, prototyping, and design systems.	2025-12-08 09:51:40.902273+00	\N
12	4	1991-02-18	Male	Indian	david.kumar@email.com	+1-555-0104	\N	https://linkedin.com/in/davidkumar	https://github.com/dkumar	Data Scientist	Data scientist specializing in machine learning and predictive analytics. Expert in Python, R, and statistical modeling. Published researcher with multiple papers in top-tier conferences.	2025-12-08 09:51:40.902273+00	\N
13	5	1989-12-30	Female	British	jennifer.williams@email.com	+1-555-0105	\N	https://linkedin.com/in/jenniferwilliams	https://github.com/jwilliams	DevOps Engineer	DevOps engineer with extensive experience in cloud infrastructure, CI/CD pipelines, and container orchestration. AWS and Kubernetes certified professional.	2025-12-08 09:51:40.902273+00	\N
14	6	1987-06-15	Male	American	robert.anderson@email.com	+1-555-0106	\N	https://linkedin.com/in/robertanderson	\N	Marketing Manager	Strategic marketing professional with 10+ years of experience in digital marketing, brand development, and campaign management.	2025-12-08 09:51:40.902273+00	\N
15	7	1985-04-22	Female	American	lisa.thompson@email.com	+1-555-0107	\N	https://linkedin.com/in/lisathompson	\N	HR Director	Experienced HR leader specializing in talent acquisition, employee engagement, and organizational development. SHRM-SCP certified.	2025-12-08 09:51:40.902273+00	\N
16	8	1994-09-11	Male	Spanish	james.martinez@email.com	+1-555-0108	https://jmartinez.dev	https://linkedin.com/in/jamesmartinez	https://github.com/jmartinez	Full Stack Developer	Full stack developer proficient in modern web technologies. Experienced in building responsive web applications from concept to deployment.	2025-12-08 09:51:40.902273+00	\N
\.


--
-- Data for Name: employee_projects; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_projects (id, employee_id, project_name, description, role, start_date, end_date, is_current, created_at, updated_at) FROM stdin;
1	1	E-commerce Platform Redesign	Led complete architectural redesign of e-commerce platform serving 5M+ users. Implemented microservices architecture with event-driven design.	Technical Lead	2022-01-15	2023-06-30	f	2025-12-08 09:51:41.023389+00	\N
2	1	Real-time Analytics Dashboard	Built real-time analytics dashboard processing millions of events per second using Kafka and Redis.	Senior Engineer	2021-03-01	2021-10-15	f	2025-12-08 09:51:41.023389+00	\N
3	1	Open Source Contribution - React Performance Tools	Contributing to open-source project for React performance monitoring and optimization.	Maintainer	2020-06-01	\N	t	2025-12-08 09:51:41.023389+00	\N
4	2	Mobile App Launch	Led product strategy and launch of mobile application, achieving 100K downloads in first month.	Product Lead	2021-09-01	2022-03-30	f	2025-12-08 09:51:41.023389+00	\N
5	2	B2B SaaS Platform	Managing product roadmap for enterprise SaaS platform with $10M ARR.	Product Manager	2022-04-01	\N	t	2025-12-08 09:51:41.023389+00	\N
6	3	Design System Implementation	Created comprehensive design system adopted across 15+ products, reducing design time by 40%.	Lead Designer	2021-06-01	2022-02-28	f	2025-12-08 09:51:41.023389+00	\N
7	3	Mobile App Redesign	Redesigned mobile application resulting in 35% increase in user engagement.	UX Designer	2022-03-01	2022-09-15	f	2025-12-08 09:51:41.023389+00	\N
8	4	Customer Churn Prediction Model	Developed ML model predicting customer churn with 92% accuracy, saving $5M annually.	Data Scientist	2021-11-01	2022-08-30	f	2025-12-08 09:51:41.023389+00	\N
9	4	Recommendation Engine	Building personalized recommendation system using collaborative filtering and deep learning.	ML Engineer	2023-01-15	\N	t	2025-12-08 09:51:41.023389+00	\N
10	5	Cloud Migration Project	Led migration of on-premise infrastructure to AWS, reducing costs by 35%.	DevOps Lead	2020-05-01	2021-03-30	f	2025-12-08 09:51:41.023389+00	\N
11	5	CI/CD Pipeline Automation	Implementing automated CI/CD pipelines across 50+ microservices.	DevOps Engineer	2021-04-01	\N	t	2025-12-08 09:51:41.023389+00	\N
12	8	Social Media Dashboard	Built full-stack social media analytics dashboard with real-time data visualization.	Full Stack Developer	2022-10-01	2023-04-15	f	2025-12-08 09:51:41.023389+00	\N
\.


--
-- Data for Name: employee_publications; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_publications (id, employee_id, title, publication_type, publisher, publication_date, url, description, created_at, updated_at) FROM stdin;
1	4	Transfer Learning Techniques for Computer Vision Applications	Conference Paper	International Conference on Machine Learning (ICML)	2021-07-15	https://proceedings.mlr.press/v139/kumar21a.html	Novel approach to transfer learning achieving state-of-the-art results on ImageNet	2025-12-08 09:51:41.047623+00	\N
2	4	Deep Learning for Natural Language Processing: A Comprehensive Survey	Journal Article	Journal of Artificial Intelligence Research	2020-03-20	https://jair.org/index.php/jair/article/view/12345	Comprehensive survey of deep learning methods in NLP	2025-12-08 09:51:41.047623+00	\N
3	4	Practical Machine Learning with Python	Book Chapter	OReilly Media	2022-11-10	https://oreilly.com/library/view/practical-ml/9781234567890	Contributing author for chapters on neural networks and optimization	2025-12-08 09:51:41.047623+00	\N
4	1	Microservices Architecture Best Practices	Blog Post	Medium Engineering Blog	2022-05-15	https://medium.com/engineering/microservices-best-practices	Article on designing scalable microservices	2025-12-08 09:51:41.047623+00	\N
5	2	Product Management in the Age of AI	Article	Product Coalition	2023-02-28	https://productcoalition.com/pm-ai-age	Insights on managing AI-powered products	2025-12-08 09:51:41.047623+00	\N
\.


--
-- Data for Name: employee_soft_skills; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_soft_skills (id, employee_id, skill_name, created_at) FROM stdin;
1	1	Leadership	2025-12-08 09:51:41.003856+00
2	1	Problem Solving	2025-12-08 09:51:41.003856+00
3	1	Communication	2025-12-08 09:51:41.003856+00
4	1	Team Collaboration	2025-12-08 09:51:41.003856+00
5	1	Mentoring	2025-12-08 09:51:41.003856+00
6	2	Strategic Thinking	2025-12-08 09:51:41.003856+00
7	2	Communication	2025-12-08 09:51:41.003856+00
8	2	Stakeholder Management	2025-12-08 09:51:41.003856+00
9	2	Decision Making	2025-12-08 09:51:41.003856+00
10	2	Leadership	2025-12-08 09:51:41.003856+00
11	3	Creativity	2025-12-08 09:51:41.003856+00
12	3	Empathy	2025-12-08 09:51:41.003856+00
13	3	Communication	2025-12-08 09:51:41.003856+00
14	3	Collaboration	2025-12-08 09:51:41.003856+00
15	3	Attention to Detail	2025-12-08 09:51:41.003856+00
16	4	Analytical Thinking	2025-12-08 09:51:41.003856+00
17	4	Problem Solving	2025-12-08 09:51:41.003856+00
18	4	Communication	2025-12-08 09:51:41.003856+00
19	4	Research	2025-12-08 09:51:41.003856+00
20	4	Presentation	2025-12-08 09:51:41.003856+00
21	5	Problem Solving	2025-12-08 09:51:41.003856+00
22	5	Communication	2025-12-08 09:51:41.003856+00
23	5	Automation Mindset	2025-12-08 09:51:41.003856+00
24	5	Troubleshooting	2025-12-08 09:51:41.003856+00
25	5	Team Collaboration	2025-12-08 09:51:41.003856+00
26	6	Creativity	2025-12-08 09:51:41.003856+00
27	6	Communication	2025-12-08 09:51:41.003856+00
28	6	Project Management	2025-12-08 09:51:41.003856+00
29	6	Strategic Planning	2025-12-08 09:51:41.003856+00
30	7	Leadership	2025-12-08 09:51:41.003856+00
31	7	Communication	2025-12-08 09:51:41.003856+00
32	7	Conflict Resolution	2025-12-08 09:51:41.003856+00
33	7	Empathy	2025-12-08 09:51:41.003856+00
34	7	Negotiation	2025-12-08 09:51:41.003856+00
35	8	Problem Solving	2025-12-08 09:51:41.003856+00
36	8	Communication	2025-12-08 09:51:41.003856+00
37	8	Adaptability	2025-12-08 09:51:41.003856+00
38	8	Team Collaboration	2025-12-08 09:51:41.003856+00
\.


--
-- Data for Name: employee_technical_skills; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_technical_skills (id, employee_id, skill_category_id, skill_name, proficiency_level, years_of_experience, created_at, updated_at) FROM stdin;
1	1	1	JavaScript	Expert	8.0	2025-12-08 09:51:40.974742+00	\N
2	1	1	TypeScript	Advanced	5.0	2025-12-08 09:51:40.974742+00	\N
3	1	1	Python	Advanced	6.0	2025-12-08 09:51:40.974742+00	\N
4	1	2	React	Expert	7.0	2025-12-08 09:51:40.974742+00	\N
5	1	2	Node.js	Expert	7.0	2025-12-08 09:51:40.974742+00	\N
6	1	2	Express.js	Advanced	6.0	2025-12-08 09:51:40.974742+00	\N
7	1	3	PostgreSQL	Advanced	6.0	2025-12-08 09:51:40.974742+00	\N
8	1	3	MongoDB	Advanced	5.0	2025-12-08 09:51:40.974742+00	\N
9	1	3	Redis	Intermediate	4.0	2025-12-08 09:51:40.974742+00	\N
10	1	4	Docker	Advanced	5.0	2025-12-08 09:51:40.974742+00	\N
11	1	4	Kubernetes	Advanced	4.0	2025-12-08 09:51:40.974742+00	\N
12	1	4	AWS	Advanced	5.0	2025-12-08 09:51:40.974742+00	\N
13	2	7	Product Roadmapping	Expert	6.0	2025-12-08 09:51:40.980441+00	\N
14	2	7	Agile/Scrum	Expert	8.0	2025-12-08 09:51:40.980441+00	\N
15	2	7	User Story Mapping	Advanced	6.0	2025-12-08 09:51:40.980441+00	\N
16	2	5	Jira	Expert	7.0	2025-12-08 09:51:40.980441+00	\N
17	2	5	Confluence	Advanced	7.0	2025-12-08 09:51:40.980441+00	\N
18	2	5	Figma	Intermediate	4.0	2025-12-08 09:51:40.980441+00	\N
19	2	5	Mixpanel	Advanced	5.0	2025-12-08 09:51:40.980441+00	\N
20	3	6	Figma	Expert	5.0	2025-12-08 09:51:40.9845+00	\N
21	3	6	Adobe XD	Advanced	4.0	2025-12-08 09:51:40.9845+00	\N
22	3	6	Sketch	Advanced	4.0	2025-12-08 09:51:40.9845+00	\N
23	3	6	Adobe Photoshop	Expert	7.0	2025-12-08 09:51:40.9845+00	\N
24	3	6	Adobe Illustrator	Advanced	6.0	2025-12-08 09:51:40.9845+00	\N
25	3	5	InVision	Advanced	4.0	2025-12-08 09:51:40.9845+00	\N
26	3	5	Miro	Intermediate	3.0	2025-12-08 09:51:40.9845+00	\N
27	4	1	Python	Expert	8.0	2025-12-08 09:51:40.989639+00	\N
28	4	1	R	Advanced	6.0	2025-12-08 09:51:40.989639+00	\N
29	4	1	SQL	Expert	7.0	2025-12-08 09:51:40.989639+00	\N
30	4	8	TensorFlow	Expert	5.0	2025-12-08 09:51:40.989639+00	\N
31	4	8	PyTorch	Expert	5.0	2025-12-08 09:51:40.989639+00	\N
32	4	8	Scikit-learn	Expert	6.0	2025-12-08 09:51:40.989639+00	\N
33	4	8	Keras	Advanced	4.0	2025-12-08 09:51:40.989639+00	\N
34	4	8	Pandas	Expert	7.0	2025-12-08 09:51:40.989639+00	\N
35	4	8	NumPy	Expert	7.0	2025-12-08 09:51:40.989639+00	\N
36	4	4	Apache Spark	Advanced	4.0	2025-12-08 09:51:40.989639+00	\N
37	4	4	AWS SageMaker	Advanced	3.0	2025-12-08 09:51:40.989639+00	\N
38	5	4	AWS	Expert	6.0	2025-12-08 09:51:40.993972+00	\N
39	5	4	Azure	Advanced	4.0	2025-12-08 09:51:40.993972+00	\N
40	5	4	Docker	Expert	6.0	2025-12-08 09:51:40.993972+00	\N
41	5	4	Kubernetes	Expert	5.0	2025-12-08 09:51:40.993972+00	\N
42	5	4	Terraform	Advanced	4.0	2025-12-08 09:51:40.993972+00	\N
43	5	4	Jenkins	Advanced	5.0	2025-12-08 09:51:40.993972+00	\N
44	5	4	GitLab CI	Advanced	4.0	2025-12-08 09:51:40.993972+00	\N
45	5	1	Python	Advanced	5.0	2025-12-08 09:51:40.993972+00	\N
46	5	1	Bash	Expert	7.0	2025-12-08 09:51:40.993972+00	\N
47	8	1	JavaScript	Advanced	5.0	2025-12-08 09:51:40.998139+00	\N
48	8	1	TypeScript	Advanced	3.0	2025-12-08 09:51:40.998139+00	\N
49	8	1	Python	Intermediate	3.0	2025-12-08 09:51:40.998139+00	\N
50	8	2	React	Advanced	4.0	2025-12-08 09:51:40.998139+00	\N
51	8	2	Vue.js	Advanced	3.0	2025-12-08 09:51:40.998139+00	\N
52	8	2	Node.js	Advanced	4.0	2025-12-08 09:51:40.998139+00	\N
53	8	3	PostgreSQL	Intermediate	3.0	2025-12-08 09:51:40.998139+00	\N
54	8	3	MySQL	Intermediate	4.0	2025-12-08 09:51:40.998139+00	\N
\.


--
-- Data for Name: employee_volunteering; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_volunteering (id, employee_id, role, organization, start_date, end_date, is_current, created_at, updated_at) FROM stdin;
1	1	Coding Mentor	Girls Who Code	2020-01-15	\N	t	2025-12-08 09:51:41.058025+00	\N
2	1	Technical Workshop Instructor	Code.org	2019-06-01	2020-12-31	f	2025-12-08 09:51:41.058025+00	\N
3	2	Product Mentor	Product School Pro Bono Program	2021-03-01	\N	t	2025-12-08 09:51:41.058025+00	\N
4	3	Design Mentor	AIGA Mentorship Program	2021-09-01	\N	t	2025-12-08 09:51:41.058025+00	\N
5	4	AI Ethics Committee Member	Partnership on AI	2022-01-15	\N	t	2025-12-08 09:51:41.058025+00	\N
6	4	STEM Educator	Local High School	2019-09-01	2021-06-30	f	2025-12-08 09:51:41.058025+00	\N
7	5	Tech Workshop Leader	Women in Technology	2020-05-01	\N	t	2025-12-08 09:51:41.058025+00	\N
8	7	Career Coach	Nonprofit Job Training Program	2018-03-01	\N	t	2025-12-08 09:51:41.058025+00	\N
9	8	Programming Tutor	Local Community Center	2022-01-10	\N	t	2025-12-08 09:51:41.058025+00	\N
\.


--
-- Data for Name: employee_work_experience; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employee_work_experience (id, employee_id, job_title, company, employment_type, country, city, start_date, end_date, is_current, description, created_at, updated_at) FROM stdin;
1	1	Senior Software Engineer	Current Company	Full-time	United States	San Francisco	2020-03-15	\N	t	Leading development of microservices architecture	2025-12-08 09:51:40.911148+00	\N
2	1	Software Engineer	TechCorp Inc	Full-time	United States	San Francisco	2017-06-01	2020-03-10	f	Developed and maintained web applications	2025-12-08 09:51:40.911148+00	\N
3	1	Junior Developer	StartupXYZ	Full-time	United States	San Jose	2015-08-15	2017-05-30	f	Built features for SaaS platform	2025-12-08 09:51:40.911148+00	\N
4	2	Product Manager	Current Company	Full-time	United States	Seattle	2019-07-01	\N	t	Managing product roadmap and strategy	2025-12-08 09:51:40.915395+00	\N
5	2	Associate Product Manager	BigTech Solutions	Full-time	United States	Seattle	2017-03-15	2019-06-30	f	Supported product development initiatives	2025-12-08 09:51:40.915395+00	\N
6	2	Business Analyst	Consulting Group	Full-time	Canada	Toronto	2015-01-10	2017-03-01	f	Analyzed business requirements	2025-12-08 09:51:40.915395+00	\N
7	3	UX/UI Designer	Current Company	Full-time	United States	Austin	2021-01-20	\N	t	Leading design for mobile and web products	2025-12-08 09:51:40.919235+00	\N
8	3	UI Designer	Design Studio	Full-time	United States	Austin	2019-04-01	2021-01-15	f	Created user interfaces for client projects	2025-12-08 09:51:40.919235+00	\N
9	3	Graphic Designer	Creative Agency	Contract	Mexico	Mexico City	2017-09-01	2019-03-30	f	Designed marketing materials and branding	2025-12-08 09:51:40.919235+00	\N
10	4	Data Scientist	Current Company	Full-time	United States	New York	2020-09-10	\N	t	Building ML models for predictive analytics	2025-12-08 09:51:40.922836+00	\N
11	4	Machine Learning Engineer	AI Innovations	Full-time	United States	Boston	2018-07-01	2020-09-01	f	Developed deep learning models	2025-12-08 09:51:40.922836+00	\N
12	4	Data Analyst	Analytics Corp	Full-time	India	Bangalore	2016-06-15	2018-06-30	f	Performed statistical analysis	2025-12-08 09:51:40.922836+00	\N
13	5	DevOps Engineer	Current Company	Full-time	United States	Boston	2018-11-05	\N	t	Managing cloud infrastructure and CI/CD	2025-12-08 09:51:40.926348+00	\N
14	5	Systems Administrator	Enterprise Tech	Full-time	United Kingdom	London	2016-03-20	2018-10-30	f	Maintained server infrastructure	2025-12-08 09:51:40.926348+00	\N
15	5	IT Support Specialist	Tech Services Ltd	Full-time	United Kingdom	Manchester	2014-05-10	2016-03-15	f	Provided technical support	2025-12-08 09:51:40.926348+00	\N
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.employees (id, first_name, last_name, title, department, hire_date, salary, is_active, created_at, updated_at) FROM stdin;
1	Sarah	Johnson	Senior Software Engineer	Engineering	2020-03-15 00:00:00	120000	t	2025-12-08 09:51:40.894385+00	\N
2	Michael	Chen	Product Manager	Product	2019-07-01 00:00:00	135000	t	2025-12-08 09:51:40.894385+00	\N
3	Emily	Rodriguez	UX/UI Designer	Design	2021-01-20 00:00:00	95000	t	2025-12-08 09:51:40.894385+00	\N
4	David	Kumar	Data Scientist	Data & Analytics	2020-09-10 00:00:00	125000	t	2025-12-08 09:51:40.894385+00	\N
5	Jennifer	Williams	DevOps Engineer	Infrastructure	2018-11-05 00:00:00	115000	t	2025-12-08 09:51:40.894385+00	\N
6	Robert	Anderson	Marketing Manager	Marketing	2022-02-14 00:00:00	98000	f	2025-12-08 09:51:40.894385+00	\N
7	Lisa	Thompson	HR Director	Human Resources	2017-05-22 00:00:00	110000	t	2025-12-08 09:51:40.894385+00	\N
8	James	Martinez	Full Stack Developer	Engineering	2021-08-30 00:00:00	105000	t	2025-12-08 09:51:40.894385+00	\N
\.


--
-- Data for Name: job_application_notes; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.job_application_notes (id, application_id, author_id, note, created_at) FROM stdin;
1	1	1	Initial screening passed. Candidate has strong communication skills and deep knowledge of React patterns.	2024-11-03 18:00:00+00
2	1	2	Technical interview scheduled for next Tuesday. Sent HackerRank link.	2024-11-04 16:30:00+00
3	2	1	Portfolio is impressive. Specifically the e-commerce project. Lets schedule a screen.	2024-11-04 17:00:00+00
4	5	1	Candidate is very senior but salary expectations are outside our current band. Good to keep in network for future Lead roles.	2024-11-07 21:00:00+00
5	6	3	Great experience with B2B SaaS. Culture fit seems perfect.	2024-11-12 18:00:00+00
6	24	1	Passed all technical rounds with flying colors. Offer letter sent.	2024-10-18 22:00:00+00
7	24	4	Offer accepted. Start date set for Nov 1st.	2024-10-20 16:00:00+00
8	21	3	Very strong on the digital marketing side. Slightly less experience with traditional print media, but that is not a dealbreaker.	2024-12-07 18:00:00+00
\.


--
-- Data for Name: job_applications; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.job_applications (id, job_posting_id, candidate_name, email, phone, resume_url, cover_letter, portfolio_url, linkedin_url, source, status, applied_at, updated_at, pipeline_stage, pipeline_stage_updated_at, ai_review_result, ai_review_score, exam_assigned, exam_platform_id, exam_completed_at, exam_score, ai_interview_scheduled_at, ai_interview_completed_at, ai_interview_type, documents_required, documents_submitted, proposal_sent_at, proposal_accepted, candidate_id) FROM stdin;
2	11	Maria Garcia	maria.garcia@email.com	+1-555-1002	https://storage.company.com/resumes/maria_garcia.pdf	I have been following your company for years and would love to contribute to your engineering team. My experience with React and Node.js aligns perfectly with your requirements...	https://mariagarcia.portfolio.com	https://linkedin.com/in/mariagarcia	Company Website	Shortlisted	2024-11-03 21:15:00+00	\N	ai_review	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3	11	John Davis	john.davis@email.com	+1-555-1003	https://storage.company.com/resumes/john_davis.pdf	As a passionate full stack developer with extensive experience in modern web technologies, I am confident I can make significant contributions to your team...	https://johndavis.dev	https://linkedin.com/in/johndavis	Indeed	New	2024-11-05 16:45:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	11	Sarah Kim	sarah.kim@email.com	+1-555-1004	https://storage.company.com/resumes/sarah_kim.pdf	I am writing to express my strong interest in the Senior Full Stack Developer role. My background in building microservices and cloud-native applications makes me an ideal candidate...	\N	https://linkedin.com/in/sarahkim	Referral	Shortlisted	2024-11-04 18:20:00+00	\N	ai_review	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	11	Michael Brown	michael.brown@email.com	+1-555-1005	https://storage.company.com/resumes/michael_brown.pdf	With over 8 years of experience in full stack development, I have successfully delivered numerous projects using React, Node.js, and AWS...	https://michaelbrown.codes	https://linkedin.com/in/michaelbrown	LinkedIn	Rejected	2024-11-06 23:30:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	2	Emily Wilson	emily.wilson@email.com	+1-555-2001	https://storage.company.com/resumes/emily_wilson.pdf	I am thrilled to apply for the Product Manager position. With 5 years of product management experience in B2B SaaS, I have successfully launched multiple products from concept to market...	https://emilywilson.pm	https://linkedin.com/in/emilywilson	LinkedIn	Interview	2024-11-11 16:00:00+00	\N	ai_interview	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	2	David Lee	david.lee@email.com	+1-555-2002	https://storage.company.com/resumes/david_lee.pdf	As a data-driven product manager with a strong technical background, I excel at translating user needs into successful products...	\N	https://linkedin.com/in/davidlee	Company Website	Shortlisted	2024-11-12 20:45:00+00	\N	ai_review	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	11	Alex Thompson	alex.thompson@email.com	+1-555-1001	https://storage.company.com/resumes/alex_thompson.pdf	I am excited to apply for the Senior Full Stack Developer position. With 7 years of experience in building scalable web applications, I believe I would be a great fit for your team...	https://alexthompson.dev	https://linkedin.com/in/alexthompson	LinkedIn	Interview	2024-11-02 17:30:00+00	\N	ai_interview	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8	2	Jennifer Martinez	jennifer.martinez@email.com	+1-555-2003	https://storage.company.com/resumes/jennifer_martinez.pdf	I bring 6 years of product management experience with a proven track record of increasing user engagement and revenue...	https://jennifermartinez.com	https://linkedin.com/in/jennifermartinez	Glassdoor	New	2024-11-13 17:30:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9	3	Sophia Anderson	sophia.anderson@email.com	+1-555-3001	https://storage.company.com/resumes/sophia_anderson.pdf	I am passionate about creating user-centered designs that solve real problems. My portfolio demonstrates my ability to balance aesthetics with usability...	https://sophiaanderson.design	https://linkedin.com/in/sophiaanderson	Behance	Shortlisted	2024-11-16 21:00:00+00	\N	ai_review	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
10	3	Daniel Taylor	daniel.taylor@email.com	+1-555-3002	https://storage.company.com/resumes/daniel_taylor.pdf	With 4 years of UX/UI design experience, I have worked on both web and mobile applications for various industries...	https://danieltaylor.portfolio.io	https://linkedin.com/in/danieltaylor	LinkedIn	New	2024-11-17 18:15:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
11	3	Rachel Green	rachel.green@email.com	+1-555-3003	https://storage.company.com/resumes/rachel_green.pdf	I am a creative designer with a strong foundation in user research and design thinking. I would love to bring my skills to your team...	https://rachelgreen.design	https://linkedin.com/in/rachelgreen	Company Website	Shortlisted	2024-11-18 16:30:00+00	\N	ai_review	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
12	3	Oliver White	oliver.white@email.com	+1-555-3004	https://storage.company.com/resumes/oliver_white.pdf	As a UX designer focused on accessibility and inclusive design, I create experiences that work for everyone...	https://oliverwhite.ux	https://linkedin.com/in/oliverwhite	Dribbble	Rejected	2024-11-15 22:45:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
13	4	James Wilson	james.wilson@email.com	+1-555-4001	https://storage.company.com/resumes/james_wilson.pdf	I have 6 years of experience in DevOps with a strong focus on AWS infrastructure and Kubernetes orchestration...	\N	https://linkedin.com/in/jameswilson	LinkedIn	Interview	2024-11-21 17:00:00+00	\N	ai_interview	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
14	4	Lisa Chen	lisa.chen@email.com	+1-555-4002	https://storage.company.com/resumes/lisa_chen.pdf	As a DevOps engineer passionate about automation and infrastructure as code, I have successfully reduced deployment times by 70%...	https://github.com/lisachen	https://linkedin.com/in/lisachen	Company Website	Shortlisted	2024-11-22 21:30:00+00	\N	ai_review	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
46	13	Furkan Ulutaş	furkanulutas054@gmail.com	+905399225570	/api/io/cv-application/files/20251220_182504_b7191482_furkan-ulutas-cv.pdf	\N	\N	https://www.linkedin.com/in/Furkan-Ulutas	Career Page	New	2025-12-20 18:26:15.977+00	2025-12-22 09:34:32.37542+00	ai_review	2025-12-22 09:34:45.39861+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["Bachelor's degree in Computer Science, Software Engineering, or a related technical field, or equivalent practical experience.", "3+ years of professional experience in software development, preferably in a fast-paced environment.", "Proficiency in at least one modern programming language such as Python, Java, Go, C#, or JavaScript/TypeScript."], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
45	13	ZEYNEPNUR GÜNGÖR	zeynepnurgungor@icloud.com	05333903683	/api/io/cv-application/files/20251220_182146_11de8be1_zeynep_gungor.pdf	\N	\N	https://linkedin.com/in/linkedin.com/in/zeynepgngr/	Career Page	New	2025-12-20 18:22:45.236377+00	2025-12-22 12:40:41.320955+00	ai_review	2025-12-22 12:40:53.89896+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["Bachelor's degree in Computer Science, Software Engineering, or a related technical field, or equivalent practical experience.", "3+ years of professional experience in software development, preferably in a fast-paced environment.", "Proficiency in at least one modern programming language such as Python, Java, Go, C#, or JavaScript/TypeScript."], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
40	3	Muhammet Şahin Yıldırım	muhammetsahinyildirim@gmail.com	+905067002739	/api/io/cv-application/files/20251219_104356_26a1538d_Muhammet_Sahin_Yildirim_CV_.pdf	\N	\N	https://www.linkedin.com/in/muhammetsahinyildirim	Career Page	New	2025-12-19 10:48:48.13743+00	2025-12-22 20:29:13.45543+00	ai_review	2025-12-22 20:29:24.636258+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["3+ years of product management experience", "Experience with B2B SaaS products preferred", "Strong analytical and problem-solving skills"], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
41	6	Muhammet Şahin Yıldırım	muhammetsahinyildirim@gmail.com	+905067002739	/api/io/cv-application/files/20251220_135305_1c9221af_Muhammet_Sahin_Yildirim_CV_.pdf	\N	\N	https://www.linkedin.com/in/muhammetsahinyildirim	Career Page	New	2025-12-20 13:53:50.969583+00	2025-12-22 20:31:10.803787+00	ai_review	2025-12-22 20:31:24.512733+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["3+ years of data science experience", "Strong proficiency in Python and SQL", "Experience with ML frameworks (TensorFlow, PyTorch, Scikit-learn)"], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
47	13	ELANUR DEMİR	elanurdemir100@gmail.com		/api/io/cv-application/files/20251222_101846_21d45c70_Cv.ElanurDemir.pdf	\N	\N	https://linkedin.com/in/in/elanurdemir	Career Page	New	2025-12-22 10:20:34.059344+00	2025-12-22 10:21:08.232055+00	ai_review	2025-12-22 10:21:19.414578+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["Bachelor's degree in Computer Science, Software Engineering, or a related technical field, or equivalent practical experience.", "3+ years of professional experience in software development, preferably in a fast-paced environment.", "Proficiency in at least one modern programming language such as Python, Java, Go, C#, or JavaScript/TypeScript."], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	EMP-1766398835588
15	5	Robert Johnson	robert.johnson@email.com	+1-555-5001	https://storage.company.com/resumes/robert_johnson.pdf	I am a data scientist with 5 years of experience building machine learning models for various business applications...	https://github.com/robertjohnson	https://linkedin.com/in/robertjohnson	LinkedIn	Shortlisted	2024-11-26 16:15:00+00	\N	ai_review	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
16	5	Amanda Zhang	amanda.zhang@email.com	+1-555-5002	https://storage.company.com/resumes/amanda_zhang.pdf	With a PhD in Statistics and 4 years of industry experience, I specialize in building predictive models and deriving actionable insights...	https://amandazhang.data	https://linkedin.com/in/amandazhang	Indeed	New	2024-11-27 20:00:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
17	5	Kevin Park	kevin.park@email.com	+1-555-5003	https://storage.company.com/resumes/kevin_park.pdf	I am excited about the opportunity to apply my machine learning expertise to solve complex business problems...	\N	https://linkedin.com/in/kevinpark	Company Website	New	2024-11-28 17:45:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
18	6	Emma Roberts	emma.roberts@email.com	+1-555-6001	https://storage.company.com/resumes/emma_roberts.pdf	I recently completed a coding bootcamp and have been building React applications. I am eager to learn and grow as a developer...	https://emmaroberts.dev	https://linkedin.com/in/emmaroberts	LinkedIn	Shortlisted	2024-12-02 16:30:00+00	\N	ai_review	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
19	6	Chris Miller	chris.miller@email.com	+1-555-6002	https://storage.company.com/resumes/chris_miller.pdf	As a self-taught developer with 1 year of experience, I have built several personal projects and contributed to open source...	https://github.com/chrismiller	https://linkedin.com/in/chrismiller	Company Website	New	2024-12-03 18:00:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
20	6	Jessica Brown	jessica.brown@email.com	+1-555-6003	https://storage.company.com/resumes/jessica_brown.pdf	I am a recent graduate with a strong foundation in web development and a passion for creating beautiful user interfaces...	https://jessicabrown.portfolio.com	https://linkedin.com/in/jessicabrown	University Career Fair	New	2024-12-04 21:15:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
21	7	Nicole Adams	nicole.adams@email.com	+1-555-7001	https://storage.company.com/resumes/nicole_adams.pdf	With 7 years of B2B marketing experience, I have successfully led campaigns that generated millions in revenue...	\N	https://linkedin.com/in/nicoleadams	LinkedIn	Interview	2024-12-06 17:00:00+00	\N	ai_interview	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
22	7	Brian Turner	brian.turner@email.com	+1-555-7002	https://storage.company.com/resumes/brian_turner.pdf	I am a strategic marketing professional with expertise in digital marketing, content strategy, and brand development...	https://brianturner.marketing	https://linkedin.com/in/brianturner	Company Website	Shortlisted	2024-12-07 20:30:00+00	\N	ai_review	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
23	8	Patricia Lewis	patricia.lewis@email.com	+1-555-8001	https://storage.company.com/resumes/patricia_lewis.pdf	I am an experienced HR professional with SHRM-SCP certification and 8 years of experience in talent management...	\N	https://linkedin.com/in/patricialewis	LinkedIn	New	2024-11-08 16:00:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
24	9	Thomas Wright	thomas.wright@email.com	+1-555-9001	https://storage.company.com/resumes/thomas_wright.pdf	I am a senior backend engineer with 8 years of Java development experience...	\N	https://linkedin.com/in/thomaswright	LinkedIn	Hired	2024-10-20 17:30:00+00	\N	proposal	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
25	9	Karen Hill	karen.hill@email.com	+1-555-9002	https://storage.company.com/resumes/karen_hill.pdf	With extensive experience in microservices architecture and Spring Boot, I would be a great addition...	\N	https://linkedin.com/in/karenhill	Indeed	Rejected	2024-10-25 21:00:00+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
32	2	Candidate		\N	/api/io/cv-application/files/20251216_203554_9760c453_furkan-ulutas-cv.pdf	\N	\N	\N	Career Page	New	2025-12-16 20:39:23.520938+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
33	2	Candidate		\N	/api/io/cv-application/files/20251217_065153_f3e3b997_furkan-ulutas-cv.pdf	\N	\N	\N	Career Page	New	2025-12-17 06:54:44.80454+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
34	2	Candidate		\N	/api/io/cv-application/files/20251217_065456_4b028333_MuhammedCihan_CV.pdf	\N	\N	\N	Career Page	New	2025-12-17 06:57:09.092845+00	\N	applied	2025-12-17 12:57:48.251805+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
35	2	Candidate		\N	/api/io/cv-application/files/20251219_092903_cedf0036_furkan-ulutas-cv.pdf	\N	\N	\N	Career Page	New	2025-12-19 09:32:10.91971+00	\N	applied	2025-12-19 09:32:10.91971+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
36	2	Furkan Ulutaş	furkanulutas054@gmail.com	+905399225570	/api/io/cv-application/files/20251219_093602_149d28ee_furkan-ulutas-cv.pdf	\N	\N	https://www.linkedin.com/in/Furkan-Ulutas	Career Page	New	2025-12-19 09:42:13.57285+00	\N	applied	2025-12-19 09:42:13.57285+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
43	6	Furkan Ulutaş	furkanulutas054@gmail.com	+905399225570	/api/io/cv-application/files/20251220_140630_2751ed3b_furkan-ulutas-cv.pdf	\N	\N	https://linkedin.com/in/Furkan-Ulutas	Career Page	New	2025-12-20 14:07:54.440681+00	\N	applied	2025-12-20 14:07:54.440681+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	2	ZEYNEPNUR GÜNGÖR	zeynepnurgungor@icloud.com	05333903683	/api/io/cv-application/files/20251220_173713_c8244145_zeynep_gungor.pdf	\N	\N	https://linkedin.com/in/linkedin.com/in/zeynepgngr/	Career Page	New	2025-12-20 17:38:20.964962+00	\N	applied	2025-12-20 17:38:20.964962+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
39	2	Furkan Ulutaş	furkanulutas054@gmail.com	+905399225570	/api/io/cv-application/files/20251219_102844_de0f0c2a_furkan-ulutas-cv.pdf	\N	\N	https://www.linkedin.com/in/furkan-ulutas	Career Page	New	2025-12-19 10:29:30.965003+00	2025-12-22 20:21:00.88563+00	ai_review	2025-12-22 20:21:14.492419+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["5+ years of experience in full stack development", "Strong proficiency in JavaScript, TypeScript, React, and Node.js", "Experience with PostgreSQL or other relational databases"], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
38	2	Muhammet Şahin Yıldırım	muhammetsahinyildirim@gmail.com	+905067002739	/api/io/cv-application/files/20251219_101549_75b23046_Muhammet_Sahin_Yildirim_CV_.pdf	\N	\N	https://www.linkedin.com/in/muhammetsahinyildirim	Career Page	New	2025-12-19 10:23:03.207696+00	2025-12-22 20:48:26.736898+00	ai_review	2025-12-22 20:48:37.614742+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["5+ years of experience in full stack development", "Strong proficiency in JavaScript, TypeScript, React, and Node.js", "Experience with PostgreSQL or other relational databases"], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
37	2	Muhammet Şahin Yıldırım	muhammetsahinyildirim@gmail.com	+905067002739	/api/io/cv-application/files/20251219_100008_3a614805_Muhammet_Sahin_Yildirim_CV_.pdf	\N	\N	https://www.linkedin.com/in/muhammetsahinyildirim	Career Page	New	2025-12-19 10:01:38.380336+00	2025-12-22 20:50:14.617722+00	ai_review	2025-12-22 20:50:26.372741+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["5+ years of experience in full stack development", "Strong proficiency in JavaScript, TypeScript, React, and Node.js", "Experience with PostgreSQL or other relational databases"], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
42	6	MUHAMMED CIHAN	muhammed.cihan@hotmail.com	+905350659595	/api/io/cv-application/files/20251220_135706_45b31748_MuhammedCihan_CV.pdf	\N	\N	https://linkedin.com/in/muhammedcihan	Career Page	New	2025-12-20 13:58:10.939267+00	2025-12-22 20:35:08.934157+00	ai_review	2025-12-22 20:35:20.152419+00	{"score": 5, "explanation": "Muhammed Cihan's CV is primarily focused on systems engineering and IT infrastructure support, demonstrating a significant mismatch with the requirements for a Data Scientist role. While he possesses some valuable foundational skills and soft skills, he lacks nearly all the core technical and experiential qualifications specific to data science.", "suitable": false, "strengths": ["Foundational Computer Engineering degree (in progress)", "Experience in system monitoring, issue resolution, and backend processes demonstrates problem-solving abilities (transferable, but not data science specific)", "Exposure to MS SQL and SQL Server certification indicates basic database interaction skills", "Leadership experience through founding a hackathon/ideathon team and chairing a club demonstrates initiative and team management", "Strong soft skills including cross-functional communication and problem-solving"], "concerns": ["Lack of any direct data science experience (current role is System Engineer Assistant, focused on IT operations)", "No proficiency demonstrated in Python, a core language for data science", "No experience with machine learning frameworks (TensorFlow, PyTorch, Scikit-learn)", "No explicit knowledge or application of statistical analysis and hypothesis testing", "No experience with big data tools like Spark or Hadoop", "Currently pursuing a Bachelor's degree; the job requires a Master's degree (or equivalent experience, which is also lacking)", "Limited exposure to complex data analysis or model building, as indicated by work experience"], "matched_requirements": [], "missing_requirements": ["3+ years of data science experience", "Strong proficiency in Python and SQL", "Experience with ML frameworks (TensorFlow, PyTorch, Scikit-learn)", "Knowledge of statistical analysis and hypothesis testing", "Experience with big data tools (Spark, Hadoop)", "Master's degree in Computer Science, Statistics, or related field"]}	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
51	14	MUHAMMED CIHAN	muhammed.cihan@hotmail.com	+905350659595	/api/io/cv-application/files/20251223_195810_65944f65_MuhammedCihan_CV.pdf	\N	\N	https://www.linkedin.com/in/muhammedcihan	Career Page	New	2025-12-23 19:58:54.496088+00	2025-12-23 20:02:09.54866+00	ai_review	2025-12-23 20:02:19.585148+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["Bachelor's degree in Computer Science, Information Technology, or a related technical field, or equivalent practical experience.", "3-5 years of progressive experience in network engineering, administration, or architecture roles within an enterprise environment.", "Proficiency with core networking protocols (TCP/IP, OSPF, BGP, EIGRP, MPLS, VLANs, VRFs) and network security principles."], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	EMP-1766519936675
50	14	Furkan Ulutaş	furkanulutas054@gmail.com	+905399225570	/api/io/cv-application/files/20251223_195226_f8b79a73_furkan-ulutas-cv.pdf	\N	\N	https://www.linkedin.com/in/furkan-ulutas	Career Page	New	2025-12-23 19:53:34.320934+00	2025-12-23 20:04:04.470383+00	ai_review	2025-12-23 20:04:14.423119+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["Bachelor's degree in Computer Science, Information Technology, or a related technical field, or equivalent practical experience.", "3-5 years of progressive experience in network engineering, administration, or architecture roles within an enterprise environment.", "Proficiency with core networking protocols (TCP/IP, OSPF, BGP, EIGRP, MPLS, VLANs, VRFs) and network security principles."], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	EMP-1766519616749
49	14	ELANUR DEMİR	elanurdemirr1000@gmail.com	+905476508013	/api/io/cv-application/files/20251223_194538_7360a9c5_Cv.ElanurDemir.pdf	\N	\N	https://linkedin.com/in/linkedin.com/in/elanurdemirr	Career Page	New	2025-12-23 19:46:40.157836+00	2025-12-23 20:10:34.18831+00	ai_review	2025-12-23 20:10:44.413121+00	{"score": 75, "explanation": "AI analysis completed", "suitable": true, "strengths": ["Experience matches requirements"], "concerns": [], "matched_requirements": ["Bachelor's degree in Computer Science, Information Technology, or a related technical field, or equivalent practical experience.", "3-5 years of progressive experience in network engineering, administration, or architecture roles within an enterprise environment.", "Proficiency with core networking protocols (TCP/IP, OSPF, BGP, EIGRP, MPLS, VLANs, VRFs) and network security principles."], "missing_requirements": []}	75	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	EMP-1766519202434
48	14	ELANUR DEMİR	elanurdemir100@gmail.com		/api/io/cv-application/files/20251222_205418_f7eef773_Cv.ElanurDemir.pdf	\N	\N	https://linkedin.com/in/in/elanurdemir	Career Page	New	2025-12-22 20:55:33.43082+00	\N	applied	2025-12-22 20:55:33.43082+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	EMP-1766436935343
52	14	MUHAMMED CIHAN	muhammed.cihan@hotmail.com	+905350659595	/api/io/cv-application/files/20251223_202601_6a708dcb_MuhammedCihan_CV.pdf	\N	\N	https://linkedin.com/in/muhammedcihan	Career Page	New	2025-12-23 20:26:15.551254+00	\N	applied	2025-12-23 20:26:15.551254+00	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	EMP-1766521577842
\.


--
-- Data for Name: job_posting_activities; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.job_posting_activities (id, job_posting_id, actor_id, action_type, details, created_at) FROM stdin;
63	11	1	CREATED	Job posting created in Draft status	2024-10-30 16:00:00+00
64	11	1	STATUS_CHANGE	Changed status from Draft to Active	2024-11-01 16:00:00+00
65	11	\N	NEW_APPLICATION	New application received from Alex Thompson	2024-11-02 17:30:00+00
66	11	\N	NEW_APPLICATION	New application received from Maria Garcia	2024-11-03 21:15:00+00
67	11	1	UPDATE	Updated salary range to match market rates	2024-11-05 17:00:00+00
68	8	4	CREATED	Job posting created	2024-11-05 16:00:00+00
69	8	4	STATUS_CHANGE	Changed status from Active to Paused	2024-11-20 16:00:00+00
70	9	1	CREATED	Job posting created	2024-10-15 15:00:00+00
71	9	1	STATUS_CHANGE	Changed status from Draft to Active	2024-10-15 15:30:00+00
72	9	\N	NEW_APPLICATION	New application received from Thomas Wright	2024-10-20 17:30:00+00
73	9	1	STATUS_CHANGE	Changed status from Active to Closed	2024-10-21 16:00:00+00
74	2	\N	NEW_APPLICATION	New application from Candidate	2025-12-16 20:39:23.551078+00
75	2	\N	NEW_APPLICATION	New application from Candidate	2025-12-17 06:54:44.818165+00
76	2	\N	NEW_APPLICATION	New application from Candidate	2025-12-17 06:57:09.098723+00
77	2	\N	NEW_APPLICATION	New application from Candidate	2025-12-19 09:32:10.934491+00
78	2	\N	NEW_APPLICATION	New application from Furkan Ulutaş	2025-12-19 09:42:13.578538+00
79	2	\N	NEW_APPLICATION	New application from Muhammet Şahin Yıldırım	2025-12-19 10:01:38.39038+00
80	2	\N	NEW_APPLICATION	New application from Muhammet Şahin Yıldırım	2025-12-19 10:23:03.218969+00
81	2	\N	NEW_APPLICATION	New application from Furkan Ulutaş	2025-12-19 10:29:30.982267+00
82	3	\N	NEW_APPLICATION	New application from Muhammet Şahin Yıldırım	2025-12-19 10:48:48.170417+00
83	6	\N	NEW_APPLICATION	New application from Muhammet Şahin Yıldırım	2025-12-20 13:53:50.986409+00
84	6	\N	NEW_APPLICATION	New application from MUHAMMED CIHAN	2025-12-20 13:58:10.944491+00
85	6	\N	NEW_APPLICATION	New application from Furkan Ulutaş	2025-12-20 14:07:54.44499+00
86	12	2	CREATE	Job posting created	2025-12-20 14:22:13.581059+00
87	11	2	UPDATE	Job posting updated: status	2025-12-20 14:29:53.986653+00
88	11	2	UPDATE	Job posting updated: status	2025-12-20 14:29:56.03911+00
89	11	2	UPDATE	Job posting updated: status	2025-12-20 14:29:58.679301+00
90	12	2	UPDATE	Job posting updated: title, department, location, work_type, status, description, responsibilities, requirements, benefits, salary_range_min, salary_range_max, salary_currency, expiration_date	2025-12-20 14:30:12.059226+00
91	12	2	UPDATE	Job posting updated: title, department, location, work_type, status, description, responsibilities, requirements, benefits, salary_range_min, salary_range_max, salary_currency, expiration_date	2025-12-20 14:30:26.239364+00
92	2	\N	NEW_APPLICATION	New application from ZEYNEPNUR GÜNGÖR	2025-12-20 17:38:20.982994+00
93	13	2	CREATE	Job posting created	2025-12-20 18:16:56.041198+00
94	13	\N	NEW_APPLICATION	New application from ZEYNEPNUR GÜNGÖR	2025-12-20 18:22:45.249313+00
95	13	\N	NEW_APPLICATION	New application from Furkan Ulutaş	2025-12-20 18:26:15.982481+00
96	14	2	CREATE	Job posting created	2025-12-20 18:29:09.220465+00
97	13	2	AI_REVIEW_TRIGGERED	AI review triggered for Furkan Ulutaş	2025-12-22 09:34:45.410232+00
98	13	\N	NEW_APPLICATION	New application from ELANUR DEMİR	2025-12-22 10:20:34.065975+00
99	13	2	AI_REVIEW_TRIGGERED	AI review triggered for ELANUR DEMİR	2025-12-22 10:21:19.428203+00
100	13	2	AI_REVIEW_TRIGGERED	AI review triggered for ZEYNEPNUR GÜNGÖR	2025-12-22 12:40:53.934313+00
101	2	2	AI_REVIEW_TRIGGERED	AI review triggered for Furkan Ulutaş	2025-12-22 20:21:14.504512+00
102	3	2	AI_REVIEW_TRIGGERED	AI review triggered for Muhammet Şahin Yıldırım	2025-12-22 20:29:24.650854+00
135	6	2	AI_REVIEW_TRIGGERED	AI review triggered for Muhammet Şahin Yıldırım	2025-12-22 20:31:24.536855+00
136	6	2	AI_REVIEW_TRIGGERED	AI review triggered for MUHAMMED CIHAN	2025-12-22 20:35:20.163078+00
137	2	2	AI_REVIEW_TRIGGERED	AI review triggered for Muhammet Şahin Yıldırım	2025-12-22 20:48:37.624921+00
138	2	2	AI_REVIEW_TRIGGERED	AI review triggered for Muhammet Şahin Yıldırım	2025-12-22 20:50:26.392133+00
139	14	\N	NEW_APPLICATION	New application from ELANUR DEMİR	2025-12-22 20:55:33.436735+00
140	14	\N	NEW_APPLICATION	New application from ELANUR DEMİR	2025-12-23 19:46:40.172961+00
141	14	\N	NEW_APPLICATION	New application from Furkan Ulutaş	2025-12-23 19:53:34.429282+00
142	14	\N	NEW_APPLICATION	New application from MUHAMMED CIHAN	2025-12-23 19:58:54.650165+00
143	14	2	AI_REVIEW_TRIGGERED	AI review triggered for MUHAMMED CIHAN	2025-12-23 20:02:19.603287+00
144	14	2	AI_REVIEW_TRIGGERED	AI review triggered for Furkan Ulutaş	2025-12-23 20:04:14.440503+00
145	14	2	AI_REVIEW_TRIGGERED	AI review triggered for ELANUR DEMİR	2025-12-23 20:10:44.432181+00
146	14	\N	NEW_APPLICATION	New application from MUHAMMED CIHAN	2025-12-23 20:26:15.679809+00
\.


--
-- Data for Name: job_posting_daily_stats; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.job_posting_daily_stats (id, job_posting_id, date, views_count, applications_count) FROM stdin;
187	11	2024-11-01	45	0
188	11	2024-11-02	120	1
189	11	2024-11-03	98	1
190	11	2024-11-04	156	1
191	11	2024-11-05	134	1
192	11	2024-11-06	89	1
193	11	2024-11-07	76	0
194	2	2024-11-10	55	0
195	2	2024-11-11	145	1
196	2	2024-11-12	132	1
197	2	2024-11-13	110	1
198	2	2024-11-14	95	0
199	4	2024-11-20	60	0
200	4	2024-11-21	180	1
201	4	2024-11-22	165	1
202	4	2024-11-23	90	0
203	2	2025-12-16	0	1
204	2	2025-12-17	0	2
205	2	2025-12-19	0	5
206	3	2025-12-19	0	1
207	6	2025-12-20	0	3
208	2	2025-12-20	0	1
209	13	2025-12-20	0	2
210	13	2025-12-22	0	1
211	14	2025-12-22	0	1
212	14	2025-12-23	0	4
\.


--
-- Data for Name: job_posting_notes; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.job_posting_notes (id, job_posting_id, author_id, note, created_at) FROM stdin;
29	11	4	Budget approved for up to $165k if the candidate is exceptional.	2024-10-25 17:00:00+00
30	11	1	Need to fill this role by end of Q4 to support the new dashboard project.	2024-11-01 21:00:00+00
31	8	4	Freezing this role temporarily due to Q4 budget adjustments. Will revisit in Jan 2025.	2024-11-20 16:00:00+00
32	10	2	Waiting for final requirements from the Product team before publishing.	2024-12-01 17:00:00+00
33	9	1	Position filled successfully. Onboarding started.	2024-10-21 16:00:00+00
\.


--
-- Data for Name: job_postings; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.job_postings (id, title, department, location, work_type, status, description, responsibilities, requirements, benefits, salary_range_min, salary_range_max, salary_currency, posting_date, expiration_date, created_by, created_at, updated_at) FROM stdin;
2	Senior Full Stack Developer	Engineering	San Francisco, CA	Hybrid	Active	We are looking for an experienced Full Stack Developer to join our growing engineering team. You will be responsible for developing and maintaining our web applications using modern technologies.	{"Design and develop scalable web applications","Write clean, maintainable code following best practices","Collaborate with product managers and designers","Participate in code reviews and technical discussions","Mentor junior developers","Optimize application performance and user experience"}	{"5+ years of experience in full stack development","Strong proficiency in JavaScript, TypeScript, React, and Node.js","Experience with PostgreSQL or other relational databases","Familiarity with cloud platforms (AWS, Azure, or GCP)","Strong problem-solving and communication skills","Bachelor's degree in Computer Science or related field"}	{"Competitive salary and equity","Comprehensive health, dental, and vision insurance","Flexible work arrangements","401(k) with company match","Professional development budget","Unlimited PTO","Gym membership reimbursement"}	120000	160000	USD	2024-11-01 16:00:00+00	2025-02-01 06:59:59+00	1	2025-12-11 09:17:29.594135+00	\N
3	Product Manager	Product	Remote	Remote	Active	Seeking a strategic Product Manager to drive product vision and execution. You will work closely with engineering, design, and stakeholders to deliver exceptional products.	{"Define product roadmap and strategy","Conduct user research and gather feedback","Write detailed product specifications and user stories","Prioritize features based on business impact","Collaborate with cross-functional teams","Analyze product metrics and make data-driven decisions"}	{"3+ years of product management experience","Experience with B2B SaaS products preferred","Strong analytical and problem-solving skills","Excellent communication and presentation skills","Experience with product management tools (Jira, Confluence)","Technical background is a plus"}	{"Competitive salary","Remote work flexibility","Health insurance","Stock options","Learning and development opportunities","Annual team retreats"}	110000	140000	USD	2024-11-10 15:00:00+00	2025-02-11 06:59:59+00	1	2025-12-11 09:17:29.594135+00	\N
4	UX/UI Designer	Design	Austin, TX	Hybrid	Active	We are looking for a creative UX/UI Designer to help us create intuitive and beautiful user experiences. You will work on web and mobile applications.	{"Create wireframes, prototypes, and high-fidelity designs","Conduct user research and usability testing","Develop and maintain design systems","Collaborate with product and engineering teams","Present design concepts to stakeholders","Stay updated with design trends and best practices"}	{"3+ years of UX/UI design experience","Proficiency in Figma, Sketch, or Adobe XD","Strong portfolio demonstrating design process","Understanding of user-centered design principles","Experience with responsive and mobile design","Bachelor's degree in Design or related field"}	{"Competitive salary","Health and wellness benefits","Flexible schedule","Professional development budget","Latest design tools and software","Creative and collaborative work environment"}	85000	110000	USD	2024-11-15 17:00:00+00	2025-02-16 06:59:59+00	2	2025-12-11 09:17:29.594135+00	\N
5	DevOps Engineer	Infrastructure	New York, NY	Onsite	Active	Join our infrastructure team as a DevOps Engineer. You will be responsible for building and maintaining our cloud infrastructure and CI/CD pipelines.	{"Design and implement CI/CD pipelines","Manage cloud infrastructure on AWS","Implement monitoring and alerting solutions","Automate deployment processes","Ensure system security and compliance","Troubleshoot production issues"}	{"4+ years of DevOps experience","Strong knowledge of AWS services","Experience with Docker and Kubernetes","Proficiency in Infrastructure as Code (Terraform)","Scripting skills (Python, Bash)","Experience with CI/CD tools (Jenkins, GitLab CI)"}	{"Competitive salary and bonuses","Comprehensive health benefits","401(k) matching","Transit benefits","Continuing education support","Modern office in downtown Manhattan"}	115000	145000	USD	2024-11-20 16:00:00+00	2025-02-21 06:59:59+00	1	2025-12-11 09:17:29.594135+00	\N
6	Data Scientist	Data & Analytics	Seattle, WA	Hybrid	Active	We are seeking a talented Data Scientist to join our analytics team. You will build machine learning models and derive insights from complex datasets.	{"Develop and deploy machine learning models","Analyze large datasets to identify trends and patterns","Create data visualizations and reports","Collaborate with product teams on data-driven features","Build and maintain data pipelines","Present findings to stakeholders"}	{"3+ years of data science experience","Strong proficiency in Python and SQL","Experience with ML frameworks (TensorFlow, PyTorch, Scikit-learn)","Knowledge of statistical analysis and hypothesis testing","Experience with big data tools (Spark, Hadoop)","Master's degree in Computer Science, Statistics, or related field"}	{"Competitive salary","Stock options","Comprehensive benefits package","Flexible work schedule","Learning stipend","Conference attendance opportunities"}	120000	155000	USD	2024-11-25 15:00:00+00	2025-02-26 06:59:59+00	2	2025-12-11 09:17:29.594135+00	\N
7	Junior Frontend Developer	Engineering	Remote	Remote	Active	Great opportunity for a junior developer to grow their skills. You will work on modern web applications using React and TypeScript.	{"Build responsive web interfaces with React","Implement designs from Figma mockups","Write clean, testable code","Participate in code reviews","Learn from senior developers","Contribute to team documentation"}	{"1-2 years of frontend development experience","Knowledge of HTML, CSS, and JavaScript","Familiarity with React","Understanding of RESTful APIs","Git version control experience","Bachelor's degree or coding bootcamp certificate"}	{"Competitive entry-level salary","Remote work","Mentorship program","Health insurance","Learning resources and courses","Career growth opportunities"}	70000	90000	USD	2024-12-01 16:00:00+00	2025-03-02 06:59:59+00	1	2025-12-11 09:17:29.594135+00	\N
8	Marketing Manager	Marketing	Los Angeles, CA	Hybrid	Active	We are looking for a strategic Marketing Manager to lead our marketing initiatives and drive brand awareness.	{"Develop and execute marketing strategies","Manage digital marketing campaigns","Analyze campaign performance and ROI","Collaborate with sales and product teams","Manage marketing budget","Lead a team of marketing specialists"}	{"5+ years of marketing experience","Proven track record in B2B marketing","Strong analytical skills","Experience with marketing automation tools","Excellent written and verbal communication","MBA preferred but not required"}	{"Competitive salary and bonus","Health and wellness benefits","Flexible work arrangement","Professional development","Team building events","Stock options"}	95000	125000	USD	2024-12-05 17:00:00+00	2025-03-06 06:59:59+00	3	2025-12-11 09:17:29.594135+00	\N
9	HR Business Partner	Human Resources	Boston, MA	Hybrid	Paused	Seeking an experienced HR Business Partner to support our growing organization. You will partner with leadership on talent management and organizational development.	{"Partner with business leaders on HR strategy","Manage employee relations and conflict resolution","Lead talent acquisition and onboarding","Develop and implement HR policies","Conduct performance management processes","Drive employee engagement initiatives"}	{"5+ years of HR experience","SHRM-CP or PHR certification preferred","Strong knowledge of employment law","Excellent interpersonal skills","Experience with HRIS systems","Bachelor's degree in HR or related field"}	{"Competitive salary","Comprehensive benefits","Professional development","401(k) with match","Flexible schedule","Collaborative team environment"}	90000	115000	USD	2024-11-05 16:00:00+00	2025-02-06 06:59:59+00	4	2025-12-11 09:17:29.594135+00	\N
10	Senior Backend Engineer - Java	Engineering	Chicago, IL	Onsite	Closed	We were looking for a Senior Backend Engineer with strong Java expertise. Position has been filled.	{"Design and develop microservices","Optimize database queries","Implement security best practices","Mentor junior engineers","Participate in architecture decisions"}	{"6+ years Java development experience","Experience with Spring Boot","Knowledge of microservices architecture","Strong database skills (PostgreSQL, MongoDB)","Cloud experience (AWS or Azure)"}	{"Competitive salary","Health benefits","401(k) matching","Bonus potential"}	130000	165000	USD	2024-10-15 15:00:00+00	2024-12-16 06:59:59+00	1	2025-12-11 09:17:29.594135+00	\N
11	Mobile Developer (iOS/Android)	Engineering	Denver, CO	Hybrid	Paused	We are preparing to hire a Mobile Developer to build our native mobile applications for iOS and Android platforms.	{"Develop native mobile applications","Implement mobile UI/UX designs","Integrate with backend APIs","Optimize app performance","Participate in app store releases","Maintain existing mobile applications"}	{"3+ years of mobile development experience","Proficiency in Swift and Kotlin","Experience with React Native is a plus","Understanding of mobile design patterns","Knowledge of RESTful APIs","Published apps in App Store and Google Play"}	{"Competitive salary","Health insurance","Flexible work schedule","Latest mobile devices for testing","Professional development","Stock options"}	100000	130000	USD	\N	\N	2	2025-12-11 09:17:29.594135+00	2025-12-20 14:29:58.670529+00
12	Test İlan	Engineering	istanbul	Onsite	Active	Lorem Impsum	{" SQL"}	{" AABBBB"," aaaaa"," 1111111"}	{" cCCCCC"}	78000	120000	TRY	2025-12-20 14:22:13.56262+00	2025-12-27 00:00:00+00	2	2025-12-20 14:22:13.56262+00	2025-12-20 14:30:26.230373+00
13	Software Engineer Test	Engineering Department	Türkiye, İstanbul	Onsite	Active	Join our dynamic Engineering team as a Software Engineer and contribute to building innovative solutions that drive our core business forward. We are seeking a passionate and skilled engineer who thrives in a collaborative environment and is eager to tackle complex challenges, design scalable systems, and deliver high-quality code. You will play a crucial role in the full software development lifecycle, from conception to deployment, working with cutting-edge technologies and making a tangible impact on our products and users.	{"Design, develop, test, deploy, and maintain robust and scalable software solutions.","Collaborate closely with product managers, designers, and other engineers to define, scope, and implement new features and functionalities.","Participate in code reviews, providing constructive feedback and ensuring adherence to coding standards and best practices.","Troubleshoot, debug, and upgrade existing systems to improve performance, reliability, and security.","Contribute to architectural discussions and decisions, helping to shape the future direction of our technical stack.","Write comprehensive technical documentation, including design specifications and API documentation.","Stay current with emerging technologies and industry trends, applying new knowledge to projects as appropriate."}	{"Bachelor's degree in Computer Science, Software Engineering, or a related technical field, or equivalent practical experience.","3+ years of professional experience in software development, preferably in a fast-paced environment.","Proficiency in at least one modern programming language such as Python, Java, Go, C#, or JavaScript/TypeScript.","Strong understanding of data structures, algorithms, and object-oriented design principles.","Experience with relational and/or NoSQL databases (e.g., PostgreSQL, MongoDB, Redis).","Familiarity with cloud platforms (e.g., AWS, Azure, GCP) and containerization technologies (e.g., Docker, Kubernetes).","Excellent problem-solving skills, with an ability to translate complex requirements into elegant technical solutions."}	{"Comprehensive health, dental, and vision insurance plans for you and your family.","Generous paid time off (PTO) policy, including vacation, sick leave, and company holidays.","401(k) retirement plan with competitive company matching contributions.","Opportunities for professional development, including tuition reimbursement, conferences, and training programs.","Flexible work arrangements (where applicable for onsite roles) and a commitment to work-life balance.","Onsite perks including catered meals, well-stocked kitchens, and a state-of-the-art fitness center.","Equity options or stock grants for all eligible employees, fostering a shared sense of ownership."}	20000	25000	USD	2025-12-20 18:16:56.012425+00	2025-12-26 00:00:00+00	2	2025-12-20 18:16:56.012425+00	\N
14	Network Engineer	Information Technology - Infrastructure	Türkiye, İstanbul	Onsite	Active	Join our dynamic Infrastructure team as a Network Engineer! We are seeking a highly skilled and motivated professional to design, implement, and maintain our robust network infrastructure. This critical role ensures the stability, security, and efficiency of our network operations, directly supporting our business objectives and growth. If you're passionate about networking and thrive in an onsite, collaborative environment, we encourage you to apply and help us build the future of our network.	{"Design, implement, and maintain complex network solutions (LAN/WAN, VPN, Wireless, SD-WAN) to meet evolving business requirements.","Configure, troubleshoot, and optimize network hardware including routers, switches, firewalls, and load balancers (e.g., Cisco, Juniper, Palo Alto).","Monitor network performance, identify issues, and implement proactive measures to ensure optimal uptime, reliability, and security of network services.","Develop and maintain comprehensive network documentation, including diagrams, configurations, change logs, and standard operating procedures.","Implement and enforce network security policies, access controls, and best practices to protect organizational data and assets.","Collaborate with other IT teams and departments to support various projects, integrate new technologies, and resolve escalated technical issues.","Participate in an on-call rotation for critical network support outside of business hours as needed, ensuring 24/7 network availability."}	{"Bachelor's degree in Computer Science, Information Technology, or a related technical field, or equivalent practical experience.","3-5 years of progressive experience in network engineering, administration, or architecture roles within an enterprise environment.","Proficiency with core networking protocols (TCP/IP, OSPF, BGP, EIGRP, MPLS, VLANs, VRFs) and network security principles.","Hands-on experience with major vendor network equipment, including Cisco IOS/NX-OS, Juniper Junos, and Palo Alto Networks firewalls.","Strong analytical and problem-solving skills, with the ability to diagnose and resolve complex network issues efficiently under pressure.","Excellent communication and interpersonal skills, capable of explaining technical concepts clearly to both technical and non-technical stakeholders.","Relevant industry certifications such as CCNA, CCNP, JNCIS-ENT, or PCNSE are highly desirable."}	{"Comprehensive Medical, Dental, and Vision insurance plans with competitive employee contributions.","Generous Paid Time Off (PTO) policy, including vacation, sick leave, and company-paid holidays.","401(k) retirement plan with robust company matching program.","Opportunities for professional development, including training, conferences, and certification reimbursement.","Life and disability insurance, along with an employee assistance program for mental wellness.","A dynamic, collaborative, and inclusive work environment focused on innovation and continuous improvement.","Onsite amenities including a modern office space, complimentary snacks, and organized team-building events."}	50000	60000	TRY	2025-12-20 18:29:09.173493+00	2025-12-29 00:00:00+00	2	2025-12-20 18:29:09.173493+00	\N
\.


--
-- Data for Name: project_achievements; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.project_achievements (id, project_id, achievement, display_order) FROM stdin;
1	1	Reduced page load time by 60% through optimization	1
2	1	Achieved 99.99% uptime during migration	2
3	1	Mentored 3 junior engineers throughout the project	3
4	2	Processed over 100 million events per day	1
5	2	Reduced data latency from minutes to milliseconds	2
6	4	Reached 100K downloads within first month of launch	1
7	4	Achieved 4.7-star rating on app stores	2
8	6	Reduced design-to-development handoff time by 50%	1
9	6	Adopted by 15 product teams across the organization	2
10	8	Achieved 92% prediction accuracy	1
11	8	Model deployed to production serving 1M+ predictions daily	2
12	10	Completed migration 2 weeks ahead of schedule	1
13	10	Reduced infrastructure costs by 35%	2
\.


--
-- Data for Name: project_links; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.project_links (id, project_id, link_url, link_type) FROM stdin;
1	3	https://github.com/sarahjdev/react-perf-tools	github
2	3	https://react-perf-tools.dev	demo
3	3	https://docs.react-perf-tools.dev	documentation
4	12	https://github.com/jmartinez/social-dashboard	github
5	12	https://social-dashboard-demo.herokuapp.com	demo
\.


--
-- Data for Name: project_technologies; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.project_technologies (id, project_id, technology) FROM stdin;
1	1	Node.js
2	1	React
3	1	PostgreSQL
4	1	Redis
5	1	Docker
6	1	Kubernetes
7	1	AWS
8	2	Apache Kafka
9	2	Redis
10	2	React
11	2	D3.js
12	2	Node.js
13	3	React
14	3	TypeScript
15	3	Storybook
16	3	Jest
17	4	React Native
18	4	Firebase
19	4	Redux
20	4	TypeScript
21	5	Node.js
22	5	PostgreSQL
23	5	AWS
24	5	Stripe API
25	6	Figma
26	6	Storybook
27	6	React
28	6	CSS-in-JS
29	7	Figma
30	7	Sketch
31	7	InVision
32	7	Maze
33	8	Python
34	8	TensorFlow
35	8	XGBoost
36	8	Pandas
37	8	AWS SageMaker
38	9	Python
39	9	PyTorch
40	9	Apache Spark
41	9	Redis
42	10	AWS
43	10	Terraform
44	10	Docker
45	10	Kubernetes
46	10	Jenkins
47	11	GitLab CI
48	11	Docker
49	11	Kubernetes
50	11	Helm
51	11	ArgoCD
52	12	React
53	12	Node.js
54	12	Express
55	12	MongoDB
56	12	Chart.js
\.


--
-- Data for Name: skill_categories; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.skill_categories (id, category_name, description, created_at) FROM stdin;
1	Programming Languages	\N	2025-12-08 09:49:12.18256+00
2	Frameworks & Libraries	\N	2025-12-08 09:49:12.18256+00
3	Databases	\N	2025-12-08 09:49:12.18256+00
4	DevOps & Cloud	\N	2025-12-08 09:49:12.18256+00
5	Tools & Software	\N	2025-12-08 09:49:12.18256+00
6	Design	\N	2025-12-08 09:49:12.18256+00
7	Project Management	\N	2025-12-08 09:49:12.18256+00
8	Data Science & ML	\N	2025-12-08 09:49:12.18256+00
9	Mobile Development	\N	2025-12-08 09:49:12.18256+00
10	Testing	\N	2025-12-08 09:49:12.18256+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users (id, email, hashed_password, full_name, is_active, role, created_at, updated_at) FROM stdin;
1	abc@123.com	$2b$12$oeNQaOJrG4NrRY.ewo5RO.KA.yoU8gyLUCaPTFzZxZGcWaOzrSAz2	Furkan Ulutas	t	ADMIN	2025-12-08 11:33:28.66727+00	\N
2	user@example.com	$2b$12$Z0t.M/taTt52/b408g9ioOUoTABgvnlLfqq/pMhdjTaSGZ.gXrm1O	string	t	ADMIN	2025-12-08 15:47:23.031083+00	\N
3	user2@example.com	$2b$12$Z0t.M/taTt52/b408g9ioOUoTABgvnlLfqq/pMhdjTaSGZ.gXrm1O	string	t	ADMIN	2025-12-08 15:47:23.031083+00	\N
4	user3@example.com	$2b$12$Z0t.M/taTt52/b408g9ioOUoTABgvnlLfqq/pMhdjTaSGZ.gXrm1O	string	t	ADMIN	2025-12-08 15:47:23.031083+00	\N
5	user4@example.com	$2b$12$Z0t.M/taTt52/b408g9ioOUoTABgvnlLfqq/pMhdjTaSGZ.gXrm1O	string	t	ADMIN	2025-12-08 15:47:23.031083+00	\N
6	user5@example.com	$2b$12$Z0t.M/taTt52/b408g9ioOUoTABgvnlLfqq/pMhdjTaSGZ.gXrm1O	string	t	ADMIN	2025-12-08 15:47:23.031083+00	\N
7	use6@example.com	$2b$12$Z0t.M/taTt52/b408g9ioOUoTABgvnlLfqq/pMhdjTaSGZ.gXrm1O	string	t	ADMIN	2025-12-08 15:47:23.031083+00	\N
\.


--
-- Data for Name: volunteering_responsibilities; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.volunteering_responsibilities (id, volunteering_id, responsibility, display_order) FROM stdin;
1	1	Mentor high school students learning programming fundamentals	1
2	1	Conduct weekly coding workshops covering web development	2
3	1	Review student projects and provide constructive feedback	3
4	2	Teach HTML, CSS, and JavaScript to beginners	1
5	2	Organize coding challenges and hackathons	2
6	3	Guide aspiring product managers in career development	1
7	3	Conduct mock interviews and provide feedback	2
8	4	Mentor junior designers in UX best practices	1
9	4	Review portfolio projects and provide career guidance	2
10	5	Participate in discussions on ethical AI development	1
11	5	Review AI policy recommendations	2
12	7	Lead workshops on DevOps and cloud technologies	1
13	7	Provide mentorship to women entering tech field	2
14	8	Coach job seekers on resume writing and interview skills	1
15	8	Connect candidates with job opportunities	2
\.


--
-- Data for Name: work_experience_achievements; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.work_experience_achievements (id, work_experience_id, achievement, display_order) FROM stdin;
1	1	Reduced system latency by 45% through architecture optimization	1
2	1	Received "Engineer of the Year" award in 2022	2
3	1	Successfully migrated legacy monolith to microservices with zero downtime	3
4	2	Implemented caching strategy that improved page load times by 50%	1
5	2	Contributed to open-source projects with 1000+ GitHub stars	2
6	4	Led launch of flagship feature that generated $2M in ARR	1
7	4	Increased product adoption by 40% through improved onboarding flow	2
8	10	Developed churn prediction model with 92% accuracy	1
9	10	Published research paper at ICML conference	2
\.


--
-- Data for Name: work_experience_responsibilities; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.work_experience_responsibilities (id, work_experience_id, responsibility, display_order) FROM stdin;
1	1	Lead a team of 5 engineers in designing and implementing microservices architecture	1
2	1	Architect scalable solutions handling 10M+ daily active users	2
3	1	Conduct code reviews and mentor junior developers	3
4	1	Collaborate with product managers to define technical requirements	4
5	1	Implement CI/CD pipelines reducing deployment time by 60%	5
6	2	Developed RESTful APIs using Node.js and Express	1
7	2	Built responsive front-end applications with React and Redux	2
8	2	Optimized database queries improving performance by 40%	3
9	2	Participated in agile ceremonies and sprint planning	4
10	4	Define product vision and roadmap for enterprise SaaS platform	1
11	4	Conduct user research and gather customer feedback	2
12	4	Prioritize feature development based on business impact	3
13	4	Work closely with engineering, design, and sales teams	4
14	4	Launch 3 major features resulting in 25% increase in user engagement	5
15	10	Design and deploy machine learning models for customer churn prediction	1
16	10	Build data pipelines processing 100GB+ daily data	2
17	10	Collaborate with business stakeholders to identify analytics opportunities	3
18	10	Present insights and recommendations to executive leadership	4
\.


--
-- Data for Name: work_experience_technologies; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.work_experience_technologies (id, work_experience_id, technology) FROM stdin;
1	1	JavaScript
2	1	TypeScript
3	1	React
4	1	Node.js
5	1	PostgreSQL
6	1	MongoDB
7	1	Docker
8	1	Kubernetes
9	1	AWS
10	1	Redis
11	2	JavaScript
12	2	React
13	2	Redux
14	2	Node.js
15	2	Express
16	2	MySQL
17	2	Git
18	2	Jest
19	3	HTML
20	3	CSS
21	3	JavaScript
22	3	jQuery
23	3	Bootstrap
24	4	Jira
25	4	Confluence
26	4	Mixpanel
27	4	Google Analytics
28	4	Figma
29	10	Python
30	10	TensorFlow
31	10	PyTorch
32	10	Scikit-learn
33	10	Pandas
34	10	NumPy
35	10	SQL
36	10	Apache Spark
37	10	AWS SageMaker
38	10	Jupyter
\.


--
-- Name: candidate_additional_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_additional_info_id_seq', 15, true);


--
-- Name: candidate_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_addresses_id_seq', 26, true);


--
-- Name: candidate_awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_awards_id_seq', 4, true);


--
-- Name: candidate_certifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_certifications_id_seq', 45, true);


--
-- Name: candidate_education_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_education_courses_id_seq', 11, true);


--
-- Name: candidate_education_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_education_id_seq', 20, true);


--
-- Name: candidate_hobbies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_hobbies_id_seq', 10, true);


--
-- Name: candidate_languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_languages_id_seq', 20, true);


--
-- Name: candidate_personal_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_personal_info_id_seq', 15, true);


--
-- Name: candidate_project_achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_project_achievements_id_seq', 8, true);


--
-- Name: candidate_project_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_project_links_id_seq', 1, false);


--
-- Name: candidate_project_technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_project_technologies_id_seq', 48, true);


--
-- Name: candidate_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_projects_id_seq', 20, true);


--
-- Name: candidate_publications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_publications_id_seq', 1, false);


--
-- Name: candidate_raw_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_raw_data_id_seq', 15, true);


--
-- Name: candidate_soft_skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_soft_skills_id_seq', 62, true);


--
-- Name: candidate_technical_skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_technical_skills_id_seq', 208, true);


--
-- Name: candidate_volunteering_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_volunteering_id_seq', 24, true);


--
-- Name: candidate_volunteering_responsibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_volunteering_responsibilities_id_seq', 44, true);


--
-- Name: candidate_work_experience_achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_work_experience_achievements_id_seq', 2, true);


--
-- Name: candidate_work_experience_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_work_experience_id_seq', 29, true);


--
-- Name: candidate_work_experience_responsibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_work_experience_responsibilities_id_seq', 118, true);


--
-- Name: candidate_work_experience_technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidate_work_experience_technologies_id_seq', 89, true);


--
-- Name: candidates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.candidates_id_seq', 14, true);


--
-- Name: education_courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.education_courses_id_seq', 17, true);


--
-- Name: employee_additional_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_additional_info_id_seq', 8, true);


--
-- Name: employee_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_addresses_id_seq', 16, true);


--
-- Name: employee_awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_awards_id_seq', 8, true);


--
-- Name: employee_certifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_certifications_id_seq', 10, true);


--
-- Name: employee_education_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_education_id_seq', 14, true);


--
-- Name: employee_hobbies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_hobbies_id_seq', 28, true);


--
-- Name: employee_languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_languages_id_seq', 19, true);


--
-- Name: employee_personal_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_personal_info_id_seq', 16, true);


--
-- Name: employee_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_projects_id_seq', 12, true);


--
-- Name: employee_publications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_publications_id_seq', 5, true);


--
-- Name: employee_soft_skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_soft_skills_id_seq', 38, true);


--
-- Name: employee_technical_skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_technical_skills_id_seq', 54, true);


--
-- Name: employee_volunteering_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_volunteering_id_seq', 9, true);


--
-- Name: employee_work_experience_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employee_work_experience_id_seq', 15, true);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.employees_id_seq', 8, true);


--
-- Name: job_application_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.job_application_notes_id_seq', 44, true);


--
-- Name: job_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.job_applications_id_seq', 52, true);


--
-- Name: job_posting_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.job_posting_activities_id_seq', 146, true);


--
-- Name: job_posting_daily_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.job_posting_daily_stats_id_seq', 212, true);


--
-- Name: job_posting_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.job_posting_notes_id_seq', 33, true);


--
-- Name: job_postings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.job_postings_id_seq', 14, true);


--
-- Name: project_achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.project_achievements_id_seq', 13, true);


--
-- Name: project_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.project_links_id_seq', 5, true);


--
-- Name: project_technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.project_technologies_id_seq', 56, true);


--
-- Name: skill_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.skill_categories_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: volunteering_responsibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.volunteering_responsibilities_id_seq', 15, true);


--
-- Name: work_experience_achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.work_experience_achievements_id_seq', 9, true);


--
-- Name: work_experience_responsibilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.work_experience_responsibilities_id_seq', 18, true);


--
-- Name: work_experience_technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.work_experience_technologies_id_seq', 38, true);


--
-- Name: candidate_additional_info candidate_additional_info_candidate_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_additional_info
    ADD CONSTRAINT candidate_additional_info_candidate_id_key UNIQUE (candidate_id);


--
-- Name: candidate_additional_info candidate_additional_info_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_additional_info
    ADD CONSTRAINT candidate_additional_info_pkey PRIMARY KEY (id);


--
-- Name: candidate_addresses candidate_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_addresses
    ADD CONSTRAINT candidate_addresses_pkey PRIMARY KEY (id);


--
-- Name: candidate_awards candidate_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_awards
    ADD CONSTRAINT candidate_awards_pkey PRIMARY KEY (id);


--
-- Name: candidate_certifications candidate_certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_certifications
    ADD CONSTRAINT candidate_certifications_pkey PRIMARY KEY (id);


--
-- Name: candidate_education_courses candidate_education_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_education_courses
    ADD CONSTRAINT candidate_education_courses_pkey PRIMARY KEY (id);


--
-- Name: candidate_education candidate_education_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_education
    ADD CONSTRAINT candidate_education_pkey PRIMARY KEY (id);


--
-- Name: candidate_hobbies candidate_hobbies_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_hobbies
    ADD CONSTRAINT candidate_hobbies_pkey PRIMARY KEY (id);


--
-- Name: candidate_languages candidate_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_languages
    ADD CONSTRAINT candidate_languages_pkey PRIMARY KEY (id);


--
-- Name: candidate_personal_info candidate_personal_info_candidate_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_personal_info
    ADD CONSTRAINT candidate_personal_info_candidate_id_key UNIQUE (candidate_id);


--
-- Name: candidate_personal_info candidate_personal_info_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_personal_info
    ADD CONSTRAINT candidate_personal_info_pkey PRIMARY KEY (id);


--
-- Name: candidate_project_achievements candidate_project_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_project_achievements
    ADD CONSTRAINT candidate_project_achievements_pkey PRIMARY KEY (id);


--
-- Name: candidate_project_links candidate_project_links_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_project_links
    ADD CONSTRAINT candidate_project_links_pkey PRIMARY KEY (id);


--
-- Name: candidate_project_technologies candidate_project_technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_project_technologies
    ADD CONSTRAINT candidate_project_technologies_pkey PRIMARY KEY (id);


--
-- Name: candidate_projects candidate_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_projects
    ADD CONSTRAINT candidate_projects_pkey PRIMARY KEY (id);


--
-- Name: candidate_publications candidate_publications_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_publications
    ADD CONSTRAINT candidate_publications_pkey PRIMARY KEY (id);


--
-- Name: candidate_raw_data candidate_raw_data_candidate_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_raw_data
    ADD CONSTRAINT candidate_raw_data_candidate_id_key UNIQUE (candidate_id);


--
-- Name: candidate_raw_data candidate_raw_data_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_raw_data
    ADD CONSTRAINT candidate_raw_data_pkey PRIMARY KEY (id);


--
-- Name: candidate_soft_skills candidate_soft_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_soft_skills
    ADD CONSTRAINT candidate_soft_skills_pkey PRIMARY KEY (id);


--
-- Name: candidate_technical_skills candidate_technical_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_technical_skills
    ADD CONSTRAINT candidate_technical_skills_pkey PRIMARY KEY (id);


--
-- Name: candidate_volunteering candidate_volunteering_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_volunteering
    ADD CONSTRAINT candidate_volunteering_pkey PRIMARY KEY (id);


--
-- Name: candidate_volunteering_responsibilities candidate_volunteering_responsibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_volunteering_responsibilities
    ADD CONSTRAINT candidate_volunteering_responsibilities_pkey PRIMARY KEY (id);


--
-- Name: candidate_work_experience_achievements candidate_work_experience_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience_achievements
    ADD CONSTRAINT candidate_work_experience_achievements_pkey PRIMARY KEY (id);


--
-- Name: candidate_work_experience candidate_work_experience_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience
    ADD CONSTRAINT candidate_work_experience_pkey PRIMARY KEY (id);


--
-- Name: candidate_work_experience_responsibilities candidate_work_experience_responsibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience_responsibilities
    ADD CONSTRAINT candidate_work_experience_responsibilities_pkey PRIMARY KEY (id);


--
-- Name: candidate_work_experience_technologies candidate_work_experience_technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience_technologies
    ADD CONSTRAINT candidate_work_experience_technologies_pkey PRIMARY KEY (id);


--
-- Name: candidates candidates_candidate_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT candidates_candidate_id_key UNIQUE (candidate_id);


--
-- Name: candidates candidates_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT candidates_pkey PRIMARY KEY (id);


--
-- Name: education_courses education_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.education_courses
    ADD CONSTRAINT education_courses_pkey PRIMARY KEY (id);


--
-- Name: employee_additional_info employee_additional_info_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_additional_info
    ADD CONSTRAINT employee_additional_info_employee_id_key UNIQUE (employee_id);


--
-- Name: employee_additional_info employee_additional_info_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_additional_info
    ADD CONSTRAINT employee_additional_info_pkey PRIMARY KEY (id);


--
-- Name: employee_addresses employee_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_addresses
    ADD CONSTRAINT employee_addresses_pkey PRIMARY KEY (id);


--
-- Name: employee_awards employee_awards_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_awards
    ADD CONSTRAINT employee_awards_pkey PRIMARY KEY (id);


--
-- Name: employee_certifications employee_certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_certifications
    ADD CONSTRAINT employee_certifications_pkey PRIMARY KEY (id);


--
-- Name: employee_education employee_education_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_education
    ADD CONSTRAINT employee_education_pkey PRIMARY KEY (id);


--
-- Name: employee_hobbies employee_hobbies_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_hobbies
    ADD CONSTRAINT employee_hobbies_pkey PRIMARY KEY (id);


--
-- Name: employee_languages employee_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_languages
    ADD CONSTRAINT employee_languages_pkey PRIMARY KEY (id);


--
-- Name: employee_personal_info employee_personal_info_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_personal_info
    ADD CONSTRAINT employee_personal_info_employee_id_key UNIQUE (employee_id);


--
-- Name: employee_personal_info employee_personal_info_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_personal_info
    ADD CONSTRAINT employee_personal_info_pkey PRIMARY KEY (id);


--
-- Name: employee_projects employee_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_projects
    ADD CONSTRAINT employee_projects_pkey PRIMARY KEY (id);


--
-- Name: employee_publications employee_publications_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_publications
    ADD CONSTRAINT employee_publications_pkey PRIMARY KEY (id);


--
-- Name: employee_soft_skills employee_soft_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_soft_skills
    ADD CONSTRAINT employee_soft_skills_pkey PRIMARY KEY (id);


--
-- Name: employee_technical_skills employee_technical_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_technical_skills
    ADD CONSTRAINT employee_technical_skills_pkey PRIMARY KEY (id);


--
-- Name: employee_volunteering employee_volunteering_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_volunteering
    ADD CONSTRAINT employee_volunteering_pkey PRIMARY KEY (id);


--
-- Name: employee_work_experience employee_work_experience_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_work_experience
    ADD CONSTRAINT employee_work_experience_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: job_application_notes job_application_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_application_notes
    ADD CONSTRAINT job_application_notes_pkey PRIMARY KEY (id);


--
-- Name: job_applications job_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT job_applications_pkey PRIMARY KEY (id);


--
-- Name: job_posting_activities job_posting_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_activities
    ADD CONSTRAINT job_posting_activities_pkey PRIMARY KEY (id);


--
-- Name: job_posting_daily_stats job_posting_daily_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_daily_stats
    ADD CONSTRAINT job_posting_daily_stats_pkey PRIMARY KEY (id);


--
-- Name: job_posting_notes job_posting_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_notes
    ADD CONSTRAINT job_posting_notes_pkey PRIMARY KEY (id);


--
-- Name: job_postings job_postings_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_postings
    ADD CONSTRAINT job_postings_pkey PRIMARY KEY (id);


--
-- Name: project_achievements project_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.project_achievements
    ADD CONSTRAINT project_achievements_pkey PRIMARY KEY (id);


--
-- Name: project_links project_links_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.project_links
    ADD CONSTRAINT project_links_pkey PRIMARY KEY (id);


--
-- Name: project_technologies project_technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.project_technologies
    ADD CONSTRAINT project_technologies_pkey PRIMARY KEY (id);


--
-- Name: skill_categories skill_categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.skill_categories
    ADD CONSTRAINT skill_categories_category_name_key UNIQUE (category_name);


--
-- Name: skill_categories skill_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.skill_categories
    ADD CONSTRAINT skill_categories_pkey PRIMARY KEY (id);


--
-- Name: job_posting_daily_stats uq_job_posting_date; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_daily_stats
    ADD CONSTRAINT uq_job_posting_date UNIQUE (job_posting_id, date);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: volunteering_responsibilities volunteering_responsibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.volunteering_responsibilities
    ADD CONSTRAINT volunteering_responsibilities_pkey PRIMARY KEY (id);


--
-- Name: work_experience_achievements work_experience_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.work_experience_achievements
    ADD CONSTRAINT work_experience_achievements_pkey PRIMARY KEY (id);


--
-- Name: work_experience_responsibilities work_experience_responsibilities_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.work_experience_responsibilities
    ADD CONSTRAINT work_experience_responsibilities_pkey PRIMARY KEY (id);


--
-- Name: work_experience_technologies work_experience_technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.work_experience_technologies
    ADD CONSTRAINT work_experience_technologies_pkey PRIMARY KEY (id);


--
-- Name: idx_achievements_work_exp_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_achievements_work_exp_id ON public.work_experience_achievements USING btree (work_experience_id);


--
-- Name: idx_additional_info_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_additional_info_employee_id ON public.employee_additional_info USING btree (employee_id);


--
-- Name: idx_application_notes_application_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_application_notes_application_id ON public.job_application_notes USING btree (application_id);


--
-- Name: idx_awards_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_awards_employee_id ON public.employee_awards USING btree (employee_id);


--
-- Name: idx_candidate_additional_info_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_additional_info_candidate_id ON public.candidate_additional_info USING btree (candidate_id);


--
-- Name: idx_candidate_addresses_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_addresses_candidate_id ON public.candidate_addresses USING btree (candidate_id);


--
-- Name: idx_candidate_awards_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_awards_candidate_id ON public.candidate_awards USING btree (candidate_id);


--
-- Name: idx_candidate_certifications_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_certifications_candidate_id ON public.candidate_certifications USING btree (candidate_id);


--
-- Name: idx_candidate_education_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_education_candidate_id ON public.candidate_education USING btree (candidate_id);


--
-- Name: idx_candidate_education_courses_education_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_education_courses_education_id ON public.candidate_education_courses USING btree (education_id);


--
-- Name: idx_candidate_hobbies_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_hobbies_candidate_id ON public.candidate_hobbies USING btree (candidate_id);


--
-- Name: idx_candidate_languages_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_languages_candidate_id ON public.candidate_languages USING btree (candidate_id);


--
-- Name: idx_candidate_personal_info_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_personal_info_candidate_id ON public.candidate_personal_info USING btree (candidate_id);


--
-- Name: idx_candidate_project_ach_project_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_project_ach_project_id ON public.candidate_project_achievements USING btree (project_id);


--
-- Name: idx_candidate_project_links_project_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_project_links_project_id ON public.candidate_project_links USING btree (project_id);


--
-- Name: idx_candidate_project_tech_project_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_project_tech_project_id ON public.candidate_project_technologies USING btree (project_id);


--
-- Name: idx_candidate_projects_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_projects_candidate_id ON public.candidate_projects USING btree (candidate_id);


--
-- Name: idx_candidate_publications_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_publications_candidate_id ON public.candidate_publications USING btree (candidate_id);


--
-- Name: idx_candidate_raw_data_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_raw_data_candidate_id ON public.candidate_raw_data USING btree (candidate_id);


--
-- Name: idx_candidate_raw_data_jsonb; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_raw_data_jsonb ON public.candidate_raw_data USING gin (raw_structured_data);


--
-- Name: idx_candidate_soft_skills_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_soft_skills_candidate_id ON public.candidate_soft_skills USING btree (candidate_id);


--
-- Name: idx_candidate_technical_skills_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_technical_skills_candidate_id ON public.candidate_technical_skills USING btree (candidate_id);


--
-- Name: idx_candidate_vol_resp_volunteering_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_vol_resp_volunteering_id ON public.candidate_volunteering_responsibilities USING btree (volunteering_id);


--
-- Name: idx_candidate_volunteering_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_volunteering_candidate_id ON public.candidate_volunteering USING btree (candidate_id);


--
-- Name: idx_candidate_work_exp_ach_work_exp_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_work_exp_ach_work_exp_id ON public.candidate_work_experience_achievements USING btree (work_experience_id);


--
-- Name: idx_candidate_work_exp_resp_work_exp_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_work_exp_resp_work_exp_id ON public.candidate_work_experience_responsibilities USING btree (work_experience_id);


--
-- Name: idx_candidate_work_exp_tech_work_exp_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_work_exp_tech_work_exp_id ON public.candidate_work_experience_technologies USING btree (work_experience_id);


--
-- Name: idx_candidate_work_experience_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidate_work_experience_candidate_id ON public.candidate_work_experience USING btree (candidate_id);


--
-- Name: idx_candidates_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidates_candidate_id ON public.candidates USING btree (candidate_id);


--
-- Name: idx_candidates_created_at; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidates_created_at ON public.candidates USING btree (created_at);


--
-- Name: idx_candidates_email; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_candidates_email ON public.candidates USING btree (email);


--
-- Name: idx_certifications_dates; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_certifications_dates ON public.employee_certifications USING btree (issue_date, expiration_date);


--
-- Name: idx_certifications_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_certifications_employee_id ON public.employee_certifications USING btree (employee_id);


--
-- Name: idx_courses_education_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_courses_education_id ON public.education_courses USING btree (education_id);


--
-- Name: idx_education_dates; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_education_dates ON public.employee_education USING btree (start_date, end_date);


--
-- Name: idx_education_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_education_employee_id ON public.employee_education USING btree (employee_id);


--
-- Name: idx_employee_addresses_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_employee_addresses_employee_id ON public.employee_addresses USING btree (employee_id);


--
-- Name: idx_employee_personal_info_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_employee_personal_info_employee_id ON public.employee_personal_info USING btree (employee_id);


--
-- Name: idx_hobbies_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_hobbies_employee_id ON public.employee_hobbies USING btree (employee_id);


--
-- Name: idx_job_applications_candidate_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_applications_candidate_id ON public.job_applications USING btree (candidate_id);


--
-- Name: idx_job_applications_email; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_applications_email ON public.job_applications USING btree (email);


--
-- Name: idx_job_applications_pipeline_stage; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_applications_pipeline_stage ON public.job_applications USING btree (pipeline_stage);


--
-- Name: idx_job_applications_posting_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_applications_posting_id ON public.job_applications USING btree (job_posting_id);


--
-- Name: idx_job_applications_status; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_applications_status ON public.job_applications USING btree (status);


--
-- Name: idx_job_posting_activities_posting_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_posting_activities_posting_id ON public.job_posting_activities USING btree (job_posting_id);


--
-- Name: idx_job_posting_daily_stats_posting_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_posting_daily_stats_posting_id ON public.job_posting_daily_stats USING btree (job_posting_id);


--
-- Name: idx_job_posting_notes_posting_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_posting_notes_posting_id ON public.job_posting_notes USING btree (job_posting_id);


--
-- Name: idx_job_postings_department; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_postings_department ON public.job_postings USING btree (department);


--
-- Name: idx_job_postings_status; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_job_postings_status ON public.job_postings USING btree (status);


--
-- Name: idx_languages_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_languages_employee_id ON public.employee_languages USING btree (employee_id);


--
-- Name: idx_project_achievements_project_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_project_achievements_project_id ON public.project_achievements USING btree (project_id);


--
-- Name: idx_project_links_project_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_project_links_project_id ON public.project_links USING btree (project_id);


--
-- Name: idx_project_technologies_project_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_project_technologies_project_id ON public.project_technologies USING btree (project_id);


--
-- Name: idx_projects_dates; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_projects_dates ON public.employee_projects USING btree (start_date, end_date);


--
-- Name: idx_projects_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_projects_employee_id ON public.employee_projects USING btree (employee_id);


--
-- Name: idx_publications_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_publications_employee_id ON public.employee_publications USING btree (employee_id);


--
-- Name: idx_responsibilities_work_exp_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_responsibilities_work_exp_id ON public.work_experience_responsibilities USING btree (work_experience_id);


--
-- Name: idx_soft_skills_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_soft_skills_employee_id ON public.employee_soft_skills USING btree (employee_id);


--
-- Name: idx_technical_skills_category; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_technical_skills_category ON public.employee_technical_skills USING btree (skill_category_id);


--
-- Name: idx_technical_skills_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_technical_skills_employee_id ON public.employee_technical_skills USING btree (employee_id);


--
-- Name: idx_technologies_work_exp_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_technologies_work_exp_id ON public.work_experience_technologies USING btree (work_experience_id);


--
-- Name: idx_volunteering_employee_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_volunteering_employee_id ON public.employee_volunteering USING btree (employee_id);


--
-- Name: idx_volunteering_resp_volunteering_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_volunteering_resp_volunteering_id ON public.volunteering_responsibilities USING btree (volunteering_id);


--
-- Name: idx_work_experience_dates; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_work_experience_dates ON public.employee_work_experience USING btree (start_date, end_date);


--
-- Name: ix_employees_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ix_employees_id ON public.employees USING btree (id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: candidate_additional_info candidate_additional_info_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_additional_info
    ADD CONSTRAINT candidate_additional_info_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_addresses candidate_addresses_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_addresses
    ADD CONSTRAINT candidate_addresses_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_awards candidate_awards_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_awards
    ADD CONSTRAINT candidate_awards_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_certifications candidate_certifications_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_certifications
    ADD CONSTRAINT candidate_certifications_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_education candidate_education_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_education
    ADD CONSTRAINT candidate_education_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_education_courses candidate_education_courses_education_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_education_courses
    ADD CONSTRAINT candidate_education_courses_education_id_fkey FOREIGN KEY (education_id) REFERENCES public.candidate_education(id) ON DELETE CASCADE;


--
-- Name: candidate_hobbies candidate_hobbies_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_hobbies
    ADD CONSTRAINT candidate_hobbies_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_languages candidate_languages_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_languages
    ADD CONSTRAINT candidate_languages_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_personal_info candidate_personal_info_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_personal_info
    ADD CONSTRAINT candidate_personal_info_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_project_achievements candidate_project_achievements_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_project_achievements
    ADD CONSTRAINT candidate_project_achievements_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.candidate_projects(id) ON DELETE CASCADE;


--
-- Name: candidate_project_links candidate_project_links_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_project_links
    ADD CONSTRAINT candidate_project_links_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.candidate_projects(id) ON DELETE CASCADE;


--
-- Name: candidate_project_technologies candidate_project_technologies_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_project_technologies
    ADD CONSTRAINT candidate_project_technologies_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.candidate_projects(id) ON DELETE CASCADE;


--
-- Name: candidate_projects candidate_projects_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_projects
    ADD CONSTRAINT candidate_projects_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_publications candidate_publications_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_publications
    ADD CONSTRAINT candidate_publications_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_raw_data candidate_raw_data_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_raw_data
    ADD CONSTRAINT candidate_raw_data_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_soft_skills candidate_soft_skills_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_soft_skills
    ADD CONSTRAINT candidate_soft_skills_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_technical_skills candidate_technical_skills_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_technical_skills
    ADD CONSTRAINT candidate_technical_skills_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_volunteering candidate_volunteering_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_volunteering
    ADD CONSTRAINT candidate_volunteering_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_volunteering_responsibilities candidate_volunteering_responsibilities_volunteering_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_volunteering_responsibilities
    ADD CONSTRAINT candidate_volunteering_responsibilities_volunteering_id_fkey FOREIGN KEY (volunteering_id) REFERENCES public.candidate_volunteering(id) ON DELETE CASCADE;


--
-- Name: candidate_work_experience_achievements candidate_work_experience_achievements_work_experience_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience_achievements
    ADD CONSTRAINT candidate_work_experience_achievements_work_experience_id_fkey FOREIGN KEY (work_experience_id) REFERENCES public.candidate_work_experience(id) ON DELETE CASCADE;


--
-- Name: candidate_work_experience candidate_work_experience_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience
    ADD CONSTRAINT candidate_work_experience_candidate_id_fkey FOREIGN KEY (candidate_id) REFERENCES public.candidates(candidate_id) ON DELETE CASCADE;


--
-- Name: candidate_work_experience_responsibilities candidate_work_experience_responsibilit_work_experience_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience_responsibilities
    ADD CONSTRAINT candidate_work_experience_responsibilit_work_experience_id_fkey FOREIGN KEY (work_experience_id) REFERENCES public.candidate_work_experience(id) ON DELETE CASCADE;


--
-- Name: candidate_work_experience_technologies candidate_work_experience_technologies_work_experience_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.candidate_work_experience_technologies
    ADD CONSTRAINT candidate_work_experience_technologies_work_experience_id_fkey FOREIGN KEY (work_experience_id) REFERENCES public.candidate_work_experience(id) ON DELETE CASCADE;


--
-- Name: job_application_notes fk_application_notes_application; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_application_notes
    ADD CONSTRAINT fk_application_notes_application FOREIGN KEY (application_id) REFERENCES public.job_applications(id) ON DELETE CASCADE;


--
-- Name: job_application_notes fk_application_notes_author; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_application_notes
    ADD CONSTRAINT fk_application_notes_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: education_courses fk_education; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.education_courses
    ADD CONSTRAINT fk_education FOREIGN KEY (education_id) REFERENCES public.employee_education(id) ON DELETE CASCADE;


--
-- Name: job_applications fk_job_applications_posting; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT fk_job_applications_posting FOREIGN KEY (job_posting_id) REFERENCES public.job_postings(id) ON DELETE CASCADE;


--
-- Name: job_posting_activities fk_job_posting_activities_actor; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_activities
    ADD CONSTRAINT fk_job_posting_activities_actor FOREIGN KEY (actor_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: job_posting_activities fk_job_posting_activities_posting; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_activities
    ADD CONSTRAINT fk_job_posting_activities_posting FOREIGN KEY (job_posting_id) REFERENCES public.job_postings(id) ON DELETE CASCADE;


--
-- Name: job_posting_daily_stats fk_job_posting_daily_stats_posting; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_daily_stats
    ADD CONSTRAINT fk_job_posting_daily_stats_posting FOREIGN KEY (job_posting_id) REFERENCES public.job_postings(id) ON DELETE CASCADE;


--
-- Name: job_posting_notes fk_job_posting_notes_author; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_notes
    ADD CONSTRAINT fk_job_posting_notes_author FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: job_posting_notes fk_job_posting_notes_posting; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_posting_notes
    ADD CONSTRAINT fk_job_posting_notes_posting FOREIGN KEY (job_posting_id) REFERENCES public.job_postings(id) ON DELETE CASCADE;


--
-- Name: job_postings fk_job_postings_creator; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.job_postings
    ADD CONSTRAINT fk_job_postings_creator FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: project_achievements fk_project; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.project_achievements
    ADD CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES public.employee_projects(id) ON DELETE CASCADE;


--
-- Name: project_links fk_project; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.project_links
    ADD CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES public.employee_projects(id) ON DELETE CASCADE;


--
-- Name: project_technologies fk_project; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.project_technologies
    ADD CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES public.employee_projects(id) ON DELETE CASCADE;


--
-- Name: employee_technical_skills fk_skill_category; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.employee_technical_skills
    ADD CONSTRAINT fk_skill_category FOREIGN KEY (skill_category_id) REFERENCES public.skill_categories(id) ON DELETE SET NULL;


--
-- Name: volunteering_responsibilities fk_volunteering; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.volunteering_responsibilities
    ADD CONSTRAINT fk_volunteering FOREIGN KEY (volunteering_id) REFERENCES public.employee_volunteering(id) ON DELETE CASCADE;


--
-- Name: work_experience_achievements fk_work_experience; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.work_experience_achievements
    ADD CONSTRAINT fk_work_experience FOREIGN KEY (work_experience_id) REFERENCES public.employee_work_experience(id) ON DELETE CASCADE;


--
-- Name: work_experience_responsibilities fk_work_experience; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.work_experience_responsibilities
    ADD CONSTRAINT fk_work_experience FOREIGN KEY (work_experience_id) REFERENCES public.employee_work_experience(id) ON DELETE CASCADE;


--
-- Name: work_experience_technologies fk_work_experience; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.work_experience_technologies
    ADD CONSTRAINT fk_work_experience FOREIGN KEY (work_experience_id) REFERENCES public.employee_work_experience(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict ZfIPQ8gSxn29riODs4Na2PKu2BTrmb0fSFxMnUj1eoFa8cJ4VAecE6BacNwkNpd

