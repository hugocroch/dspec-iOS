dspec-iOS
=========

A simple way to define and render UI specs on top of your iOS UI inspired by the Android library dspec from Lucas Rocha.

There two way to add dspec :

 There two way to init dspec


    
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



