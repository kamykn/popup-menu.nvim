package main

import (
	"fmt"
	"github.com/marcusolsson/tui-go"
	"log"
	"os"
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
	t := tui.NewTheme()
	normal := tui.Style{Bg: tui.ColorDefault, Fg: tui.ColorDefault}
	t.SetStyle("normal", normal)

	list := os.Args[1:]

	// A list with some items selected.
	l := tui.NewList()
	l.SetFocused(true)
	l.AddItems(list...)
	l.SetSelected(0)

	t.SetStyle("list.item", tui.Style{Bg: tui.ColorDefault, Fg: tui.ColorDefault})
	t.SetStyle("list.item.selected", tui.Style{Bg: tui.ColorDefault, Fg: tui.ColorMagenta, Bold: tui.DecorationOn})

	root := tui.NewVBox(l)

	ui, err := tui.New(root)
	if err != nil {
		log.Fatal(err)
	}

	ui.SetTheme(t)
	ui.SetKeybinding("Esc", func() { ui.Quit() })
	ui.SetKeybinding("Enter", func() {
	})

	l.OnItemActivated(func(l *tui.List) {
		ui.Quit()
		fmt.Println(list[l.Selected()])
	})

	if err := ui.Run(); err != nil {
		log.Fatal(err)
	}
}
