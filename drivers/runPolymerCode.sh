# enter source directory
cd ../src/PolymerCode

# compile code
gcc -O3 driveMetropolis.c -o metropolis.out -lm

# update the seed

    # read the hex string from file
    hex=$(<ISEED)

    # increment it: first interpret as hex (0x...), then add
    dec=$((16#$hex + 1))

    # convert back to lowercase hex and overwrite file
    printf "%x\n" "$dec" > ISEED

# copy compiled code and helper files to runs directory
cp metropolis.out ../../runs/metropolis.out
cp parameters.txt ../../runs/parameters.txt
cp ISEED ../../runs/ISEED

# enter runs directory 
cd ../../runs/

# run simulations
./metropolis.out parameters.txt outputNonDimer.txt 0 2 50 35.5 0

./metropolis.out parameters.txt outputDimer.txt 0 2 50 35.5 10

# remove compiled code and helper files from runs directory
rm metropolis.out
rm parameters.txt
rm ISEED

# return to source directory
cd ../src/PolymerCode

