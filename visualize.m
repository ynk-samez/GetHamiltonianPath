clf;
clear;
n = 16; %node size 
tournamentMatrix = zeros(n);
for i = 1:n
    for j = i+1:n
        tournamentMatrix(i, j) = randi([0, 1]);
        tournamentMatrix(j, i) = 1 - tournamentMatrix(i, j);
    end
end
[row,col]=find(tournamentMatrix==1);
P=[row(1),col(1)];
G = digraph(tournamentMatrix);
Selectable=1:n;

Idx=find(Selectable==row(1));
Selectable(Idx)=[];
Idx=find(Selectable==col(1));
Selectable(Idx)=[];
for cnt=1:n-2
figure(1)
    rIdx= randi(length(Selectable));
    w=Selectable(rIdx);
    if tournamentMatrix(w,P(1))==1
        P=[w,P];
    elseif tournamentMatrix(P(end),w)==1
        P=[P,w];
    else
        disp("w:"+w)
        cand=find(tournamentMatrix(w,:)==1);
        for i=1:length(P)
            if ismember(P(i),cand)
                index=i;
                break;
            end
        end
        P = [P(1:index-1) w P(index:end)];
    end

    Idx=find(Selectable==w);
    Selectable(Idx)=[];

    h=plot(G, 'Layout', 'circle', 'NodeColor', 'r', 'EdgeColor', 'b','MarkerSize',15,'LineWidth',0.001);
    h.NodeFontSize=15;
    highlight(h,P,'EdgeColor', 'g', 'LineWidth', 10)
    pause(0.1)
drawnow;
end
