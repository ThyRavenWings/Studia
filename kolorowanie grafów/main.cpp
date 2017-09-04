#include <iostream>
 #include <fstream>
int main()
{
	FILE *plik;
	plik=fopen("d.txt","w");
    const int VERT_NUM = 6; // WprowadŸ iloœæ wierzcho³ków
    const int COLOR_NUM = 4; // WprowadŸ iloœæ kolorów
    const int EDG_NUM = 9; // WprowadŸ iloœæ krawêdzi
 
    int vertices[VERT_NUM] = {0};
    int edges[EDG_NUM][2];
 
    // WprowadŸ wierzcho³ki kolejnych krawêdzi (numeracja zaczyna siê od 1)
    edges[0][0] = 1, edges[0][1] = 4; // 1. krawêdŸ
    edges[1][0] = 1, edges[1][1] = 5; // 2. krawêdŸ
    edges[2][0] = 2, edges[2][1] = 3; // ...
    edges[3][0] = 2, edges[3][1] = 4;
    edges[4][0] = 2, edges[4][1] = 6;
    edges[5][0] = 3, edges[5][1] = 4;
    edges[6][0] = 3, edges[6][1] = 6;
    edges[7][0] = 4, edges[7][1] = 5;
    edges[8][0] = 4, edges[8][1] = 6;
 
    bool right = true;
    int counter = 0;
 
    while (true)
    {
        for (int i = 0; i < EDG_NUM; i++)
        {
            if (vertices[edges[i][0] - 1] == vertices[edges[i][1] - 1])
            {
                right = false;
                break;
            }
        }
 
        if (right)
        {
            counter++;
            for (int i = 0; i < VERT_NUM; i++)
                fprintf(plik,"%d",vertices[i]);
            fprintf(plik,"\n");
        }
 
        vertices[0]++;
        for (int i = 0; i < VERT_NUM - 1; i++)
        {
            if (vertices[i] == COLOR_NUM)
            {
                vertices[i] = 0;
                vertices[i + 1]++;
            }
        }
        if (vertices[VERT_NUM - 1] == COLOR_NUM)
            break;
 
        right = true;
    }
 
    std::cin.get();
	fclose(plik);
 
    return 0;
}