function ftype(h)
xlabel('BM (nm)','FontWeight','bold','FontName','Arial');
ylabel('Frequency','FontWeight','bold','FontName','Arial');
     ax = gca;
     ax.XAxis.MinorTick = 'on';
     ax.XAxis.MinorTickValues = 0:5:70;
     ax.XAxis.TickValues = 0:10:70;
     xlim(ax,[0 70]);
     ylim(ax,[0 0.3]);
     set(ax,'FontSize',16,'XMinorTick','on');