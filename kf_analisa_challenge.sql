SELECT
  t.transaction_id,
  t.customer_name,
  p.product_id,
  p.product_name,
  p.price AS actual_price,
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
ON
  t.product_id = p.product_id
JOIN
  `rakamin-kf-analytics-467715.kimia_farma.kf_kantor_cabang` c
ON
  t.branch_id = c.branch_id;
