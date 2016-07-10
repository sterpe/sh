# Given two identical file directories, A & B,
# with identical files but different time stamps
# and permissions, confirm that every file of type
# *.x and *.y in A hashes to the same md5sum as in B

# This is useful b/c in such a scenario tarring A and B
# then taking the md5sum of each will not work.

IFS=$'\n'
for file in $(find A -name "*.x" -or -name "*.y"); do
	A=$file
	B=`echo "${A}" | sed -n 's/A\//B\//p'`
	MD5A=`md5sum "${A}" | cut -d' ' -f1`
	MD5B=`md5sum "${B}" | cut -d' ' -f1`
	if [ "$MD5A" != "$MD5B" ];
		then
			echo "${A} AND ${B} ARE NOT SAME."
	fi
done
unset IFS
