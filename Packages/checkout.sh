#!/bin/sh

curdir=${PWD##*/}
exdir=$(cat /usr/lib/modules/${curdir}-MANJARO/version)
exdir=/usr/lib/modules/${exdir}/build
echo $exdir
cat ~/.ssh/gpg-passphrase| sudo -S pwd >/dev/null
sudo chown -R phoepsilonix:phoepsilonix $exdir

#cd r8168
#git diff | patch -R -i -
#cd ../tp_smapi
#git diff | patch -R -i -
#cd ..
cd tp_smapi
rm tp_smapi-clang.patch
cd ..

for m in $(cat ../extramodules.txt)
do
        # $mがなかったら、追加する。
        echo $m;
        [[ ! -e ./$m/ ]] && (git submodule update --init $m || git submodule add ssh://git@gitlab.manjaro.org:22277/packages/extra/$curdir/$m $m;)

        # masterブランチをchekoutして、pullでリモートの最新版を取得する
        cd $m;
        git switch -f master
        git diff --binary HEAD | git apply --check --stat --apply --allow-empty -R -
        git checkout master;
        git pull origin master;
        for patch in ~/gitlab/Manjaro-jp/patches/${m}*\.patch ~/gitlab/Manjaro-jp/patches/*${m}\.patch
        do
                if [[ -e $patch ]];then
                        echo "$patch Applying"
                        git apply --check --stat --apply $patch
                fi
        done
        cd ..;
done
 
cd r8168
#patch -i /home/phoepsilonix/gitlab/Manjaro-jp/patches/r8168-extramodules.patch
updpkgsums
#cd ../tp_smapi
#rm tp_smapi-clang.patch
#patch -i /home/phoepsilonix/gitlab/Manjaro-jp/patches/tp_smapi-build-with-clang.patch

exit 0
