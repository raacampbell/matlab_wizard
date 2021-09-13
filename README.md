

`wizard` is a low-level framework for making GUI wizards using pure MATLAB and no GUI designer tools. 
The framework is highly flexible but requires the developer to be skilled in object oriented programming. 
For those less familiar with OO, the class contains extensive comments.


### Installation
Add the `code` directory to your MATLAB path.

### Examples
`cd` to one of the directories within the `examples` directory. 
Run the wizard function within that. e.g.

```
>> cd examples/01_simple_plot
>> help(plotWizard)
>> plotWizard;
>> plot(rand(1,100),wizardoutput{:})
```

Note there are other classes files in that folder. 
These are the pages for the plotWizard and are not called from the command line. 


### Dependencies
There are no toolboxes required to run `wizard`. 


### NOTE
`wizard` is under heavy development and should currently be considered unstable.
