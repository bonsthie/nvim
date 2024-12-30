# Keymap Shortcuts for Neovim

## **Leader Key**
- **`<leader>`**: `space key \' \'`

---

## **Normal Mode Shortcuts**

### **Navigations**
- **`<leader>gd`**: Go to definition and center the view.
- **`<C-d>`**: Scroll down and center the view.
- **`<C-u>`**: Scroll up and center the view.
- **`n`**: Jump to the next search result and center the view.
- **`N`**: Jump to the previous search result and center the view.

### **Editing**
- **`J`**: Merge lines and maintain cursor position.
- **`<leader>p`**: Paste and keep the buffer intact.
- **`<leader>y`**: Copy to the system clipboard.
- **`<leader>Y`**: Copy the current line to the system clipboard.
- **`<leader>d`**: Delete without affecting the buffer.
- **`Q`**: Disable Ex mode shortcut.
- **`<leader>s`**: Search and replace the word under the cursor.

### **LSP (Language Server Protocol)**
- **`<leader>fc`**: Format the current buffer.

### **Quickfix List**
- **`<C-k>`**: Jump to the next quickfix list item and center the view.
- **`<C-j>`**: Jump to the previous quickfix list item and center the view.
- **`<leader>k`**: Jump to the next location list item and center the view.
- **`<leader>j`**: Jump to the previous location list item and center the view.

### **Git Integration**
- **`<leader>gs`**: Open Git status using Fugitive.

### **Harpoon**
- **`<leader>a`**: Add the current file to Harpoon.
- **`<C-e>`**: Open Harpoon menu.
- **`<C-r>`**: Navigate to the first Harpoon file.
- **`<C-t>`**: Navigate to the second Harpoon file.
- **`<C-n>`**: Navigate to the third Harpoon file.
- **`<C-s>`**: Navigate to the fourth Harpoon file.

### **Miscellaneous**
- **`<C-f>`**: Open Tmux sessionizer.
- **`<leader>u`**: Toggle UndoTree.

---

## **Visual Mode Shortcuts**

- **`J`**: Move the selected block down.
- **`K`**: Move the selected block up.

---

## **Insert Mode Shortcuts**

- **`<C-c>`**: Exit insert mode.

---

## **Custom Plugin-Specific Shortcuts**

### **Telescope**
- **`<leader>ff`**: Find files.
- **`<C-p>`**: Find files in Git repository.
- **`<leader>ps`**: Search a string in the project.
- **`<leader>vh`**: Show help tags.

### **nvim-tree/oil.nvim**
- **`-`**: Open the parent directory.
