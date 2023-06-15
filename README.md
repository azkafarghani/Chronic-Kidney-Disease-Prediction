# Chronic Kidney Disease Prediction with Random Forest

# Dataset
Dataset Chronic Kidney Disease diambil dari kaggle https://www.kaggle.com/datasets/mansoordaku/ckdisease yang memiliki 400 record dengan 25 atribut. Data tersebut diambil selama 2 bulan di India.

# Sekilas Tentang
[`^ kembali ke atas ^`](#)

Chronic Kidney Disease atau Penyakit Ginjal Kronis (PGK) merupakan gangguan pada ginjal yang ditandai dengan kelainan fungsi organ yang berlangsung selama lebih dari tiga bulan. PGK sendiri telah menjadi penyebab kematian di dunia pada urutan ke-27 pada tahun 1990 dan pada tahun 2010 naik drastis menjadi urutan ke-18. Dengan meningkatnya jumlah penderita penyakit ginjal kronis perlu adanya diagnosis yang tepat dan cepat dengan menemukan metode yang memberikan nilai akurasi yang baik dan tertinggi. Oleh karena itu, digunakan algoritma random forest karena cocok diterapkan pada data yang berurusan besar seperti diagnosis penyakit. Tahapan prosesnya meliputi eksplorasi data, pra proses data, dan memodelkan data dengan random forest. Proses ini menggunakan bantuan R Studio dan Python. Berdasarkan pengujian yang telah dilakukan diperoleh tingkat akurasi 98% dengan presisi 98% dan recall 99%. 



# Tujuan
[`^ kembali ke atas ^`](#)
Tujuan project ini adalah membuat model prediksi penyakit Chronic Kidney Disease dengan algoritma data mining random forest sehingga dapat mempermudah tenaga medis dalam mendiagnosa pasien.

# Eksplorasi Data
[`^ kembali ke atas ^`](#)
Pertama, dilakukan ekspolrasi data untuk mengetahui jumlah, rincian tipe datanya, serta struktur datanya.
```
df = pd.read_csv('/content/drive/MyDrive/Semester 6/Daming/kidney_disease.csv')
df.head() 
df.info()
```

# Praproses Data
[`^ kembali ke atas ^`](#)
Selanjutnya dilakukan praproses data, pertama, nilai kategorikal akan diubah menjadi m=numerik untuk dapat digunakan dalam analisis atau pemrosesan data lebih lanjut.
```
df[['htn','dm','cad','pe','ane']] = df[['htn','dm','cad','pe','ane']].replace(to_replace={'yes':1,'no':0})
df[['rbc','pc']] = df[['rbc','pc']].replace(to_replace={'abnormal':1,'normal':0})
df[['pcc','ba']] = df[['pcc','ba']].replace(to_replace={'present':1,'notpresent':0})
df[['appet']] = df[['appet']].replace(to_replace={'good':1,'poor':0,'no':np.nan})
#df['classification'] = df['classification'].replace(to_replace={'ckd':1.0,'ckd\t':1.0,'notckd':0.0,'no':0.0})
```
