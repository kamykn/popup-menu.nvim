package main

import (
	"fmt"
	"github.com/marcusolsson/tui-go"
	"log"
	"os"
	"strconv"
)

// StyledBox is a Box with an overriden Draw method.
// Embedding a Widget within another allows overriding of some behaviors.
type StyledBox struct {
	Style string
	*tui.Box
}

// Draw decorates the Draw call to the widget with a style.
func (s *StyledBox) Draw(p *tui.Painter) {
	p.WithStyle(s.Style, func(p *tui.Painter) {
		s.Box.Draw(p)
	})
}

func main() {
	list := os.Args[5:]

	// A list with some items selected.
	l := tui.NewList()
	l.SetFocused(true)
	l.AddItems(list...)
	l.SetSelected(0)

	root := tui.NewVBox(l)

	ui, err := tui.New(root)
	if err != nil {
		log.Fatal(err)
	}

	t := tui.NewTheme()

	// tcell
	// FYI: https://godoc.org/github.com/gdamore/tcell#Color
	ctermbg, err1 := strconv.ParseInt(os.Args[1], 10, 32)
	ctermfg, err2 := strconv.ParseInt(os.Args[2], 10, 32)
	if err1 == nil && err2 == nil {
		t.SetStyle("list.item", tui.Style{Bg: tui.Color(ctermbg), Fg: tui.Color(ctermfg)})
	}

	ctermbg, err1 = strconv.ParseInt(os.Args[3], 10, 32)
	ctermfg, err2 = strconv.ParseInt(os.Args[4], 10, 32)
	if err1 == nil && err2 == nil {
		t.SetStyle("list.item.selected", tui.Style{Bg: tui.Color(ctermbg), Fg: tui.Color(ctermfg), Bold: tui.DecorationOn})
	}

	t.SetStyle("normal", tui.Style{Bg: tui.ColorDefault, Fg: tui.ColorDefault})
	ui.SetTheme(t)

	l.OnItemActivated(func(l *tui.List) {
		ui.Quit()
		fmt.Println(list[l.Selected()])
	})
	ui.SetKeybinding("Esc", func() { ui.Quit() })
	ui.SetKeybinding("Ctrl+C", func() { ui.Quit() })

	if err := ui.Run(); err != nil {
		log.Fatal(err)
	}
}
