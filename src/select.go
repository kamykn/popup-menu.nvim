package main

import (
	"fmt"
	"github.com/manifoldco/promptui"
	"os"
)

func main() {
	templates := &promptui.SelectTemplates{
		Label:    "\r",
		Active:   "{{ . | cyan }}",
		Inactive: "{{ . }}",
		Selected: "\r",
		Details:  "\r",
		Help:     "\r",
	}

	prompt := promptui.Select{
		Items:        os.Args[1:],
		Templates:    templates,
		HideHelp:     true,
		HideSelected: true,
	}

	_, result, err := prompt.Run()

	if err != nil {
		fmt.Printf("Prompt failed %v\n", err)
		return
	}

	fmt.Printf("%s", result)
}
