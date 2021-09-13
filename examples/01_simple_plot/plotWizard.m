classdef plotWizard < wizard
    % plotWizard
    % 
    % Toy example using a wizard to set plot properties. First run
    % the plotWizard command and go through the options. Once "Done"
    % is pressed the wizard closes. 
    % >> plotWizard;
    %
    % Once it's closed run:
    % >> plot(rand(1,100),wizardoutput{:})
    %


    properties
    end %properties

    methods
        function obj = plotWizard

            obj.pageConstructors = {@chooseColor,@chooseStyle,@chooseLineWidthMarkerSize};

            obj.renderPage(1)
        end

        function delete(obj)
            % Format the cached data for use in a plotting command.
            cDat = obj.cachedData;
            if length(cDat)<length(obj.pageConstructors)
                % Bail out if the cachedData are not complete
                return
            end
            obj.output = {'Color',cDat{1}.colorEditBox.value, ...
                        'LineStyle',cDat{2}.linestyle.String{cDat{2}.linestyle.value}, ...
                        'Marker',cDat{2}.markerstyle.String{cDat{2}.markerstyle.value}, ...
                        'MarkerSize',str2num(cDat{3}.markersize.value), ...
                        'LineWidth',str2num(cDat{3}.linewidth.value)};
        end
    end % methods

end % classdef
