ict_utility Cookbook
====================
This is just a bunch of ddds and ends



Requirements
------------
None


Attributes
----------
None



Usage
-----
#### ict_utility::default


e.g.
Just include `ict_utility` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ict_utility]"
  ]
}
```

#### ict_utility::web

This is the base with a LAMP stack

e.g.
Just include `ict_utility::web` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ict_utility::web]"
  ]
}
```

Contributing
------------
No need, really.

License and Authors
-------------------
Authors: Adam Preston (aprestion@rti.org)
