%load('dataset_estratto.mat')
%numero_database = 2;

% Andiamo a calcolare la media dei cicli di volo di ciascun cluster
clc 
clear all
% load dei clusters
load('Clusters1.mat')

nc_cluster = zeros(1,6);
tempo_finale_cluster = zeros(1,6);
durata_volo_cluster = zeros(1,6);

for i = 1:6 
    cluster = sovraClustersTrain{i};

    nc = zeros(1,height(cluster));
    tempo_finale = zeros(1,height(cluster));
    tempo_medio_motore = zeros(1, height(cluster));

    for num_motore = 1:height(cluster)
        motore = cluster{num_motore};
%     
%         figure % plot delle condizioni operative
%         subplot(2,2,1)
%         plot(motore.Time, motore.alt)
%         quota_med = mean(motore.alt);
%         SD = std(motore.alt);
%         sopraSD = quota_med + SD;
%         sottoSD = quota_med - SD;
%         yline(quota_med,'r','LineWidth', 1.5)
%         yline(sopraSD,'y','LineWidth', 1.5)
%         yline(sottoSD,'y','LineWidth', 1.5)
%         title('alt')
%     
%         subplot(2,2,2)
%         plot(motore.Time, motore.Mach)
%         quota_med = mean(motore.Mach);
%         SD = std(motore.Mach);
%         sopraSD = quota_med + SD;
%         sottoSD = quota_med - SD;
%         yline(quota_med,'r','LineWidth', 1.5)
%         yline(sopraSD,'y','LineWidth', 1.5)
%         yline(sottoSD,'y','LineWidth', 1.5)
%         title('Mach')
%     
%         subplot(2,2,3)
%         plot(motore.Time, motore.TRA)
%         quota_med = mean(motore.TRA);
%         SD = std(motore.TRA);
%         sopraSD = quota_med + SD;
%         sottoSD = quota_med - SD;
%         yline(quota_med,'r','LineWidth', 1.5)
%         yline(sopraSD,'y','LineWidth', 1.5)
%         yline(sottoSD,'y','LineWidth', 1.5)
%         title('TRA')
%     
%         subplot(2,2,4)
%         plot(motore.Time, motore.T2)
%         quota_med = mean(motore.T2);
%         SD = std(motore.T2);
%         sopraSD = quota_med + SD;
%         sottoSD = quota_med - SD;
%         yline(quota_med,'r','LineWidth', 1.5)
%         yline(sopraSD,'y','LineWidth', 1.5)
%         yline(sottoSD,'y','LineWidth', 1.5)
%         title('T2')
%     
%         sgtitle(strcat("Test: Motore ",string(num_motore)))
%  
        %% calcolo del numero dei cicli di volo 
        smus = movmean(motore.alt,[20 20]); % il vettore delle altitudini "smussato"
        smus = motore.alt;
        massimi1 = islocalmax(smus,'MinSeparation',30); % è un vettore binario che rappresenta l'indice del massimo
        %massimi1(massimi1==0) = []; % tolgo tutti gli zeri del vettore massimi1
        tempi = zeros(length(massimi1),1);
        tempiOrig = time2num(motore.Time,"");
        
        for j = 1:length(massimi1)
            if massimi1(j) == 1
                tempi(j) = tempiOrig(j); % salvo gli istanti dei tempi dei massimi
            end
        end

       
        massimi = smus(massimi1);
        if num_motore == 14
            ciao = 1;
        end 
 
        plot(motore.Time,smus,motore.Time(massimi1),smus(massimi1),'r*')
        % vettore di numero di cicli nc
        nc(num_motore) = height(massimi); 
        
        % Determiniamo la durata totale della vita dei motori di ogni custer
        tempo_finale(num_motore) = time2num(motore.Time(end)); 

        tempo_medio_motore(num_motore) = (tempo_finale(num_motore) / nc(num_motore)) /3600;
    end 
    nc_cluster(i)  = mean(nc); % la media dei cicli di volo di ciascun cluster
    % tempo_finale_cluster(i) = mean (tempo_finale) / 3600; % tempo in ore
    tempo_finale_cluster(i) = mean (tempo_medio_motore); % tempo in ore

    durata_volo_cluster(i) = tempo_finale_cluster(i) ./ nc_cluster(i); %durata del singolo volo in ore

end 




        
    %%
    % for num_motore = 2:2%height(degradationDataTest{numero_database})
    %     motoreTest = sovraClustersValid{numero_database}{num_motore};
    % 
    %     figure
    % 
    %     subplot(2,2,1)
    %     plot(motoreTest.Time, motoreTest.alt)
    %     quota_med = mean(motore.alt);
    %     SD = std(motore.alt);
    %     sopraSD = quota_med + SD;
    %     sottoSD = quota_med - SD;
    %     yline(quota_med,'r','LineWidth', 1.5)
    %     yline(sopraSD,'y','LineWidth', 1.5)
    %     yline(sottoSD,'y','LineWidth', 1.5)
    %     title('alt')
    % 
    %     subplot(2,2,2)
    %     plot(motoreTest.Time, motoreTest.Mach)
    %     quota_med = mean(motoreTest.Mach);
    %     SD = std(motoreTest.Mach);
    %     sopraSD = quota_med + SD;
    %     sottoSD = quota_med - SD;
    %     yline(quota_med,'r','LineWidth', 1.5)
    %     yline(sopraSD,'y','LineWidth', 1.5)
    %     yline(sottoSD,'y','LineWidth', 1.5)
    %     title('Mach')
    % 
    %     subplot(2,2,3)
    %     plot(motoreTest.Time, motoreTest.TRA)
    %     quota_med = mean(motoreTest.TRA);
    %     SD = std(motoreTest.TRA);
    %     sopraSD = quota_med + SD;
    %     sottoSD = quota_med - SD;
    %     yline(quota_med,'r','LineWidth', 1.5)
    %     yline(sopraSD,'y','LineWidth', 1.5)
    %     yline(sottoSD,'y','LineWidth', 1.5)
    %     title('TRA')
    % 
    %     subplot(2,2,4)
    %     plot(motoreTest.Time, motoreTest.T2)
    %     quota_med = mean(motoreTest.T2);
    %     SD = std(motoreTest.T2);
    %     sopraSD = quota_med + SD;
    %     sottoSD = quota_med - SD;
    %     yline(quota_med,'r','LineWidth', 1.5)
    %     yline(sopraSD,'y','LineWidth', 1.5)
    %     yline(sottoSD,'y','LineWidth', 1.5)
    %     title('T2')
    % 
    %     sgtitle(strcat("Valid: Motore ",string(num_motore)))
    % end
