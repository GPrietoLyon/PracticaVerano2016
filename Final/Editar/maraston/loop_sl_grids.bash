cd /home/ptroncos/verano2017/Frontierv6/maraston
rm -rf montegrids/
rm -rf sfhgrid01/
mkdir montegrids
mkdir montegrids/sfhgrid01
mkdir montegrids/sfhgrid01/maraston05
mkdir montegrids/sfhgrid01/maraston05/charlot
cd montegrids/sfhgrid01/maraston05/charlot
ln -s /home/ptroncos/verano2017/fit_maraston/montegrids/sfhgrid01/maraston05/charlot/zd_maraston05_salp_montegrid.fits.gz zd_maraston05_salp_montegrid.fits.gz
for j in {1..8} ; do
ln -s /home/ptroncos/verano2017/fit_maraston/montegrids/sfhgrid01/maraston05/charlot/zd_maraston05_salp_chunk_000${j}.fits.gz zd_maraston05_salp_chunk_000${j}.fits.gz
done


cd /home/ptroncos/verano2017/Frontierv6/maraston
mkdir sfhgrid01/
mkdir sfhgrid01/charlot
cd sfhgrid01/charlot
for j in {1..8} ; do
ln -s /home/ptroncos/verano2017/fit_maraston/sfhgrid01/charlot/zd_maraston05_salp_chunk_000${j}.fits.gz zd_maraston05_salp_chunk_000${j}.fits.gz
done

cd /home/ptroncos/verano2017/Frontierv6/maraston

ls -al montegrids/sfhgrid01/maraston05/charlot/*montegrid.fits.gz
ls -al sfhgrid01/charlot/*chunk_0008.fits.gz
