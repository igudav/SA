function res = plotFT(hFigure, fHandle, fFTHandle, step, inpLimVec, outLimVec)

    figure(hFigure);
    SPlotInfo = hFigure.UserData;
     
    if ~isempty(SPlotInfo)
        % clearing axis and setting handlers
        axHandler1 = SPlotInfo.ax(1);
        subplot(axHandler1);
        cla;
        axis manual;
        hold on;
        axHandler2 = SPlotInfo.ax(2);
        subplot(axHandler2);
        cla;
        axis manual;
        hold on;
    else 
        axHandler1 = subplot(1, 2, 1);
        axis manual;
        hold on;
        axHandler1.XAxisLocation = 'origin';
        axHandler1.YAxisLocation = 'origin';
        axHandler2 = subplot(1, 2, 2);
        axis manual;
        hold on;
        axHandler2.XAxisLocation = 'origin';
        axHandler2.YAxisLocation = 'origin';
        hFigure.Position(4) = 350;
    end

    a = inpLimVec(1);
    b = inpLimVec(2);
    T = b - a;
    N = ceil(T / step);
    step = T / N;
    f_periodic = @(t) fHandle(a + mod(t - a, b - a));
    t = linspace(-step / 2, T - step / 2, N);
    f_discrete = f_periodic(t);
    four_numeric = step * fft(f_discrete);
    four_step = 2 * pi / T;
    
    if nargin == 5
        c = -pi / step;
        d = pi / step;
    else 
        c = outLimVec(1);
        d = outLimVec(2);
    end

    idx_l = floor(c / four_step);
    idx_r = ceil(d / four_step);
    lmbd = idx_l:idx_r;
    idx = mod(lmbd, N) + 1;
    lmbd = lmbd * four_step;
    four_numeric = four_numeric(idx(1:length(lmbd)));
    
    y_min = min(min(real(four_numeric)), min(imag(four_numeric)));
    y_max = max(max(real(four_numeric)), max(imag(four_numeric)));
    if y_min == y_max
        y_min = y_min - 0.5;
        y_max = y_max + 0.5;
    end

    subplot(axHandler1);
    plot(lmbd, real(four_numeric), 'b');
    if ~isempty(fFTHandle)
        plot(lmbd, real(fFTHandle(lmbd)), 'r');        
    end
    xlabel('$\lambda$', 'interpreter', 'latex');
    ylabel('$\Re F(\lambda)$', 'interpreter', 'latex');
    if isempty(SPlotInfo) || nargin > 5
        axis([c d y_min y_max]);
    end
    %axHandler1.OuterPosition(4) = 0.9;
    hold off;

    subplot(axHandler2);
    plot(lmbd, imag(four_numeric), 'b');
    if ~isempty(fFTHandle)
        plot(lmbd, imag(fFTHandle(lmbd)), 'r');        
    end
    xlabel('$\lambda$', 'interpreter', 'latex');
    ylabel('$\Im F(\lambda)$', 'interpreter', 'latex');
    if isempty(SPlotInfo) || nargin > 5
        axis([c d y_min y_max]);
    end
    %axHandler2.OuterPosition(4) = 0.9;
    hold off;

    SPlotInfo.ax(1) = axHandler1;
    SPlotInfo.ax(2) = axHandler2;

    if ~isempty(fFTHandle)
        lgd = legend('numeric FT', 'analitical FT', 'interpreter', 'latex',...
            'Position', [0.42 0.8 0.2 0.1]);        
    else 
        lgd = legend('numeric FT', 'interpreter', 'latex',...
            'Position', [0.42 0.8 0.2 0.05]);
    end

    hFigure.UserData = SPlotInfo;

    res.nPoints = N;
    res.step = step;
    res.inpLimVec = inpLimVec;
    res.outLimVec = [c d];

end
