mac:
	GOOS=darwin GOARCH=amd64 go build -o ../bin/darwin-amd64/tui-select ./tui-select.go
	GOOS=darwin GOARCH=386 go build -o ../bin/darwin-386/tui-select ./tui-select.go
all:
	GOOS=linux GOARCH=arm GOARM=5 go build -o ../bin/linux-arm5/tui-select ./tui-select.go
	GOOS=linux GOARCH=arm GOARM=6 go build -o ../bin/linux-arm6/tui-select ./tui-select.go
	GOOS=linux GOARCH=arm GOARM=7 go build -o ../bin/linux-arm7/tui-select ./tui-select.go
	GOOS=linux GOARCH=amd64 go build -o ../bin/linux-amd64/tui-select ./tui-select.go
	GOOS=linux GOARCH=386 go build -o ../bin/linux-386/tui-select ./tui-select.go

	GOOS=freebsd GOARCH=amd64 go build -o ../bin/freebsd-amd64/tui-select ./tui-select.go
	GOOS=freebsd GOARCH=386 go build -o ../bin/freebsd-386/tui-select ./tui-select.go

	GOOS=openbsd GOARCH=amd64 go build -o ../bin/openbsd-amd64/tui-select ./tui-select.go
	GOOS=openbsd GOARCH=386 go build -o ../bin/openbsd-386/tui-select ./tui-select.go

	GOOS=windows GOARCH=amd64 go build -o ../bin/win-amd64/tui-select.exe ./tui-select.go
	GOOS=windows GOARCH=386 go build -o ../bin/win-386/tui-select.exe ./tui-select.go
	make mac
