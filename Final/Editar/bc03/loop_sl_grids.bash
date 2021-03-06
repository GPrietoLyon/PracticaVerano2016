cd /home/ptroncos/verano2017/fit_bc03/photoz_Frontierv6
rm -rf montegrids/
rm -rf sfhgrid01/
mkdir montegrids
mkdir montegrids/sfhgrid01
mkdir montegrids/sfhgrid01/bc03_stelib
mkdir montegrids/sfhgrid01/bc03_stelib/charlot
cd montegrids/sfhgrid01/bc03_stelib/charlot
ln -s /home/ptroncos/verano2017/fit_bc03/montegrids/sfhgrid01/bc03_stelib/charlot/zd_bc03_stelib_salp_montegrid.fits.gz zd_bc03_stelib_salp_montegrid.fits.gz
for j in {1..8} ; do
ln -s /home/ptroncos/verano2017/fit_bc03/montegrids/sfhgrid01/bc03_stelib/charlot/zd_bc03_stelib_salp_chunk_000${j}.fits.gz zd_bc03_stelib_salp_chunk_000${j}.fits.gz
done


cd /home/ptroncos/verano2017/fit_bc03/photoz_Frontierv6
mkdir sfhgrid01/
mkdir sfhgrid01/charlot
cd sfhgrid01/charlot
for j in {1..8} ; do
ln -s /home/ptroncos/verano2017/fit_bc03/sfhgrid01/charlot/zd_bc03_stelib_salp_chunk_000${j}.fits.gz zd_bc03_stelib_salp_chunk_000${j}.fits.gz
done

cd /home/ptroncos/verano2017/fit_bc03/photoz_Frontierv6

ls -al montegrids/sfhgrid01/bc03_stelib/charlot/*montegrid.fits.gz
ls -al sfhgrid01/charlot/*chunk_0008.fits.gz
