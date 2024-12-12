--create
CREATE SCHEMA mea_shop;
CREATE TABLE IF NOT EXISTS mea_shop.shop (
    shop_id uuid NOT NULL DEFAULT gen_random_uuid(),
    name character varying NOT NULL,
    CONSTRAINT shop_pk PRIMARY KEY (shop_id));
CREATE TABLE IF NOT EXISTS mea_shop.product (
    product_id uuid NOT NULL DEFAULT gen_random_uuid(),
    name character varying NOT NULL,
    CONSTRAINT product_pk PRIMARY KEY (product_id));
CREATE TABLE IF NOT EXISTS mea_shop.link (
    shop_product_id uuid NOT NULL DEFAULT gen_random_uuid(),
    shop_id uuid NOT NULL,
    product_id uuid NOT NULL,
    CONSTRAINT shop_product_pkey PRIMARY KEY (shop_product_id),
    CONSTRAINT link_product_fk FOREIGN KEY (product_id)
        REFERENCES mea_shop.product (product_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
        NOT VALID,
    CONSTRAINT link_shop_fk FOREIGN KEY (shop_id)
        REFERENCES mea_shop.shop (shop_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
        NOT VALID);
CREATE INDEX IF NOT EXISTS link_product_idx ON mea_shop.link USING btree (product_id );
CREATE INDEX IF NOT EXISTS link_shop_idx    ON mea_shop.link USING btree (shop_id );
--insert
INSERT INTO mea_shop.product VALUES 
(DEFAULT,'product 1'),
(DEFAULT,'product 2');
INSERT INTO mea_shop.shop VALUES
(DEFAULT,'shop 1'),
(DEFAULT,'shop 2'),
(DEFAULT,'shop 3');
INSERT INTO mea_shop.link(shop_id, product_id)
--select
SELECT _s.shop_id, _p.product_id
FROM mea_shop.shop _s
JOIN mea_shop.product _p ON true;
SELECT _s.name AS shop_name, _p.name AS product_name
FROM mea_shop.link _l
JOIN mea_shop.shop _s ON _l.shop_id=_s.shop_id
JOIN mea_shop.product _p ON _l.product_id=_p.product_id;
--delete
DROP SCHEMA IF EXISTS mea_shop CASCADE;