cd /home/ptroncos/verano2017/fit_fsps/Frontierv6/
rm -rf montegrids/
rm -rf sfhgrid01/
mkdir montegrids
mkdir montegrids/sfhgrid01
mkdir montegrids/sfhgrid01/fsps_v2.4_miles
mkdir montegrids/sfhgrid01/fsps_v2.4_miles/charlot
cd montegrids/sfhgrid01/fsps_v2.4_miles/charlot
ln -s /home/ptroncos/verano2017/fit_fsps/montegrids/sfhgrid01/fsps_v2.4_miles/charlot/zd_fsps_v2.4_miles_salp_montegrid.fits.gz zd_fsps_v2.4_miles_salp_montegrid.fits.gz
for j in {1..8} ; do
ln -s /home/ptroncos/verano2017/fit_fsps/montegrids/sfhgrid01/fsps_v2.4_miles/charlot/zd_fsps_v2.4_miles_salp_chunk_000${j}.fits.gz zd_fsps_v2.4_miles_salp_chunk_000${j}.fits.gz
done


cd /home/ptroncos/verano2017/fit_fsps/Frontierv6/
mkdir sfhgrid01/
mkdir sfhgrid01/charlot
cd sfhgrid01/charlot
for j in {1..8} ; do
ln -s /home/ptroncos/verano2017/fit_fsps/sfhgrid01/charlot/zd_fsps_v2.4_miles_salp_chunk_000${j}.fits.gz zd_fsps_v2.4_miles_salp_chunk_000${j}.fits.gz
done

cd /home/ptroncos/verano2017/fit_fsps/Frontierv6/

ls -al montegrids/sfhgrid01/fsps_v2.4_miles/charlot/*montegrid.fits.gz
ls -al sfhgrid01/charlot/*chunk_0008.fits.gz
