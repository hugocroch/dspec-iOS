dspec-iOS
=========

A simple way to define and render UI specs on top of your iOS UI inspired by the Android library dspec from Lucas Rocha. https://github.com/lucasr/dspec


![sample1](https://github.com/hugocroch/dspec-iOS/blob/master/images/sample1.png)


There two way to add dspec :

    
    DesignSpecView *designView;
    
    - (void)viewWillAppear:(BOOL)animated {
    	[super viewWillAppear:animated];
    	DesignSpecView *designView = [[DesignSpecView alloc] 	initWithFrame:self.view.frame];
    	[[[[UIApplication sharedApplication] windows] objectAtIndex:0] addSubview:designView];
        [designView.designSpec loadSpecFromFileName:@"main_activity_spec"];
    }
    
    - (void)viewWillDisappear:(BOOL)animated {
    	[designView removeFromSuperview];
    }
   
   
Or you can simply add a UIView in your controller above everything.

![sample2](https://github.com/hugocroch/dspec-iOS/blob/master/images/sample2.png)


**NOTE**
In storyBoard, don't forget to set the background **clearColor** if you  want a _beautiful_ live preview of the baseline grid.

![sample3](https://github.com/hugocroch/dspec-iOS/blob/master/images/sample3.png)



