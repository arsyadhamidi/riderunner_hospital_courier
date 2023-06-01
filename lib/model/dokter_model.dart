class ModelDokter{
  String idDokter;
  String tglDokter;
  String jamDokter;
  String jarakDokter;
  String lokasiDokter;

  ModelDokter(
      this.idDokter,
      this.tglDokter,
      this.jamDokter,
      this.jarakDokter,
      this.lokasiDokter,
  );
}

List<ModelDokter>? listDokter = [
  ModelDokter(
    'Batch 1',
    '24 Mei 2023',
    '10:30',
    '3,0 km - 10 menit',
    'Hospital A - Farmasi',
  ),
  ModelDokter(
    'Batch 90',
    '24 Mei 2023',
    '11:27',
    '10 km - 10 menit',
    'Hospital P - Apotek',
  ),
  ModelDokter(
    'Batch 1',
    '24 Mei 2023',
    '10:30',
    '3,0 km - 10 menit',
    'Hospital A - Farmasi',
  ),
  ModelDokter(
    'Batch 90',
    '24 Mei 2023',
    '11:27',
    '10 km - 10 menit',
    'Hospital P - Apotek',
  ),
];