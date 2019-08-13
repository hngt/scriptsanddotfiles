/* dotfile-linker.go
a simple linker which links up dotfiles will create symlinks of files in
scripts/ directory to $HOME/bin and will create directories and symlinks
from dotfiles/ directory to $HOME */
package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

func unique(elements []string) []string {
	encountered := map[string]bool{}

	for v := range elements {
		encountered[elements[v]] = true
	}

	result := []string{}
	for key := range encountered {
		result = append(result, key)
	}
	return result
}

func walker(path string) ([]string, []string) {
	var files, fullpaths []string

	err := filepath.Walk(path, func(path string, info os.FileInfo, err error) error {
		if info.IsDir() {
			return nil
		}
		fullpaths = append(fullpaths, path)
		files = append(files, info.Name())
		return nil
	})
	if err != nil {
		panic(err)
	}

	return files, fullpaths
}

func dotfile_gen(dotfile_path string) ([]string, []string) {
	var dotfile_relpaths, dotfile_reldirs []string
	dotfiles, dotfiles_paths := walker(dotfile_path)
	for i, dotfile_dir := range dotfiles_paths {
		if strings.Contains(dotfile_dir, dotfiles[i]) {
			dotfile_relpaths = append(dotfile_relpaths, dotfile_dir[len(dotfile_path)+1:])
			dotfile_reldir_split := strings.Split(dotfile_relpaths[i], "/")
			dotfile_reldirs = append(dotfile_reldirs, strings.Join(dotfile_reldir_split[:len(dotfile_reldir_split)-1], "/"))
		}
	}
	return dotfile_relpaths, dotfile_reldirs
}

func main() {
	dir, _ := os.Getwd()
	dotfile_dir := dir + "/dotfiles"
	home_dir := os.Getenv("HOME")
	script_dir := dir + "/scripts"
	script_loc := home_dir + "/bin"

	err := os.Mkdir(script_loc, 0700)
	if err != nil {
		fmt.Printf("Error: %s\n", err)
	}

	script_files, script_paths := walker(script_dir)
	dotfile_files, dotfile_dirs := dotfile_gen(dotfile_dir)

	for i := range script_paths {
		fmt.Printf("%s -> %s\n", script_paths[i], script_loc+"/"+script_files[i])
		err := os.Symlink(script_paths[i], script_loc+"/"+script_files[i])
		if err != nil {
			fmt.Printf("Error: %s\n", err)
		}
	}

	for _, dotfile_dir := range unique(dotfile_dirs) {
		fullpath := home_dir + "/" + dotfile_dir
		fmt.Printf("Creating directory %s\n", fullpath)
		err := os.MkdirAll(fullpath, 0700)
		if err != nil {
			fmt.Printf("Error: %s\n", err)
		}

	}

	for _, dotfile := range dotfile_files {
		fmt.Printf("%s -> %s\n", dotfile_dir+"/"+dotfile, home_dir+"/"+dotfile)
		err := os.Symlink(dotfile_dir+"/"+dotfile, home_dir+"/"+dotfile)
		if err != nil {
			fmt.Printf("Error: %s\n", err)
		}
	}

}
