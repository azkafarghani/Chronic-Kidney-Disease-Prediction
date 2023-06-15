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

Selanjutnya dilakukan replace Missing value

Sebelum itu, nilai kosong pada data akan diganti dengan NA terlebih dahulu

```
data <- data %>% 
  mutate(across(where(is.character), na_if, "")) 
```
Selanjutnya nilai NA akan diisi oleh nilai yang diinginkan, di sini, nilai nominal akan diisi oleh modus yang ada pada row, sedangkan nilai numerik akan diisi oleh nilai mean pada row tersebut.
```
custom_impute <- function(x) {
  if (any(is.na(x))) {
    mode_value <- names(sort(-table(x)))[1]
    x[is.na(x)] <- mode_value
  }
  return(x)
}

# mengisi nilai kosong pada atribut nominal

data <- data %>% 
  mutate(across(where(is.character), ~custom_impute(.)))


# mengisi missing value atribut numerik

data <- data %>%
  mutate(across(where(is.numeric), ~ifelse(is.na(.), mean(., na.rm = TRUE), .)))
```

# Korelasi antar dataset

Selanjutnya, dilakukan pencarian korelasi antar dataset menggunakan heatmap
```
# Korelasi antar dataset
h_labels = [x.replace('_', ' ').title() 

for x in list(df.select_dtypes(include=['number', 'bool']).columns.values)]

fig, ax = plt.subplots(figsize=(20,6))
_ = sns.heatmap(
df.corr(), 
annot=True, 
xticklabels=h_labels, 
yticklabels=h_labels, 
cmap=sns.cubehelix_palette(as_cmap=True), ax=ax)

```

# Modelling data
Pertama, dilakukan pembagian data train dan data test
```
X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=42)
rf_model = RandomForestClassifier(n_estimators=50, max_features="auto", random_state=42)
rf_model.fit(X_train, y_train)  
```
Terdapat 240 record dari 24 atribut digunakan sebagai data training dan 160 record dari 24 atribut digunakan sebagai testing.

Selanjutnya, dilakukan prediksi dari X apakah ckd atau notckd
```
pred = rf_model.predict(X_test)
pred
```
Kemudian, dilakukan visualisasi dari model yang sudah ditrain menggunakan single decision tree
```
for i in range(3):
    tree = rf_model.estimators_[i]
    dot_data = export_graphviz(tree, 
                               feature_names=X_train.columns,  
                               filled=True,  
                               max_depth=2, 
                               impurity=False, 
                               proportion=True)
    graph = graphviz.Source(dot_data)
    display(graph)
```
![Tree](https://github.com/azkafarghani/Chronic-Kidney-Disease-Prediction/blob/main/Tree.png)
Berdasarkan Tree tersebut dapat diketahui simpul dan kondisi pemisahan yang menunjukkan bagaimana pohon keputusan memisahkan data berdasarkan fitur-fitur tertentu dan distribusi kelas pada setiap simpul tersebut.
