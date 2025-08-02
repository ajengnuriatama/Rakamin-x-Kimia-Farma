CREATE OR REPLACE TABLE `rakamin-kf-analytics-467715.kimia_farma.kf_analisa` AS
SELECT
  t.transaction_id,
  t.date,
  t.customer_name,
  p.product_id,
  p.product_name,
  p.price AS actual_price,
  t.discount_percentage,
  
  -- Hitung persentase gross laba berdasarkan harga
  CASE 
    WHEN p.price <= 50000 THEN 0.10
    WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
    WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
    WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,

  -- Hitung nett_sales: harga setelah diskon
  ROUND(p.price * (1 - t.discount_percentage/100), 2) AS nett_sales,

  -- Hitung nett_profit: nett_sales dikali persentase laba
  ROUND(
    ROUND(p.price * (1 - t.discount_percentage/100), 2) *
    CASE 
      WHEN p.price <= 50000 THEN 0.10
      WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
      WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
      WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
      ELSE 0.30
    END
  , 2) AS nett_profit,

  c.branch_id,
  c.branch_name,
  c.kota,
  c.provinsi,
  c.rating AS rating_cabang,
  t.rating AS rating_transaksi

FROM
  `rakamin-kf-analytics-467715.kimia_farma.kf_final_transaction` t
JOIN
  `rakamin-kf-analytics-467715.kimia_farma.kf_product` p
  ON t.product_id = p.product_id
JOIN
  `rakamin-kf-analytics-467715.kimia_farma.kf_kantor_cabang` c
  ON t.branch_id = c.branch_id;
