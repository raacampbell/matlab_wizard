classdef myViewClass < handle
    % A view class that will be modified by the wizard

    properties
        hFig
        hAxes
        hPlot

        hButtonGroup
        hButtons % cell array of radio buttons
        hSampleText
        hFoodText

        foods % structure of foods by group (see below)
    end


    methods
        function obj=myViewClass
            obj.hFig = figure;
            obj.hFig.Position(4) = 700;
            obj.hFig.NumberTitle = 'off';
            obj.hFig.ToolBar = 'none';
            obj.hFig.MenuBar = 'none';   
            obj.hFig.Resize = 'Off';

            % Add some UI elements that will be modified by the wizard
            obj.addPlot;
            obj.addRadioButtons;

            obj.hSampleText = uicontrol(obj.hFig,'Style','edit', ...
                        'String', 'Sample Name', ...
                        'FontSize',12, ... 
                        'Position',[175,200,350,40]);

            obj.hFoodText = annotation(obj.hFig,'textbox', ...
                        'Units','Pixels', ...
                        'String', '', ...
                        'FontSize',14, ... 
                        'FitBoxToText','off', ...
                        'Position',[50,10,460,120]);


            % populate structure
            obj.genFoods;

        end


        function addPlot(obj)
            obj.hAxes = axes(obj.hFig, ...
                'Units', 'Pixels', ...
                'Position',[40,350,500,310]);
            obj.hPlot = plot(randn(1,400)+10);
        end %addPlot

        function addRadioButtons(obj)
            obj.hButtonGroup = uibuttongroup('Visible','off',...
                            'Units', 'Pixels', ... 
                            'Position',[30 150, 110, 130]);
                          
            % Create three radio buttons in the button group.
            obj.hButtons{1} = uicontrol(obj.hButtonGroup,'Style',...
                              'radiobutton',...
                              'String','Oranges',...
                              'Position',[10 80 100 30],...
                              'HandleVisibility','off');
                          
            obj.hButtons{2}  = uicontrol(obj.hButtonGroup,'Style','radiobutton',...
                              'String','Kiwis',...
                              'Position',[10 50 100 30],...
                              'HandleVisibility','off');

            obj.hButtons{3}  = uicontrol(obj.hButtonGroup,'Style','radiobutton',...
                              'String','Hedgehogs',...
                              'Position',[10 20 100 30],...
                              'HandleVisibility','off');
                          
            % Make the uibuttongroup visible after creating child objects. 
            obj.hButtonGroup.Visible = 'on';

            % Can programatically change the selected button like this:
            obj.hButtonGroup.SelectedObject = obj.hButtons{2};
        end %addRadioButtons


        function genFoods(obj)
            obj.foods.fruits = {'orange','apple','mango','tomato','grape','strawberry','plum','fig','lime','lemon','clementine'};
            obj.foods.tubers = {'potato','turnip','parsnip','carrot','beet','rutabaga','taro'};
            obj.foods.nuts = {'almonds','pistachio','walnut','cashew','pecan','peanut'};
            obj.foods.cakes = {'chiffon cake','sticky toffee pudding','baked Alaska','angel cake','Bakewell tart','carrot cake'};
            obj.foods.pies = {'spinach pie','turkey pie','steak and kidney pie','coq au vin pie','sausage and herring pie','chicken and apple pie','custard and turkey pie'};
        end %genFoods

        function writeFoods(obj,foodsToWrite)
            % foodsToWrite is a cell array of strings that matches fields in obj.foods
            tFoods = {};
            for ii = 1:length(foodsToWrite)
                if ~isfield(obj.foods, foodsToWrite{ii})
                    continue
                end
                tFoods = [tFoods, obj.foods.(foodsToWrite{ii})];
            end
            % Randomise
            tFoods = tFoods(randperm(length(tFoods)));
            obj.hFoodText.String = sprintf('%s, ', tFoods{:});
        end

    end % methods


end % classdef 