classdef viewWizard < wizard
    % viewWizard
    % 
    % Toy example showing how a wizard can be used to change settings in a different GUI

    % >> M=myViewClass
    % >> viewWizard(M);
    %


    properties
        externalView % This is the GUI we will apply settings to
    end %properties

    methods
        function obj = viewWizard(M)
            if nargin<1
                delete(obj)
                return
            end
            obj.externalView = M;
            obj.pageConstructors = {@chooseFoods,@chooseSampleName};

            obj.renderPage(1)
        end

        function delete(obj)

            % Set the foods
            checkedBoxes = structfun(@(x) x.value, obj.cachedData{1});
            foodFields = fields(obj.cachedData{1});
            obj.externalView.writeFoods(foodFields(find(checkedBoxes)));
   
        end
    end % methods

end % classdef
