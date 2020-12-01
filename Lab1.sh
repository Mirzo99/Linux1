#1
mkdir ~/test 
cd ~/test

#2
ls -Fa /etc > list 

#3
find /etc -maxdepth 1 -type d | wc -l >> list 
find /etc -maxdepth 1 -type f -name ".*" | wc -l >> list

#4
mkdir links 

#5
ln list links/list_hlink 

#6
ln -s ~/test/list ~/test/links/list_slink 

#7
echo "list: " && find . -samefile list | wc -l 
echo "list_hlink: " && find . -samefile links/list_hlink | wc -l
echo "list_slink: " && find . -samefile links/list_slink | wc -l

#8
cat list | wc -l >> links/list_hlink 

#9
cmp -s links/list_hlink links/list_slink && echo "before renaming: YES" 

#10
mv list list1 

#11
cmp -s links/list_hlink links/list_slink && echo "after renaming: YES" 

#12
cd ~
ln test/list1 list_link

#13
find /etc -name '*.conf' -type f 2> /dev/null > list_conf 

#14
find /etc -name '*.d' -type d 2> /dev/null > list_d 

#15
cat list_conf > list_conf_d && cat list_d >> list_conf_d 

#16
mkdir test/.sub 

#17
cp list_conf_d test/.sub 

#18
cp -b list_conf_d test/.sub 

#19
ls -aR 

#20
man man > man.txt 

#21
split -b 1024 -d man.txt split-man- 

#22
mkdir man.dir 

#23
mv split-man-* man.dir/ 

#24
cat man.dir/split-man-* > man.dir/man.txt 

#25
cmp -s man.txt man.dir/man.txt && echo "man files: YES" 

#26
{ echo "starting text"; cat man.txt; } > man.txt.new \
&& mv man.txt.new man.txt \
&& echo "ending text" >> man.txt 

#27
diff man.txt  man.dir/man.txt > patch 

#28
mv patch man.dir/ 

#29
patch man.dir/man.txt man.dir/patch 

#30
cmp -s man.txt man.dir/man.txt && echo "after patch: YES" 