#!/usr/bin/env bash
VERSION=18.2
rm -rf config build DDNet-$VERSION
tar xvf DDNet-$VERSION.tar.xz
unzip -o ddnet-libs-87fbb57839080f40d16cd77d8ad11ae91bb9c849.zip
rm -f DDNet-$VERSION/ddnet-libs
mv ddnet-libs-87fbb57839080f40d16cd77d8ad11ae91bb9c849 DDNet-$VERSION/ddnet-libs
mkdir -p build/data/demos
cp Multeasymap_bench.demo RaiNyMore2_bench.demo build/data/demos
cd build
cmake -DCMAKE_BUILD_TYPE=Release ../DDNet-$VERSION
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
# Make sure not to use/overwrite user config, only use our custom config
echo -e "add_path $HOME/config\nadd_path \$DATADIR\nadd_path \$CURRENTDIR" > storage.cfg
cd ..
echo "#!/usr/bin/env bash
rm -f build/bench.cfg
for i in \"\$@\"; do echo \$i >> build/bench.cfg; done
echo \"benchmark_quit 60 \$LOG_FILE\" >> build/bench.cfg
build/DDNet -f build/bench.cfg > ~/test-log 2>&1
" > ddnet
chmod +x ddnet
