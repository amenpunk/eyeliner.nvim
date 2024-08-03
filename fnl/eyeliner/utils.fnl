;; [utils.fnl]
;; Shorthand versions of vim API and
;; functional programming functions (map, filter, iter, some?)

;; Abbreviated version of autocmd for the augroup Eyeliner
(fn set-autocmd [event opts]
  (let [merged (vim.tbl_deep_extend "force" {:group :Eyeliner} opts)]
    (vim.api.nvim_create_autocmd event merged)))

(local del-augroup vim.api.nvim_del_augroup_by_name)
(local create-augroup vim.api.nvim_create_augroup)
(local get-current-line vim.api.nvim_get_current_line)

;; Returns a tuple [y x]
(fn get-cursor []
  (vim.api.nvim_win_get_cursor 0))

(fn get-hl [name]
  (vim.api.nvim_get_hl_by_name name true))

(fn set-hl [name color]
  (vim.api.nvim_set_hl 0 name {:fg color :default true}))

(fn add-hl [ns-id hl-group x]
  (let [[y _] (get-cursor)]
    (vim.api.nvim_buf_add_highlight 0 ns-id hl-group (- y 1) x (+ x 1))))

;;; Helper functions
(fn map [f list]
  (icollect [_ val (ipairs list)]
    (f val)))

(fn filter [f list]
  (icollect [_ val (ipairs list)]
    (if (f val)
        val)))

(fn iter [f list]
  (each [_ val (ipairs list)]
    (f val)))

(fn some? [f list]
  (var status false)
  (each [_ val (ipairs list)]
    (if (f val)
        (set status true)))
  status)

(fn exists? [list x]
  (some? (λ [y] (= y x)) list))

(fn empty? [list] (= (length list) 0))


{: set-autocmd
 : del-augroup
 : create-augroup
 : get-current-line
 : get-cursor
 : get-hl
 : set-hl
 : add-hl
 : map
 : filter
 : iter
 : some?
 : exists?
 : empty?}
