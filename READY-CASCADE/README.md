# READY-CASCADE

This is a ready-to-go implementation of the Cascade Make system, modified from its Greenstone origins to remove the more specialised requirements and add/improve upon certain functions.

### Automatic Setup

To use, simply copy this folder and rename, and run the init.bash script, with the name of your project

```bash
./init.bash YOUR_NAME_HERE
```

### Manual Setup

**setup.bash**
* Set the `package_desc` variable to the name of your project
* Change the name of the `$EXAMPLE_HOME` variable to one that suits your project. Remember this new name

**devel.bash**
* Replace all instances of `$EXAMPLE_HOME...` with your chosen name

**packages/CASCADE-MAKE-SCRIPTS/EXAMPLE_...**
* Replace all instances of `$EXAMPLE_HOME...` with your chosen name
