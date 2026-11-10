vim.filetype.add({
    extension = {
        hm   = 'objc',
        m    = 'objc',
        hmm  = 'objcpp',
        mm   = 'objcpp',
        vert = 'glsl',
        frag = 'glsl',
        hlsl = 'hlsl',
        caddy = 'caddy',
    },
    filename = {
        ["compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["docker-compose.yml"] = "yaml.docker-compose",
        Caddyfile = 'caddy',
        ['.env'] = 'env',
        ['dot-env'] = 'env',
    },
    pattern = {
        ['%.env%.[%w_.-]+'] = 'env',
        ['dot%-env%.[%w_.-]+'] = 'env',
    },
})
