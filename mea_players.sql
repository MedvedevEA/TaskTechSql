CREATE TABLE IF NOT EXISTS public.players(
    player_id serial NOT NULL,
    name character varying(10) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT players_pk PRIMARY KEY (player_id),
    CONSTRAINT players_name_unique UNIQUE (name),
    CONSTRAINT players_name_74 CHECK ("substring"(name::text, 1, 2) = '74'::text),
    CONSTRAINT players_name_length CHECK (length(name::text) = 10)
);
INSERT INTO public.players("name")
WITH symbols(value) AS (VALUES ('0123456789'))
SELECT '74' || string_agg(substr(symbols.value, (random() * (length(symbols.value) - 1) + 1)::INTEGER, 1), '')
FROM symbols
JOIN generate_series(1,8) AS word(index) on true 
JOIN generate_series(1,100) AS words(index) on true
GROUP BY words.index
ORDER BY words.index;
SELECT * FROM public.players;