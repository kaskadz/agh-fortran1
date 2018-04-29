#!/bin/bash

rm kind*.data

for i in {3..1000};
do
	out/main4 "$i" >> kind4.data  
done

for i in {3..1000};
do
        out/main8 "$i" >> kind8.data  
done

for i in {3..1000};
do
        out/main16 "$i" >> kind16.data  
done

