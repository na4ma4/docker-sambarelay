.PHONY: test
test: artifacts/smb.conf test/test.out
	diff -u test/test.out $(<)

.PHONY: clean
clean:
	$(RM) -r artifacts

artifacts/smb.conf: test/test.yaml smb.conf.tmpl
	-@mkdir -p "$(@D)"
	gomplate -d 'shares=./test/test.yaml' -f smb.conf.tmpl | sed -n '/Share Definitions/,$$p' | tee "$(@)" > /dev/null